const http=require('http');
const qs=require('querystring');
const params=qs.stringify({x:3,y:4})

let options={
    host:'localhost',
    path:`/task2?${params}`,
    port:5000,
    method:'GET'
}

const req=http.request(options,(res)=>{
    console.log(`http-request: response = ${res.statusCode}`);
    console.log(`http-request: statusMessage = ${res.statusMessage}`); 

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