pragma solidity ^0.4.11;
/* ced-capstone - We used a basic  purchase contract to govern the Transaction

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
    modifier condition(bool _condition) {
        require(_condition);
        _;
    }
    modifier onlyBuyer() {
        require(msg.sender == buyer);
        _;
    }
    modifier onlySeller() {
        require(msg.sender == seller);
        _;
    }
    modifier inState(State _state) {
        require(state == _state);
        _;
    }
    event Aborted();
    event PurchaseConfirmed();
    event ServiceReceived();

    /// Abort the purchase and reclaim the ether.
    /// Can only be called by the seller before
    /// the contract is locked.
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
        condition(msg.value == (2 * value))
        payable
    {
        PurchaseConfirmed();
        buyer = msg.sender;
        state = State.Locked;
    }

    /// Confirm that you (the buyer) received the item.
    /// This will release the locked ether.
    function confirmReceived() public
        onlyBuyer
        inState(State.Locked)
    {
        if (serviceAccuracy == 1){
        ServiceReceived();
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        state = State.Inactive;

        // NOTE: This actually allows both the buyer and the seller to
        // block the refund - the withdraw pattern should be used.

        buyer.transfer(value);
        seller.transfer(this.balance);
        }
        else{revert();}
    }
}
