const net=require('net');
let HOST='127.0.0.1'
let PORT=process.argv[2]?+process.argv[2]:40000;
let numberToSend=process.argv[3]&&Number.isInteger(+process.argv[3].toString().trim())?+process.argv[3]:1;
let client=new net.Socket();
let buffer=Buffer.alloc(4);

client.connect(PORT, HOST,()=>{
    console.log(`Connected to ${client.remoteAddress}:${client.remotePort}\nPORT: ${PORT} HOST:${HOST} NUMBER: ${numberToSend}\n`);     
    let timer=setInterval(()=>{
        client.write((buffer.writeInt32LE(numberToSend,0),buffer));
    },1000);
    setTimeout(()=>{
        clearInterval(timer);
        client.end();
    },30000);
});
client.on('data',data=>{console.log(`Received: ${data}`)});
client.on('close',()=>{console.log(`Client disconnected`)});
client.on('error',(error)=>{console.log(`Error ${error.name}:${error.message}`)});