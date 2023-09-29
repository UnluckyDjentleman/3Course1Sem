const http=require('http');
const url=require('url');
const fs=require('fs');
const util=require('util');
const event=require('events');
let data=require('./db_module');
const route='api/db';

let db=new data.DB();

db.on('GET',(req,resp)=>{
    resp.end(db.select());
});
db.on('POST',(req,resp)=>{
    console.log('POST called');
    req.on('data',data=>{
        resp.end(db.insert(data));
    })
});
db.on('PUT',(req,resp)=>{
    console.log('PUT called');
    req.on('data',data=>{
        resp.end(db.update(data));
    })
});
db.on('DELETE',(req,resp)=>{
    if(url.parse(req.url).pathname==='/'+route && typeof url.parse(req.url, true).query.id != 'undefined'){
        var id=parseInt(url.parse(req.url, true).query.id);
        if(Number.isInteger(id)){
            resp.end(db.delete(id));
        }
        else{
            resp.end("ERROR! Id is NaN");
        }
    }
    else{
        resp.end("ERROR! Wrong route or id is undefined");
    }
});

http.createServer((req,resp)=>{
    if(url.parse(req.url).pathname==="/"+route){
        db.emit(req.method,req,resp)
    }
    else if(url.parse(req.url).pathname==="/"){
        let html=fs.readFileSync('./04-02.html');
        resp.writeHead(200,{'Content-Type':'text/html; charset=utf-8'});
        resp.end(html)
    }
    else{
        resp.end("Visit localhost:5000/"+route)
    }
}).listen(5000);