const http = require('http');
const xmlBuilder = require('xmlbuilder');
const parseString = require('xml2js').parseString;

const xmlDocument = xmlBuilder.create('request').att('id', 30)
xmlDocument.ele('x').att('value', 8);
xmlDocument.ele('x').att('value', 800);
xmlDocument.ele('x').att('value', 555);
xmlDocument.ele('x').att('value', 35);
xmlDocument.ele('x').att('value', 35);
xmlDocument.ele('m').att('value', 'x');
xmlDocument.ele('m').att('value', 'd');

let options={
    host:'localhost',
    path:'/task5',
    port:5000,
    method:'POST',
    headers: {'Content-Type':'text/xml','Accept':'text/xml'}
}

const req=http.request(options,(res)=>{
    console.log(`http-request: response = ${res.statusCode}`);
    console.log(`http-request: statusMessage = ${res.statusMessage}`); 

    let data='';
    res.on('data',(chunk)=>{
        data+=chunk.toString();
    });
    res.on('end',()=>{
        console.log(`http-request: body = ${data}`)
        parseString(data,(err,parser)=>{
            if(err){
                console.log(err);
            }
            console.log(parser);
        })
    })
});
req.on('error',e=>{
    console.log(e);
});
req.end(xmlDocument.toString({pretty:true, standalone:true}));