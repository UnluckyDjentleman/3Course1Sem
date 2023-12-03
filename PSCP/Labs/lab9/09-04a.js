const fs=require('fs');
let parm=process.argv[2];
let nameClient=typeof parm==='undefined'?'xd':parm;
const WebSocket=require('ws');
const ws=new WebSocket('ws://localhost:4000');
ws.on('open',()=>{
    ws.on('message',mes=>{
        console.log(`on message: ${mes.toString()}`);
    })
    ws.send(JSON.stringify({client:nameClient, timestamp: new Date().toISOString()},null,2));
});
ws.on('error',err=>{
    console.log('Websocket throws error:'+err.message);
})