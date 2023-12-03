const fs=require('fs');
const WebSocket=require('ws');
const ws=new WebSocket('ws://localhost:4000');
const duplex=WebSocket.createWebSocketStream(ws,{encoding:'utf8'});
duplex.pipe(process.stdout);
process.stdin.pipe(duplex);
ws.on('ping',data=>{
    console.log(`on ping:${data}`);
})