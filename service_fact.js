
var request = require('request');
var reqprom = require('request-promise');
var curl = require('curlrequest');
var BIGML_USERNAME='donhagell';
var BIGML_API_KEY='8224e14ebb93f8f81268b9593b57d8eb920575d0';
var BIGML_AUTH="username="+BIGML_USERNAME+";api_key="+BIGML_API_KEY;
var Dsource_resID = '';

var headers = {
    'content-type': 'application/json'
};
var url = 'https://bigml.io/source?' + BIGML_AUTH ;
 
var dataString = '{"remote": "https://static.bigml.com/csv/iris.csv"}';

var options = {
    url: url,
    method: 'POST',
    headers: headers,
    body: dataString
};
console.log(options);

function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
        console.log(body);
    }
	console.log(response);
}

request(options, callback);

// Upload datasource
var foptions = {
    url: url,
	file: '@iris.csv',
	'limit-rate': '500k',
	encoding: null
};

function fcallback(error, response, body) {
    if (!error && response.statusCode == 200) {

		//console.log("\n\nexc:" + JSON.stringify(response) );

        console.log(response.headers['content-type'])
        console.log(response.headers['data'])
    }
	console.log("done");
}

request(foptions, fcallback) ;

// Create dataset


