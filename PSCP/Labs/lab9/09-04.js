const fs=require('fs');
const WebSocket=require('ws');
let k=0
const wss=new WebSocket.Server({port:4000, host:'localhost',transports:['websocket']});
wss.on('connection',ws=>{
    ws.on('message',data=>{
        console.log(`on message:${data.toString()}`);
        ws.send(JSON.stringify({server: ++k, client:JSON.parse(data).client,timestamp:new Date().toISOString()},null,2));
    });
});
wss.on('error',err=>{
    console.log('Websocket throws error:'+err.message);
})