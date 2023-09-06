const http=require('http')

http.createServer((req,resp)=>{
    let someBody=''
    req.on('data',str=>{someBody+=str.toString();});
    resp.writeHead(200,{'Content-type': 'text/html'})
    req.on('end',()=>{
        console.log('data:'+someBody)
        resp.end(
        '<!DOCTYPE html><html><head></head><body>'+
        '<h1>Info</h1>'+
        '<h2>Method:'+req.method+'</h2>'+
        '<h2>URI:'+req.url+'<h2>'+
        '<h2>Protocol Version:'+req.httpVersion+'</h2>'+
        '<h2>Headers</h2>'+getMyHeaders(req)+'<h2>Request Body: '+someBody+'</h2>'+
        '<body><html>')
    });
}).listen(3000);
console.log('Server is running!')
let getMyHeaders=(req)=>{
    let headers='';
    for(key in req.headers){
        headers+='<li>'+key+': '+ req.headers[key] +'</li>'
    }
    return headers;
}