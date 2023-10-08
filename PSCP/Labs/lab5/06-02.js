const http=require('http');
const nodemailer=require('nodemailer');
const url=require('url');
const fs=require('fs');
const {parse}=require('querystring');

http.createServer((req,resp)=>{
    resp.writeHead(200,{'Content-Type':'text/html; charset=utf-8'});
    if(url.parse(req.url).pathname==='/'&&req.method=='GET'){
        resp.end(fs.readFileSync('./index.html'));
    }
    else if(url.parse(req.url).pathname==='/'&&req.method=='POST'){
        let body='';
        req.on('data',chunk=>{
            body+=chunk.toString();
        });
        req.on('end',()=>{
            let param=parse(body);
            const transporter=nodemailer.createTransport({
                host: 'smtp.gmail.com',
                port:587,
                secure:false,
                service:'Gmail',
                auth:{
                    user:param.sender,
                    pass:"ulll kbbl ivjy bhlc"
                    //"jwvh fzdd kpkr wcor"
                }
            })
            const mailOptons={
                from:param.sender,
                to:param.receiver,
                subject:param.topic,
                text:param.message
            }
    
            transporter.sendMail(mailOptons,(err,info)=>{
                if(err){
                    return console.log(err);
                }
                return console.log("Sent: "+info.response);
            });
            resp.end(`<h1>Message has been sent to ${param.receiver} from ${param.sender}</h1>`);
        });
    }
}).listen(5000,()=>{console.log("Server is listening at http://localhost:5000/\n")});