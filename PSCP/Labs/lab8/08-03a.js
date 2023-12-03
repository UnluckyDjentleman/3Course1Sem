const WebSocket=require('ws');
let k=0;
let parm=process.argv[2];
let prfx=typeof parm=='undefined'?'A':parm;
let intervalSocketSendMes;
let socket=new WebSocket('ws:localhost:5000/broadcast');
socket.onopen=()=>{
    console.log('Socket opened');
    intervalSocketSend = setInterval(() => {
        socket.send(`Client: ${prfx}-${++k}`);
    }, 1000);
}
socket.onclose=()=>console.log('Socket closed');
socket.onmessage=e=>console.log(`Received: ${e.data}`);
socket.onerror=function(e){console.log(`[ERROR] ${e.code}:${e.message}`)};
setTimeout(()=>{
    clearInterval(intervalSocketSendMes);
    socket.close(1000,'Да сувязі');
},25000);