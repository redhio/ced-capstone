pragma solidity ^0.4.8;

contract mlStart {
    
    string constant modelID;  // stores the MLmodel to run
    string constant custID;  // stores the custID
    uint constant contractSLA;  // stores the min. % accuracy of model
    uint constant contractRate;  // stores the contract rate ($charged to the cust)
    
    uint startContractID = msg.sender;
    
    bool constant releaseDollars;
    
    function receiveInput(string _modelID, string _custID, string _contractSLA, uint _contractRate) returns (uint startContractID)
    // Recevies inputs from user to specify which MLmodel is being run, the CustID, the contract SLA (which is the min. % accuracy of model) 
    // and the contract rate ($ charged to cust for service).  This rate is entered as value into the smart contract and is held in "escrow" by the contract.
    
    //  This contract is submitted by the user and mined on the blockchain.  The user experience is similar to pressing "execute model" process in Hyperion. 
    //  For MVP, this will be a simple web3 form that allows user to enter inputs and click a "Go!" button.

    function releaseFunds(bool _releaseDollars);
    // Receives input from child contract.
    // Tests -> if bool = true, transer funds from sender account to recipient account.
    // -> if bool = false, release funds back to sender.
    

    {
    
}