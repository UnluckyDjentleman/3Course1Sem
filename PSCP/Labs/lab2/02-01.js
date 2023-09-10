const http=require('http')
const fs=require('fs')
const route='html'

http.createServer((request,response)=>{
    if(request.url==='/'+route){
    let html=fs.readFileSync('./index.html')
    response.writeHead(200,{'Content-Type':'text/html;charset=utf-8'})
    response.end(html)
    }
    else{
        response.end('<html><body><h1>Visit localhost:5000/'+route+' to get access</h1></body></html>')
    }
}).listen(5000);