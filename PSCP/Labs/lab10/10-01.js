const net=require('net');
let HOST='127.0.0.1'
let PORT=4000;

let server=net.createServer((socket)=>{
    console.log(`Socket options: ${socket.remoteAddress}:${socket.remotePort}`);
    socket.on('data',(data)=>{
        console.log(`Server: ${socket.remoteAddress} ECHO data:${data}`);
    })
    socket.on('close',()=>{
        console.log('Connection was closed');
    })
    socket.on('error',(error)=>{
        console.log(`ERROR Client ${error.name}: ${error.message}`)
    })
}).listen(PORT,HOST);

server.on('error',()=>{
    console.log(`ERROR Server ${error.name}: ${error.message}`)
})