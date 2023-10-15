const http=require('http');
const url=require('url');
const server=http.createServer();
const mod=require('./m0600')(server);

let http_handler=(req,res)=>{
    if(req.method==='GET'){
        switch(url.parse(req.url,true).pathname.split('/')[1]){
            case 'task1': mod.StatusSocket(req,res); break;
            case 'task2': mod.ParameterSocket(req,res); break;
            case 'task7': mod.GetFile(req,res); break;
            default: mod.MainPage(req,res); break;
        }
    }
    else if(req.method==='POST'){
        switch(url.parse(req.url,true).pathname.split('/')[1]){
            case 'task3': mod.PostParameters(req,res); break;
            case 'task4': mod.JsonPostParameters(req,res); break;
            case 'task5': mod.XmlPostParameters(req,res); break;
            case 'task6': mod.UploadFile(req,res); break;
            default: mod.MainPage(req,res); break;
        }
    }
}
server.listen(5000,()=>{console.log('Server is listening at http://localhost:5000\n')}).on('request',http_handler).on('error',e=>console.log('error:',e.code));