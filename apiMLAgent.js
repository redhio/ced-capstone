
var request = require('request');
var reqprom = require('request-promise');
var curl = require('curlrequest');
var web3 = require('web3');

/**********************************************************************************************
 * 
 * BigML JSON API Interface
 * 
 *********************************************************************************************/
var BIGML_USERNAME='donhagell';
var BIGML_API_KEY='8224e14ebb93f8f81268b9593b57d8eb920575d0';
var BIGML_AUTH="username="+BIGML_USERNAME+";api_key="+BIGML_API_KEY;
var Dsource_resID = '';
var headers = { 'content-type': 'application/json' };

/************************************************************  
*   Point datasource from remote file RF
*   returns datasourceID RF
*************************************************************/
var dataString = '{"remote": "https://static.bigml.com/csv/iris.csv"}';
var optionsRF = {
    url: 'https://bigml.io/source?' + BIGML_AUTH ,
    method: 'POST',
    headers: headers,
    body: dataString
}; // console.log(options);
function callbackRF(error, response, body) {
    if (!error && response.statusCode == 200) {
        console.log(body);
        console.log(body['resource']);
		
    }
	console.log(response);
}
//request(optionsRF, callbackRF);


/************************************************************  
*   Upload datasource from @file local FI
*   returns datasourceID FI
*************************************************************/
var optionsFI = {
    url: 'https://bigml.io/source?' + BIGML_AUTH ,
    headers: headers,
	file: '@iris.csv',
	'limit-rate': '500k',
	encoding: null
}; // console.log(options);
function callbackFI(error, response, body) {
    if (!error && response.statusCode == 200) {
		console.log("\n\nexc:" + JSON.stringify(response) );
        //console.log(response.headers['content-type'])
        //console.log(response.headers['data'])
    }
	console.log("done");
}
//request(optionsFI, callbackFI) ;


/************************************************************  
*   Create a dataset from the datasourceID FI. 
*   returns datasetID DS
*************************************************************/
var optionsDS = {
    url: 'https://bigml.io/dataset?' + BIGML_AUTH ,
    headers: headers,
	'source': 'source/4f52824203ce893c0a000053',
	encoding: null
}; // console.log(options);
function callbackDS(error, response, body) {
    if (!error && response.statusCode == 200) {
		console.log("\n\ResponseSTR:" + JSON.stringify(response) );
    }
	console.log("done");
}
// request(optionsDS, callbackDS) ;


/************************************************************  
*   Create a model from the datasetID DS
*   returns modelID MOD
*************************************************************/
var optionsMOD = {
    url: 'https://bigml.io/model?' + BIGML_AUTH ,
    headers: headers,
	'dataset': 'dataset/4f52da4303ce896fe3000000',
	encoding: null
}; // console.log(options);
function callbackMOD(error, response, body) {
    if (!error && response.statusCode == 200) {
		console.log("\n\ResponseSTR:" + JSON.stringify(response) );
    }
	console.log("done");
}
//request(optionsMOD, callbackMOD) ;


/************************************************************  
*   Create a prediction using the modelID MOD
*   returns predictionID PRED
*************************************************************/
var optionsMOD = {
    url: 'https://bigml.io/prediction?' + BIGML_AUTH ,
    headers: headers,
	'model': 'model/4f52e5ad03ce898798000000', 
	'input_data': {'000000': 5, '000001': 3, '000002': 4}
}; // console.log(options);
function callbackMOD(error, response, body) {
    if (!error && response.statusCode == 200) {
		console.log("\n\ResponseSTR:" + JSON.stringify(response) );
    }
	console.log("done");
}
//request(optionsMOD, callbackMOD) ;

