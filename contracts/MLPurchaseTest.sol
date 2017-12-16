pragma solidity ^0.4.18;

contract mortal {
    /* Define variable owner of the type address */
    address owner;

    /* This function is executed at initialization and sets the owner of the contract */
    function mortal() { owner = msg.sender; }

    /* Function to recover the funds on the contract */
    function contractAbort() { if (msg.sender == owner) selfdestruct(owner); }
}


contract MLPurchase is mortal{
    /*Define variables */ 
    
    //1. receive input from user for modelID, custID, contractSLA & contractRate
    // set buyer address (person executing) & buer to send funds
    // set seller address (this could be hardcoded)
    
    uint private modelID;  // stores the MLmodel to run
    uint private custID;  // stores the custID
    uint private contractSLA;  // stores the min. % accuracy of model as decimal
    uint private contractRate;  // stores the contract rate ($charged to the cust) in ether
    
    //public value;
    address public seller;
    address public buyer;
    
    /* This runs when the contract is executed */
    function MLPurchase(uint _contractRate, uint _contractSLA, uint _custID, uint _modelID) public{
        modelID = _modelID;
        custID = _custID;
        contractSLA = _contractSLA;
        contractRate = _contractRate;

        buyer = msg.sender;
        seller = 0x6DecBBC87dd79F57010db7110df25B17bB5F4723;
    }
    
    modifier estRate {
        require(2 == contractRate);
        _;
    }
    
   // modifier onlyBuyer {
     //   require(msg.sender == buyer);
     //   _;
    //}
    
    function reportData() public constant returns(uint ContractRate, uint ContractSLA, uint CustID, uint ModelID, address Buyer){
        return (contractRate, contractSLA, custID, modelID, buyer);
    }
}
    

    //---> ML land --> input data and criteria sent to BigML
    // ---> ML land ---> model runs, returns result & accuracy
    
    
    //2. receive BigML output & accuracy
    // test accuracy & buyer address to verify
    // release funds

contract MLPurchaseEnd is MLPurchase{

    uint public verifyID;
    uint public MLAcc;
        
    function MLPurchaseEnd(uint _verifyID, uint _MLAcc, uint contractRate, uint contractSLA, uint custID, uint modelID) MLPurchase(contractRate, contractSLA, custID, modelID) public payable{
        
        verifyID = _verifyID;
        require(verifyID == custID);
        require(contractRate == msg.value);
        
        MLAcc = _MLAcc;
        
        {
        if(MLAcc >= contractSLA){
            seller.transfer(msg.value);
            }
            else{revert();
            }
        }
      
    }
}
