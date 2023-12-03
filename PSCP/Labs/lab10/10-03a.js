const udp=require('dgram');
const PORT=3000;
let client=udp.createSocket('udp4');
const message=Buffer.from("Client message: Hello, Server!");

client.connect(PORT,'localhost',(err)=>{
    client.send(message,(err)=>{
        client.close();
    });
});
//Server C++: ServerU from NetAppProgramming from past semester