/************************************************************  
*   Retrieve a prediction using the predictionID PRED
*   returns predictionID PRED
*************************************************************/
var optionsPRED = {
    url: 'https://bigml.io/prediction?' + BIGML_AUTH ,
    headers: headers,
	'resource': 'prediction/5a31d44f59f5c342260003fd'
}; // console.log(options);
function callbackPRED(error, response, body) {
    if (!error && response.statusCode == 200) {
		//console.log("\n\ResponseSTR:" + JSON.stringify(response) );
		var resp = JSON.parse(response.body)
		//console.log("\n\ResponseJSON:" + resp.meta );
		//console.log("\n\ResponseJSON:" + JSON.stringify(resp) );
		//console.log("\n\ResponseJSON:" + resp.objects );
		console.log("\n\ResponseJSON:" + JSON.stringify(  resp.objects[0].fields ) );
		console.log("\n\ResponseJSON:" + JSON.stringify(  resp.objects[0].importance ) );
		console.log("\n\ResponseJSON:" + JSON.stringify(  resp.objects[0].probabilities ) );
		console.log("\n\ResponseJSON:" + JSON.stringify(  resp.objects[0].prediction ) );
		console.log("\n\ResponseJSON:" + JSON.stringify(  resp.objects[0].name ) );
		/*
		for (x in resp.objects) {
			console.log("\n\ResponseJSON:" + JSON.stringify( resp.objects[x].fields ) );
			console.log("\n\ResponseJSON:" + JSON.stringify( resp.objects[x].importance ) );
			probabilities
		}*/
		
    }
	console.log("done");
}
// request(optionsPRED, callbackPRED) ;

/**********************************************************************************************
 * 
 * Blockchain Ethereum Web3 Interface
 * 
 *********************************************************************************************/

