pragma solidity ^0.4.11;
contract Arbitrator {

  address public buyer;
  address public seller;
  address public arbiter;

  function EscrowFunds(address _seller, address _arbiter) public {
    buyer = msg.sender;
    seller = _seller;
    arbiter = _arbiter;

  }

  function payoutToSeller() public {
    if(msg.sender == buyer || msg.sender == arbiter) {
      seller.transfer(this.balance);  
    } 
  }

  function refundToBuyer() public {
    if(msg.sender == seller || msg.sender == arbiter)  {
      buyer.transfer(this.balance);
    } 
  }

  function fund() public payable returns (bool)   {
    return true;
  }

  function getBalance()  public constant returns (uint) {
    return this.balance;
  }

}
