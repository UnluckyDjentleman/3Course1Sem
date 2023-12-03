const WebSocket=require('ws');
let k=0;
let intervalSocketSendMes;
let socket=new WebSocket('ws:localhost:4000/ws', { transports: ['websocket'] });
socket.onopen=()=>{
    console.log('Socket opened');
    intervalSocketSendMes = setInterval(() => {
        socket.send('08-01 client: ' + ++k);
    }, 3000);
}
socket.onclose=e=>console.log('Socket closed');
socket.onmessage=e=>console.log(`Sent: ${e.data}`);
socket.onerror=function(e){console.log(`[ERROR] ${e.code}:${e.message}`)};
setTimeout(()=>{
    clearInterval(intervalSocketSendMes);
    socket.close(1000,'Да сувязі');
},25000);