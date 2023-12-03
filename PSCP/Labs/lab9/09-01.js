const fs=require('fs');
const WebSocket=require('ws');
let k=0
const ws=new WebSocket.Server({port:4000, host:'localhost',transports:['websocket']});
ws.on('connection',ws=>{
    const duplex=WebSocket.createWebSocketStream(ws,{encoding: 'utf8'});
    let writeFile=fs.createWriteStream(`./upload/received${k++}.txt`);
    duplex.pipe(writeFile);
});
ws.on('error',err=>{
    console.log('Websocket throws error:'+err.message);
})