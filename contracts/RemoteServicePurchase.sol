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
    int public serviceAccuracy;
    
    enum State { Created, Locked, Inactive }
    State public state;
    /* These should be in an abstracted class specific to the machine learning model */
    uint public petal_length;
    uint public petal_width;
    uint public sepal_length;
    string public prediction;
    

    /* Set the purchase price requirement of the remote machine learning service. */
    function Purchase() public payable {
        seller = msg.sender;
        require(  2  == msg.value);
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
    /* Restrict the function to only a certain State.  Useful to step through a sequence of events*/
    modifier inState(State _state) {
        require(state == _state);
        _;
    }
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
    function confirmReceived() public onlyBuyer inState(State.Locked)
    {
        if (serviceAccuracy == 1){
        ServiceReceived(); /* FIRE the ServiceReceived Event */
        state = State.Inactive; /* Change the state to inactive to complete the final state. */

        /* NOTE: This allows both the buyer and the seller to block the refund - the withdraw pattern should be used. */

        buyer.transfer(value);
        seller.transfer(this.balance);
        }
        else{revert();}
    }
    /* */
    function ripContract() public onlySeller {
         selfdestruct(1);
    
    }
}
