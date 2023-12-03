const net=require('net');
let HOST='127.0.0.1'
let PORT=4000;

var client=new net.Socket();

client.connect(PORT,HOST,()=>{
    console.log(`Client connected: ${client.remoteAddress}:${client.remotePort}`);
    client.write('Hello from Client');
});
client.on('data',(data)=>{
    console.log(`Client DATA: ${data.toString()}`);
    client.destroy();
});
client.on('close',()=>{
    console.log('Client finished its work');
});
client.on('error',(error)=>{
    console.log(`ERROR ${error.name}: ${error.message}`);
})
//Server C++: ServerT from NetAppProgramming from past semester