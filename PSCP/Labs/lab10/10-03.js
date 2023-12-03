const udp=require('dgram');
const PORT=3000;

let server=udp.createSocket('udp4');

server.on('error',(error)=>{
    console.log(`ERROR ${error.name}:${error.message}`);
})

server.on('message',(msg,info)=>{
    console.log(`Received from Client: ${msg.toString()} (${msg.length} btyes)`);
    server.send(`ECHO: ${msg.toString()}`,info.port, info.address, error=>{
        if(error) {
            console.log(`ERROR ${error.name}: ${error.message}`) ;
            server.close();
        }
        else{
            console.log('Message sent');
        }
    })
});
server.on('listening',()=>{
    console.log(`Server is listening to port ${server.address().port}\n`);
    console.log(`IP server: ${server.address().address}\n`);
    console.log(`Server IP Family: ${server.address().family}`);
});

server.on('close',()=>{
    console.log('Server was closed');
})

server.bind(PORT);

//Client C++: ClientU from NetAppProgramming from past semester