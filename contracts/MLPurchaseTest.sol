pragma solidity ^0.4.18;

/*MLPurchase is parent contract used to read variables from the user (via web3 app) and store in contract.
Information also stored is the buyer and seller address.  Seller address is known because it belongs to the machine learning (ML) provider.
*** do not send ether/wei with this contract, it is only meant to store/read data.

MLPurchaseEnd completes the purchase by receiving value sent with the contract, taking the same variables used by MLPurchase and also receiving new data from the ML model.
It tests the SLA and Verify values to confirm the response is a valid response.  It also checks that the value sent in this contract matches the contract rate.
If all cases test true then it releases the funds.  */


contract MLPurchase{
    
    /*variables will be captured using web3 app, sent by the customer end-user*/
    
    /*private variables */ 
    
    uint private modelID;  // customer indicates which ML model to run using an ID
    uint private custID;  // web3 app would automatically send customer account number based on user login, here we just enter it via web3 app
    uint private contractSLA;  // stores the min % accuracy the model must produce for contract to be valid, would be sent based on customer account, here we just enter it via web3 app
    uint private contractRate;  // stores the contract rate ($charged to the cust) in wei, would be sent based on customer account, here we just enter it via web3 app
    
    /*public variables */
    address public seller;
    address public buyer;
    
    /* Receives inputs from web3 apps and stores the variables */
    function MLPurchase(uint _contractRate, uint _contractSLA, uint _custID, uint _modelID) public{
        modelID = _modelID;
        custID = _custID;
        contractSLA = _contractSLA;
        contractRate = _contractRate;

        buyer = msg.sender;
        seller = 0x6DecBBC87dd79F57010db7110df25B17bB5F4723;
    }
    
    /* Ensures that only the customer can execute this contract*/
    modifier onlyBuyer{
        require(msg.sender == buyer);
        _;
    }
    
    /* Reports variables back to web3 interface */
    function reportData() public constant returns(uint ContractRate, uint ContractSLA, uint CustID, uint ModelID, address Buyer){
        return (contractRate, contractSLA, custID, modelID, buyer);
    }
}
    

    //---> BigML land --> input data and criteria sent to BigML via javascript run in web3
    // ---> BigML land ---> model runs, returns result & accuracy from BigML via javascript run in web3
    
    
contract MLPurchaseEnd is MLPurchase{

    /*public variables*/
    uint public verifyID; //verification ID confirms that results from model "match" the request sent, for purpose of this example we are setting it to custID.  The 2 must match for contract to execute
    uint public MLAcc;  //% accuracy of ML model reported from BigML
    
    /*captures variables from parent contract and from BigML output via web3*/    
    function MLPurchaseEnd(uint _verifyID, uint _MLAcc, uint contractRate, uint contractSLA, uint custID, uint modelID) MLPurchase(contractRate, contractSLA, custID, modelID) public payable{
        
        /* sets variables and tests if the verifyID matches and if the contractRate is equal to the value sent in the contract and accuract from model matches the SLA*/
        verifyID = _verifyID;
        require(verifyID == custID);
        require(contractRate == msg.value);
        
        MLAcc = _MLAcc;
        
        /* if everything above mathes, validate accuracy of model met SLA expectations and release the funds, if not, revert the contract*/
        {
        if(MLAcc >= contractSLA){
            seller.transfer(msg.value);
            }
            else{revert();
            }
        }
      
    }
}
