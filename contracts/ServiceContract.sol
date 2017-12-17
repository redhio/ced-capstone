pragma solidity ^0.4.8;

/* Sample only - Not for Submission */

contract ServiceContract {
    //  This is a generic contract for a service
    address public owner;
    uint public xparam;
    enum State { Created, Locked, Inactive } // Enum
    enum ModelType { Iris, Iris2, SomethingElse } // Enum
    
    address public buyer;
    address public seller;
    address public arbiter;
    int public model;
  
    function ServiceContract(address _seller, address _arbiter, int _model) public {
        buyer = msg.sender;
        seller = _seller;
        arbiter = _arbiter;
        model = _model;
    }



 }
