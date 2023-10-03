const http=require('http');
const url=require('url');
const fs=require('fs');
const util=require('util');
const event=require('events');
let data=require('./db_module');
const route='api/db';

let db=new data.DB();

db.on('GET',async(req,resp)=>{
    resp.end(await db.select());
});
db.on('POST',async(req,resp)=>{
    console.log('POST called');
    req.on('data', async(data)=>{
        resp.end(await db.insert(data));
    })
});
db.on('PUT',async(req,resp)=>{
    console.log('PUT called');
    req.on('data', async(data)=>{
        resp.end(await db.update(data));
    })
});
db.on('DELETE',async(req,resp)=>{
    if(url.parse(req.url).pathname==='/'+route && typeof url.parse(req.url, true).query.id != 'undefined'){
        var id=parseInt(url.parse(req.url, true).query.id);
        if(Number.isInteger(id)){
            resp.end(await db.delete(id));
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