const fs=require('fs');
const WebSocket=require('ws');

setTimeout(()=>{
    const ws=new WebSocket('ws://localhost:4000');
    ws.on('open',()=>{
        const duplex=WebSocket.createWebSocketStream(ws,{encoding: 'utf8'});
        let readFile=fs.createReadStream(`./file.txt`);
        readFile.pipe(duplex);
    });
    ws.on('error',err=>{
        console.log('Websocket throws error:'+err.message);
    })
},300);