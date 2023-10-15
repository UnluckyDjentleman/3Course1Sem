const http=require('http');

let options={
    host:'localhost',
    path:'/task1',
    port:5000,
    method:'GET'
}

const req=http.request(options,(res)=>{
    console.log(`http-request: method = ${req.method}`);
    console.log(`http-request: response = ${res.statusCode}`);
    console.log(`http-request: statusMessage = ${res.statusMessage}`);
    console.log(`http-request: socket.remoteAddress = ${res.socket.remoteAddress}`);
    console.log(`http-request: socket.remotePort = ${res.socket.remotePort}`);

    let data='';
    res.on('data',(chunk)=>{
        data+=chunk.toString();
    });
    res.on('end',()=>{
        console.log(`http-request: body = ${data}`)
    })
});
req.on('error',e=>{
    console.log(e);
});
req.end();