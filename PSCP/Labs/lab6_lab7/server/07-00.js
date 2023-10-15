const http=require('http');
const url=require('url');
const server=http.createServer();
const serverSockets=new Set();
const mod=require('./m0700')(server,serverSockets);

let http_handler=(req,res)=>{
    if(req.method==='GET'){
        switch(url.parse(req.url,true).pathname.split('/')[1]){
            case 'connection': mod.ConnectionHandle(req,res); break;
            case 'headers': mod.HeadersHandle(req,res); break;
            case 'parameter': mod.ParamsHandle(req,res); break;
            case 'socket': mod.SocketHandle(req,res); break;
            case 'resp-status': mod.RespStatusHandle(req,res);break;
            case 'formparameter': mod.FormParameterHandle(req,res); break;
            case 'files': mod.FilesHandle(req,res); break;
            case 'upload': mod.UploadHandle(req,res); break;
            case '': mod.MainHandle(req,res); break;
        }
    }
    else if(req.method==='POST'){
        switch(url.parse(req.url,true).pathname.split('/')[1]){
            case 'formparameter': mod.FormParameterHandle(req,res); break;
            case 'json': mod.JsonHandle(req,res); break;
            case 'xml': mod.XmlHandle(req,res); break;
            case 'upload': mod.UploadHandle(req,res); break;
            case '': mod.MainHandle(req,res); break;
        }
    }
}
server.listen(5000,()=>{console.log('Server is listening at http://localhost:5000\n')}).on('request',http_handler).on('connection',socket=>{serverSockets.add(socket);}).on('error',e=>console.log('error:',e.code));