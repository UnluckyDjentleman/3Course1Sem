const http=require('http');
const url=require('url');
const fs=require('fs');
const parseString=require('xml2js').parseString;
const multiParty=require('multiparty');
const {parse}=require('querystring');
const xmlb=require('xmlbuilder');

function Handler(server, serverSockets){
    this.server=server;
    this.serverSockets=serverSockets;
    const regexNumber=new RegExp('^[0-9]+$');
    this.MainHandle=(req,res)=>{
        res.writeHead(200,{'Content-Type':'text/html; charset=utf-8'});
        res.end('<h1>Welcome on HTTP-Server. To check its work enter these values in URL</h1>'+
        '<h2>GET</h2>'+
        '<ul>'+
        '<li>/connection</li>'+
        '<li>/headers</li>'+
        '<li>/parameter</li>'+
        '<li>/parameter?x=x&y=y</li>'+
        '<li>/parameter/x/y</li>'+
        '<li>/socket</li>'+
        '<li>/resp-status?code=c&mess=m</li>'+
        '<li>/files</li>'+
        '<li>/files/filename</li>'+
        '<li>/upload</li>'+
        '</ul>'+
        '<h2>POST</h2>'+
        '<ul>'+
        '<li>/formparameter</li>'+
        '<li>/json</li>'+
        '<li>/xml</li>'+
        '<li>/upload</li>'+
        '</ul>');
    }
    this.ConnectionHandle=(req,res)=>{
        let SetParams=url.parse(req.url,true).query.set;
        res.writeHead(200,{'Content-Type':'text/html; charset=utf-8'});
        if(!SetParams){
            res.end(`<p>KeepAliveTimeout = ${this.server.KeepAliveTimeout}</p>`);
        }
        else if(regexNumber.test(SetParams)){
            this.server.KeepAliveTimeout= +url.parse(req.url,true).query.set;
            res.end(`<p>Setted KeepAliveTimeout = ${this.server.KeepAliveTimeout}</p>`);
        }
    }
    this.HeadersHandle=(req,res)=>{
        let i=0;
        let result='<h1>Request Headers</h1>'
        for(key in req.headers){
            result+=`<li>${i++}. ${key}:${req.headers[key]}</li>`;
        }
        result+='<h1>Response Headers</h1>';
        res.setHeader('Connection','keep-alive');
        res.setHeader('Content-Type','text/html; charset=utf-8;');
        res.setHeader('GOAT','Tyler Myers');//xd, this is giraffe
        let resHeaders=res.getHeaders(); 
        for(key in resHeaders){
            result+=`<li>${i++}. ${key}:${resHeaders[key]}</li>`;
        } 
        res.writeHead(200);
        res.end(result);
    }
    this.ParamsHandle=(req,res)=>{
        let xQuery=url.parse(req.url,true).query.x;
        let yQuery=url.parse(req.url,true).query.y;
        let xRoute=url.parse(req.url,true).pathname.split('/')[2];
        let yRoute=url.parse(req.url,true).pathname.split('/')[3];
        res.writeHead(200,{'Content-Type':'text/html;charset=utf-8;'});
        if(regexNumber.test(xQuery)&&regexNumber.test(yQuery)){
            res.end(`<p>Add:${xQuery}+${yQuery}=${+xQuery + +yQuery}</p>`+
            `<p>Sub:${xQuery}-${yQuery}=${+xQuery - +yQuery}</p>`+
            `<p>Mul:${xQuery}*${yQuery}=${+xQuery * +yQuery}</p>`+
            `<p>Div:${xQuery}/${yQuery}=${+xQuery / +yQuery}</p>`
            );
        }
        else if(xRoute!='undefined'&&yRoute!='undefined'){
            if(regexNumber.test(xRoute)&&regexNumber.test(yRoute)){
                res.end(`<p>Add:${xRoute}+${yRoute}=${+xRoute + +yRoute}</p>`+
                `<p>Sub:${xRoute}-${yRoute}=${+xRoute - +yRoute}</p>`+
                `<p>Mul:${xRoute}*${yRoute}=${+xRoute * +yRoute}</p>`+
                `<p>Div:${xRoute}/${yRoute}=${+xRoute / +yRoute}</p>`
                );
            }
            else{
                res.end('<h1>ROUTE: xd</h1>')
            }
        }
        else{
            res.end('<h1>QUERY: xd</h1>')
        }
    }
    this.SocketHandle=(req,res)=>{
        res.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
        res.end(`<p>Client Port: ${res.socket.remotePort}</p><p>Client Address: ${res.socket.remoteAddress}</p><p>Server Port:${res.socket.localPort}</p><p>Server Address: ${res.socket.localAddress}</p>`)
    }
    this.RespStatusHandle=(req,res)=>{
        let statusCode=url.parse(req.url,true).query.c;
        let statusMessage=url.parse(req.url,true).query.m;
        if(statusCode==='undefined'||statusMessage==='undefined'){
            res.writeHead(405,'Incorrect parameters',{'Content-Type':'text/html;charset=utf-8;'});
            res.end('<h1>Error! c is integer, m is string</h1>');
        }
        else if(regexNumber.test(statusCode)){
            if(+statusCode>=200&&+statusCode<600){
                res.writeHead(+statusCode,statusMessage,{'Content-Type':'text/html;charset=utf-8;'});
                res.end(`<p>RESPONSE STATUS CODE: ${statusCode}</p><p>RESPONSE STATUS MESSAGE: ${statusMessage}</p>`)
            }
            else{
                res.writeHead(406, 'Invalid StatusCode', { 'Content-Type': 'text/html; charset=utf-8' });
                res.end('<h1>ERROR! Enter valid StatusCode (200-599).</h1>')
            }
        }
        else{
            res.writeHead(407, 'Incorrect StatusCode', { 'Content-Type': 'text/html; charset=utf-8' });
            res.end('<h1>ERROR! Enter correct StatusCode (200-599).</h1>')
        }
    }
    this.FormParameterHandle=(req,res)=>{
        if(req.method==='GET'){
            res.end(fs.readFileSync('./formParameters.html'));
        }
        else if(req.method==='POST'){
            let body='';
            let params='';
            req.on('data',chunk=>{body+=chunk.toString()});
            req.on('end',()=>{
                params=parse(body);
                console.log(params);
                res.end(
                    `<p>Text: ${params.inpTxt}</p>`+
                    `<p>Number: ${params.inpNum}</p>`+
                    `<p>Date: ${params.inpDate}</p>`+
                    `<p>Checkbox-1: ${params.inpCheck1}</p>`+
                    `<p>Checkbox-2: ${params.inpCheck2}</p>`+
                    `<p>RadioButton-1: ${params.inpRadio1}</p>`+
                    `<p>RadioButton-2: ${params.inpRadio2}</p>`+
                    `<p>RadioButton-3: ${params.inpRadio3}</p>`+
                    `<p>TextArea: ${params.inpTextArea}</p>`+
                    `<p>Submit: ${params.inpSubmit}</p>`
                );
            })
        }
        else{
            res.writeHead(408, 'Incorrect Data', { 'Content-Type': 'text/html; charset=utf-8' });
            res.end('<h1>ERROR! Wrong data.</h1>')
        }
    }
    //from POSTMAN!!!
    this.JsonHandle=(req,res)=>{
        res.writeHead(200,{'Content-Type':'application/json;charset=utf-8;'});
        let data='';
        req.on('data',chunk=>{data+=chunk.toString()});
        req.on('end',()=>{
            data=JSON.parse(data);
            console.log(data);
            let result={};
            result._comment="xd";
            result.x_plus_y=data.x+data.y;
            result.Concatinations_s_o=`${data.s}: ${data.o.surname} ${data.o.name}`;
            result.Length_m=data.m.length;
            res.end(JSON.stringify(result,null,2))
        })
    }
    //from POSTMAN!
    this.XmlHandle=(req,res)=>{
        res.writeHead(200,{"Content-Type":"text/xml;charset=utf-8"});
        let xmlS='';
        let rc='';
        req.on('data',chunk=>{xmlS+=chunk.toString()});
        req.on('end',()=>{
            xmlS=parseString(xmlS,(err,result)=>{
                if(err){
                    rc=`<res>${err}</res>`
                    res.end(rc);
                }
                else{
                    let sum=0;
                    let concat='';
                    result.request.x.forEach(el=>{sum+=Number.parseInt(el.$.value)});
                    result.request.m.forEach(str=>{concat+=str.$.value})
                    let xmldoc=xmlb.create('response').att('id',result.request.$.id+5).att('request',result.request.$.id);
                    xmldoc.ele('sum',{element: 'x',value: `${sum}`});
                    xmldoc.ele('concat',{element: 'm',value:`${concat}`});
                    rc=xmldoc.toString({pretty:true});
                    res.writeHead(200,{"Content-Type":"text/xml;charset=utf-8"});
                    res.end(rc);
                }
            });
        })
    }
    this.UploadHandle=(req,res)=>{
        if(req.method==='GET'){
            res.end(fs.readFileSync('./upload.html'));
        }
        else if(req.method==='POST'){
            let form=new multiParty.Form({uploadDir:'./static'});
            form.on('file',(name,file)=>{
                console.log(`Name:${name};original filename:${file.originalFilename};path:${file.path}`)
            });
            form.on('error',err=>{
                res.end(`<h1>${e}</h1>`);
            });
            form.on('close',()=>{
                res.end('<h1>File uploaded succesfully</h1>')
            });
            form.parse(req);
        }
    }
    this.FilesHandle=(req,res)=>{
        let filename=url.parse(req.url,true).pathname.split('/')[2];
        if(filename===undefined){
            fs.readdir('./static',(err,files)=>{
                if(err){
                    res.end('<h1>Error! Cannot read this directory!</h1>');
                }
                res.setHeader('X-static-files-count',`${files.length}`);
                res.writeHead(200,{'Content-Type':'text/html'})
                res.end(`<p>Count of files in ./static directory: ${files.length}. You can also check headers by F12->Network or through Postman</p>`)
            })
        }
        else{
            try{
                res.end(fs.readFileSync(`./static/${filename}`))
            }
            catch(e){
                res.writeHead(404,'Cannot find resource',{'Content-Type':'text/html; charset=utf-8;'})
                res.end(`<h1>${e}</h1>`)
            }
        }
    }
}
module.exports = (server,serverSockets) => new Handler(server,serverSockets);