const fs=require('fs');
const WebSocket=require('ws');
const ws=new WebSocket('ws://localhost:4000');
ws.on('open',()=>{
    const duplex=WebSocket.createWebSocketStream(ws,{encoding: 'utf8'});
    let writeFile=fs.createWriteStream(`./fromServer.txt`);
    duplex.pipe(writeFile);
});
ws.on('error',err=>{
    console.log('Websocket throws error:'+err.message);
})