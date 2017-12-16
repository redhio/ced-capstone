pragma solidity ^0.4.11;
/* ced-capstone - This contract governs the transaction for a remote machine learning service.  
* The three entities which interact with the contract are the buyer, seller, and the external remote services.
*
* Friday V0.0.3
*/
contract Purchase {
    uint public value;
    address public seller;
    address public buyer;
    address public service;
    int public sla;
    int public slAccuracy;
    
    enum State { Created, Locked, Inactive }
    State public state;
    /*
    * MLaaS - These should be in an abstracted class specific to the machine learning model 
    */
    uint public modelID;
    uint public petalLength;
    uint public petalWidth;
    uint public sepalLength;
    string public prediction;
    

    /* Set the purchase price requirement of the remote machine learning service. */
    function Purchase(uint _modelID, uint _petalLength, uint _petalWidth, uint _sepalLength) public payable {
        seller = msg.sender;
        require(  2  == msg.value);
        modelID = _modelID;
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
    /* Check to see the message was sent by the RemoteService */
    modifier onlyService() {
        require(msg.sender == service);
        _;
    }
    /* Check to see the 'Service Level Acheived is greater or equal to Service Level Agreed' for the machine learning RemoteService */
    modifier isSLA() {
        require(slAccuracy >= sla);
        _;
    }
    /* Check to see the seller is not a liar */
    modifier isLiar() {
        require(slAccuracy < sla);
        _;
    }
    /* Restrict the function to only a certain State.  Useful to step through a sequence of events*/
    modifier inState(State _state) {
        require(state == _state);
        _;
    }
    /* Define all of the contract events here.  One for each state  */
    event Aborted();
    event PurchaseConfirmed();
    event ServiceReceived();

    /* Abort the purchase and reclaim the ether by the buyer or seller before
    *  the contract is locked for servicing. */
    function abort() public onlySeller inState(State.Created) {
        Aborted(); /* FIRE the Aborted Event */
        state = State.Inactive;
        seller.transfer(this.balance);
    }

    /* Confirm the purchase and the price to further lock the ether until the service is received. confirmReceived()*/
    function confirmPurchase() public inState(State.Created) isEqual(msg.value == (2 * value)) payable {
        PurchaseConfirmed(); /* FIRE the PurchaseConfirmed Event */
        buyer = msg.sender;
        state = State.Locked;
    }

    /* Confirm that the buyer has received the prediction, sla and can unlocked the Ether. */
    function confirmReceived() public onlyBuyer isSLA inState(State.Locked)
    {
        if (slAccuracy >= sla){
            ServiceReceived(); /* FIRE the ServiceReceived Event */
            state = State.Inactive; /* Change the state to inactive to complete the final state. */
            /* NOTE: This allows both the buyer and the seller to block the refund - the withdraw pattern should be used. */
            buyer.transfer(value);
            seller.transfer(this.balance);
        }
        else{revert();}
    }
    /* Just playing around with a way to destroy the contracty to that it is not usable anymore. */
    function ripContract() public onlySeller isLiar {
         selfdestruct(1);
    }
}
