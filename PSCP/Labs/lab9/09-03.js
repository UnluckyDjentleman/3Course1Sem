const fs=require('fs');
const WebSocket=require('ws');
let k=0
const wss=new WebSocket.Server({port:4000, host:'localhost',transports:['websocket']});
wss.on('connection',ws=>{
    setInterval(()=>{
        wss.clients.forEach(client=>{
            if(client.readyState==WebSocket.OPEN){
                client.send(`client 09-03-server: ${k++}`);
            }
        })
    },15000);
    setInterval(()=>{
        console.log(`${wss.clients.size} are available now`);
        ws.ping(`Ping ${wss.clients.size} clients`);
    },5000);
    ws.on('pong',data=>{
        console.log(`on pong:${data.toString()}`);
    });
    ws.on('message',data=>{
        console.log(`Message:${data.toString()}`);
        ws.send(data);
    })
});
wss.on('error',err=>{
    console.log('Websocket throws error:'+err.message);
})