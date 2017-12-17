pragma solidity ^0.4.11;
/* ced-capstone - This contract governs the transaction for a remote machine learning service.  
* The three entities which interact with the contract are the buyer, seller, and the external remote services.
*  For a Utility model, we would like this to be like a Pre-Authorized-Debit (PAD)
* Sunday V1.2.50
*/
contract Purchase {
    uint public value;
    /* These are roles for this contract.  This is a four (4) entity service agreement with a potential for 
    *  whitelisted operators.  By default he WL is to incude at least the buyer address */
    address public seller;
    address public buyer;
    address public operator;
    address public service;
    /* These are the contract terms and agreement */
    uint public modelID;  // customer indicates which ML model to run using an ID
    uint public slAccuracy;
    uint public contractSLA;  // stores the min % accuracy the model must produce for contract to be valid, would be sent based on customer account, here we just enter it via web3 app
    uint public contractRate;  // stores the contract rate ($charged to the cust) in wei, would be sent based on customer account, here we just enter it via web3 app
    
    enum State { Created, Locked, Inactive }
    State public state;
    /*
    * MLaaS - These should be in an abstracted class specific to the machine learning model 
    */
    uint public petalLength;
    uint public petalWidth;
    uint public sepalLength;
    string public prediction;
    

    /* Set the purchase price and model requirement of the remote machine learning service. Purchase price is hardcoded at 2ether*/
    function Purchase(uint _modelID, uint _contractRate) public payable {
        require( contractRate  == msg.value); /* Check the funds before we burn any additional gas */
        seller = msg.sender;
        value = msg.value;
        modelID = _modelID;
        contractRate = _contractRate ;
        
    }
    /* Set the purchase price requirement of the remote machine learning service. */
    function Predict( uint _petalLength, uint _petalWidth, uint _sepalLength) public payable onlyBuyer {
        require( contractRate  == msg.value); /* Check the funds before we burn any additional gas */
        petalLength = _petalLength;
        petalWidth = _petalWidth;
        sepalLength = _sepalLength;        
    }
    /* boolean logical function */
    modifier isEqual(bool _condition) {
        require(_condition);
        _;
    }
    /* Check to see the message was sent by the Buyer */
    modifier onlyBuyer() {
        require(msg.sender == buyer);
        _;
    }
    /* Check to see the message was sent by the Seller */
    modifier onlySeller() {
        require(msg.sender == seller);
        _;
    }
    /* Check to see the message was sent by the Seller who is the owner, same as onlySeller() */
    modifier isOwner() {
        require(msg.sender == seller);
        _;
    }
    /* Check to see the message was sent by the RemoteService */
    modifier onlyService() {
        require(msg.sender == service);
        _;
    }
    /* Check to see the 'Service Level Acheived is greater or equal to Service Level Agreed' for the machine learning RemoteService */
    modifier isSLA() {
     require(slAccuracy >= contractSLA);
        _;
    }
    /* Check to see the seller is not a liar */
    modifier isLiar() {
        require(slAccuracy < contractSLA);
        _;
    }
    /* Restrict the function to only a certain State.  Useful to step through a sequence of events*/
    modifier inState(State _state) {
        require(state == _state);
        _;
    }
    /* Define all of the contract events here.  One for each state  */
    event Aborted();
    event PurchaseConfirmed(address buyer, address seller, uint amount, uint256 sla);
    event PredictionReceived();

    /* Abort the purchase and reclaim the ether by the buyer or seller before
    *  the contract is locked for servicing. */
    function abort() public onlySeller inState(State.Created) {
        Aborted(); /* FIRE the Aborted Event */
        state = State.Inactive;
        seller.transfer(this.balance);
    }

    /* Confirm the purchase contract and the price to further lock the ether until the service is received. confirmReceived()*/
    function confirmPurchase() public inState(State.Created) isEqual(msg.value == (2 * value)) payable {
        PurchaseConfirmed(buyer,seller,value,contractSLA); /* FIRE the PurchaseConfirmed Event */
        buyer = msg.sender;
        state = State.Locked;
    }

    /* Confirm that the buyer has received the prediction, sla and can unlocked the Ether. */
    function confirmReceived() public onlyBuyer isSLA inState(State.Locked)
    {
        if (slAccuracy >= contractSLA){
            PredictionReceived(); /* FIRE the PredictionReceived Event */
         state = State.Inactive; /* Change the state to inactive to complete the final state. */
            /* NOTE: This allows both the buyer and the seller to block the refund - the withdraw pattern should be used. */
            buyer.transfer(value);
            seller.transfer(this.balance);
        }
        else{revert();}
    }
    
    /* Just playing around with a way to destroy the contract to that it is not usable anymore. 
    *  Uses teh sellers address as th owner */
    function ripContract() public onlySeller isLiar {
         selfdestruct(seller);
    }
}
