const senderModule=require('./m0603');
const http=require('http');

const sender = 'enjoyhockeyleague@gmail.com';
const password = 'jwvh fzdd kpkr wcor';

http.createServer((req,resp)=>{
    resp.writeHead(200,{'Content-Type':'text/html; charset=utf-8'});
    senderModule(sender,password,'[06-03]xd');
    resp.end('<h2>Message has been sent succesfully</h2>')
}).listen(5000,()=>{console.log("Server is listening at http://localhost:5000/\n")});
