const WebSocket=require('ws');
let socket=new WebSocket.Server({port: 5000, host: 'localhost', path: '/broadcast'},{transport: ['websocket']});
socket.on('connection',ws=>{
    console.log('Client connected');
    ws.on('message',message=>{
        socket.clients.forEach(client => {
            if(client.readyState==WebSocket.OPEN) client.send(`Sent: ${message}`);
        });
    })
    ws.on('close',()=>{console.log('Да сувязі...')});
})