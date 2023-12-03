const http=require('http');
const url=require('url');
const fs=require('fs');
const WebSocket=require('ws');


//==================HTTP=====================
http.createServer((req,res)=>{
    if (req.method === 'GET' && url.parse(req.url).pathname === '/index') {
        res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
        res.end(fs.readFileSync('./index.html'));
    }
    else {
        res.writeHead(400, { 'Content-Type': 'text/html; charset=utf-8' });
        res.end('<h1>[ERROR] Visit localhost:3000/index using GET method. </h1>');
    }
}).listen(3000, ()=>console.log("Listen to port 3000"));

//=================WebSocket=================
let k=0;
let n=0;

new WebSocket.Server({port: 4000, host: 'localhost', path: '/ws'},{transport: ['websocket']})
.on('connection', ws=>{
    console.log('Client connected');
    ws.on('message',message=>{
        console.log(`Message: ${message}`);
        n+=message.toString()
    })
    setInterval(()=>{
        ws.send(`08-01 server: ${n}->${k++}`);
    },5000);
    ws.on('close', ()=>console.log('Да сувязі...'))
}).on('error',e=>{console.log(`[ERROR] ${e.code}: ${e.message}`)});