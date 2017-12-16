pragma solidity ^0.4.11;
/* ced-capstone - This contract governs the transaction for a remote service.  
* 
*
*
*/
contract Purchase {
    uint public value;
    address public seller;
    address public buyer;
    address public service;
    int public serviceAccuracy;
    
    enum State { Created, Locked, Inactive }
    State public state;

    // Ensure that `msg.value` is equal to our selling price
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
    function abort() public
        onlySeller
        inState(State.Created)
    {
        Aborted();
        state = State.Inactive;
        seller.transfer(this.balance);
    }

    /// Confirm the purchase as buyer.
    /// Transaction has to include `2 * value` ether.
    /// The ether will be locked until confirmReceived
    /// is called.
    function confirmPurchase() public
        inState(State.Created)
        isEqual(msg.value == (2 * value))
        payable
    {
        PurchaseConfirmed();
        buyer = msg.sender;
        state = State.Locked;
    }

    /* Confirm that the buyer has received the prediction, sla and can unlocked the Ether. */
    function confirmReceived() public
        onlyBuyer
        inState(State.Locked)
    {
        if (serviceAccuracy == 1){
        ServiceReceived();
        /* Change the state to inactive to complete the final state. */
        state = State.Inactive;

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
