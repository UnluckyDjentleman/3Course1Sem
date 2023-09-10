const http=require('http')
const fs=require('fs')
const route='png'

http.createServer((request,response)=>{
    if(request.url==='/'+route){
    const fname='./pic.png'
    let png='';
    fs.stat(fname,(err,stat)=>{
        if(err){
            console.log('error:',err);
        }
        else{
            png=fs.readFileSync(fname);
            response.writeHead(200,{'Content-Type':'image/jpeg','Content-Length':stat.size})
            response.end(png,'binary');
        }
    })
    }
    else{
        response.end('<html><body><h1>Visit localhost:5000/'+route+' to get access</h1></body></html>')
    }
}).listen(5000);