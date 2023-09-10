const http=require('http')
const fs=require('fs')


http.createServer((request,response)=>{
    if(request.url==='/api/name'){
    response.writeHead(200,{'Content-Type':'text/plain;charset=utf-8'})
    response.end('Горощеня Владислав Сергеевич\nстудент ФИТ, ПОИТ, 3 курс 4 группа')
    }
    else{
        response.end('<html><body><h1>Visit localhost:5000/api/name to get access</h1></body></html>')
    }
}).listen(5000);