const http=require('http');
const qs=require('querystring');

let jsonObject=JSON.stringify({
    '_comment': 'req: HTTP-Client',
    x:3,
    y:2,
    s:'JSON Statham',
    m:[1,'qq','based'],
    o:{surname:'Demko',name:'Thatcher'}
})

let options={
    host:'localhost',
    path:'/task4',
    port:5000,
    method:'POST',
    headers: {'Content-Type':'application/json','Accept':'application/json'}
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
req.end(jsonObject);