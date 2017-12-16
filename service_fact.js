
var request = require('request');
var reqprom = require('request-promise');
var curl = require('curlrequest');
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
request(optionsPRED, callbackPRED) ;

