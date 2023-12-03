const net=require('net');
let HOST='127.0.0.1'
let PORT1=40000;
let PORT2=50000;
let sum=0;


let handle=(n)=>{
    return (socket)=>{
        console.log(`${n} CONNECTED: ${socket.remoteAddress}:${socket.remotePort}`);
        socket.on('data',(data)=>{
            console.log(`Server received number: ${data.readInt32LE()}\tSum:${sum}`)
            sum+=data.readInt32LE();
        })
        let buffer=Buffer.alloc(4);
        setInterval(()=>{
            buffer.writeInt32LE(sum,0);
            socket.write(buffer)
        },5000);
        socket.on('close',()=>{
            console.log('Connection was closed');
        })
        socket.on('error',(error)=>{
            console.log(`ERROR ${error.name}: ${error.message}`);
        })
    }
}

net.createServer(handle(PORT1)).listen(PORT1,HOST).on('listening',()=>{
    console.log(`Server stated its work ${HOST}:${PORT1}`);
})
net.createServer(handle(PORT2)).listen(PORT2,HOST).on('listening',()=>{
    console.log(`Server stated its work ${HOST}:${PORT2}`);
})