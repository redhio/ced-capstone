pragma solidity ^0.4.18;

/*MLPurchase is a contract used to receive a request from a customer to run data against an ML (machine learning) model.
It receives the modelID, customerID, contractSLA, contractRate and seller address from a web3 interface to initiate the contract.

Upon deployment, the reportData function would provide details to a web3 interface which would send the request to an ML model (in this example we are using BigML).
The ML model would process the request and respond back to the MLPurchaseEnd function with an accuracy value, verification ID and contract value.  The reported accuracy is tested against the contractSLA and 
the verification ID is tested against the customer ID to ensure this result is matched to the correct contact (using custID in this example for simplicity, the verifyID
would be more complicated in practice.)

If the verify ID and customer ID match, the MLPurchaseEnd function releases the funds.  If not, the contract reverts. */

contract MLPurchase{
    
    /*variables will be captured using web3 app, sent by the customer end-user*/
    
    /*private variables, need to add data variables to capture data for BigML */ 
    
    uint private modelID;  // customer indicates which ML model to run using an ID
    uint private custID;  // web3 app would automatically send customer account number based on user login, here we just enter it via remix
    uint private contractSLA;  // stores the min % accuracy the model must produce for contract to be valid, would be sent based on customer account, here we just enter it via remix
    uint private contractRate;  // stores the contract rate ($charged to the cust) in wei, would be sent based on customer account, here we just enter it via remix
    address private buyer;  //address of the customer buying the service

    /*public variables */
    address public seller;  //address of the company selling the service
    
    /* Receives inputs from web3 apps and stores the variables */
    function MLPurchase(uint _contractRate, uint _contractSLA, uint _custID, uint _modelID, address _seller) public {
        modelID = _modelID;
        custID = _custID;
        contractSLA = _contractSLA;
        contractRate = _contractRate;
        seller = _seller;

        buyer = msg.sender;
        
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

    
    //---> BigML land --> input data and criteria sent to BigML via javascript run in web3
    // ---> BigML land ---> model runs, returns result & accuracy from BigML via javascript run in web3
    
    
    /*public variables, need to add variables to receive result from BigML*/
    uint public verifyID; //verification ID confirms that results from model "match" the request sent, for purpose of this example we are setting it to custID.  The 2 must match for contract to execute
    uint public MLAcc;  //% accuracy of ML model reported from BigML
    
    /*captures verifyID and MLAcc from BigML output via web3, also sends the wei amount - these values need to be entered via remix*/    
    function MLPurchaseEnd(uint _verifyID, uint _MLAcc) public payable{
        
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