var _modelID = 5 /* var of type uint256 here */ ;
var _contractRate = 2 /* var of type uint256 here */ ;
var purchaseContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"seller","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"petalLength","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"prediction","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"abort","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"ripContract","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"value","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"slAccuracy","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"operator","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"buyer","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"confirmReceived","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"petalWidth","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"contractSLA","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"modelID","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"contractRate","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"state","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_petalLength","type":"uint256"},{"name":"_petalWidth","type":"uint256"},{"name":"_sepalLength","type":"uint256"}],"name":"Predict","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],"name":"service","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"confirmPurchase","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],"name":"sepalLength","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_modelID","type":"uint256"},{"name":"_contractRate","type":"uint256"}],"payable":true,"stateMutability":"payable","type":"constructor"},{"anonymous":false,"inputs":[],"name":"Aborted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"buyer","type":"address"},{"indexed":false,"name":"seller","type":"address"},{"indexed":false,"name":"amount","type":"uint256"},{"indexed":false,"name":"sla","type":"uint256"}],"name":"PurchaseConfirmed","type":"event"},{"anonymous":false,"inputs":[],"name":"PredictionReceived","type":"event"}]);
var purchase = purchaseContract.new(
   _modelID,
   _contractRate,
   {
     from: web3.eth.accounts[0], 
     data: '0x6060604052604051604080610d3d833981016040528080519060200190919080519060200190919050503460085414151561003957600080fd5b33600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055503460008190555081600581905550806008819055505050610c9d806100a06000396000f300606060405260043610610107576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806308551a531461010c57806312ebbb06146101615780632372c9161461018a57806335a063b414610218578063396239f71461022d5780633fa4f2451461024257806350af8e6d1461026b578063570ca735146102945780637150d8ae146102e957806373fac6f01461033e5780638601c79f14610353578063921848b31461037c57806399b83088146103a5578063bf7ddc8b146103ce578063c19d93fb146103f7578063d08ab2431461042e578063d598d4c914610458578063d6960697146104ad578063e342b6ca146104b7575b600080fd5b341561011757600080fd5b61011f6104e0565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561016c57600080fd5b610174610506565b6040518082815260200191505060405180910390f35b341561019557600080fd5b61019d61050c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156101dd5780820151818401526020810190506101c2565b50505050905090810190601f16801561020a5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561022357600080fd5b61022b6105aa565b005b341561023857600080fd5b610240610707565b005b341561024d57600080fd5b6102556107b0565b6040518082815260200191505060405180910390f35b341561027657600080fd5b61027e6107b6565b6040518082815260200191505060405180910390f35b341561029f57600080fd5b6102a76107bc565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b34156102f457600080fd5b6102fc6107e2565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b341561034957600080fd5b610351610808565b005b341561035e57600080fd5b6103666109f3565b6040518082815260200191505060405180910390f35b341561038757600080fd5b61038f6109f9565b6040518082815260200191505060405180910390f35b34156103b057600080fd5b6103b86109ff565b6040518082815260200191505060405180910390f35b34156103d957600080fd5b6103e1610a05565b6040518082815260200191505060405180910390f35b341561040257600080fd5b61040a610a0b565b6040518082600281111561041a57fe5b60ff16815260200191505060405180910390f35b6104566004808035906020019091908035906020019091908035906020019091905050610a1e565b005b341561046357600080fd5b61046b610aa4565b604051808273ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200191505060405180910390f35b6104b5610aca565b005b34156104c257600080fd5b6104ca610c6b565b6040518082815260200191505060405180910390f35b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600a5481565b600d8054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156105a25780601f10610577576101008083540402835291602001916105a2565b820191906000526020600020905b81548152906001019060200180831161058557829003601f168201915b505050505081565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614151561060657600080fd5b600080600281111561061457fe5b600960009054906101000a900460ff16600281111561062f57fe5b14151561063b57600080fd5b7f72c874aeff0b183a56e2b79c71b46e1aed4dee5e09862134b8821ba2fddbf8bf60405160405180910390a16002600960006101000a81548160ff0219169083600281111561068657fe5b0217905550600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc3073ffffffffffffffffffffffffffffffffffffffff16319081150290604051600060405180830381858888f19350505050151561070457600080fd5b50565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614151561076357600080fd5b60075460065410151561077557600080fd5b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16ff5b60005481565b60065481565b600360009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614151561086457600080fd5b6007546006541015151561087757600080fd5b600180600281111561088557fe5b600960009054906101000a900460ff1660028111156108a057fe5b1415156108ac57600080fd5b6007546006541015156109eb577fd9c1fc1bd2c9c58a0618d9ab371d8a8acacf3070f13479c3bf849114685c567f60405160405180910390a16002600960006101000a81548160ff0219169083600281111561090457fe5b0217905550600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc6000549081150290604051600060405180830381858888f19350505050151561096d57600080fd5b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff166108fc3073ffffffffffffffffffffffffffffffffffffffff16319081150290604051600060405180830381858888f1935050505015156109e657600080fd5b6109f0565b600080fd5b50565b600b5481565b60075481565b60055481565b60085481565b600960009054906101000a900460ff1681565b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff16141515610a7a57600080fd5b34600854141515610a8a57600080fd5b82600a8190555081600b8190555080600c81905550505050565b600460009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b6000806002811115610ad857fe5b600960009054906101000a900460ff166002811115610af357fe5b141515610aff57600080fd5b6000546002023414801515610b1357600080fd5b7ff398f99f7ce820e5b296b9b0268ea3419fa937a85bc2b57b9068e21753449f66600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff16600054600754604051808573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020018473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16815260200183815260200182815260200194505050505060405180910390a133600260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055506001600960006101000a81548160ff02191690836002811115610c6257fe5b02179055505050565b600c54815600a165627a7a7230582069421421407c8c9777b8b28f8eb06bbffa9489cea7cf385a004ef0fde9c803bc0029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract purchased and mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
 
var abi = purchaseContract /* abi as generated by the compiler */;
var ClientReceipt = web3.eth.contract(abi);
var clientReceipt = ClientReceipt.at("0x71d03Ed09ef5682Af3389d5375Fb3c274AE4c6AD" /* address */);

var event = clientReceipt.PurchaseConfirmed();
// watch for changes
event.watch(function(error, result){
    // result will contain various information
    // including the argumets given to the Deposit
    // call.
    if (!error)
        console.log(result);
});

// Or pass a callback to start watching immediately
var event = clientReceipt.PurchaseConfirmed(function(error, result) {
    if (!error)
        console.log(result);
});
