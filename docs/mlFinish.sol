pragma solidity ^0.4.8;

import "./mlStart.sol";

contract mlFinish {
    
    uint constant verifyID;
    uint constant modelAccResult;
    uint constant modelAnswer;
    
  
    function metSLA(uint _contractSLA, uint verifyID, string modelAccResult ) returns (bool releaseDollars)
    // Test if contractSLA <= modelAccResult && if verifyID = startContractID then releaseDollars = "true"
    // else releaseDollars = "false"
    
    function logResults(uint _modelAccResult, uint verifyID, uint modelAnswer)
    // submits the values to the smart contract to register them on the blockchain
    {
    