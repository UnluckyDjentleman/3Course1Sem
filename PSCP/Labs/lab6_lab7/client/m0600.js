const http=require('http');
const url=require('url');
const fs=require('fs');
const parseString=require('xml2js').parseString;
const multiParty=require('multiparty');
const qs=require('qs');
const {parse}=require('querystring');
const xmlb=require('xmlbuilder');

function ClientServer(server){
    this.server=server;
    this.MainPage=(req,res)=>{
        res.writeHead(200,{'Content-Type':'text/html; charset=utf-8'});
        res.end('<h1>Welcome on MainPage of HTTP-Client tests</h1>'+
        '<ul>'+
        '<li>/task1: GET socket status, message, remote address and remote port</li>'+
        '<li>/task2: GET socket status, parameters value from URL</li>'+
        '<li>/task3: POST parameters from body</li>'+
        '<li>/task4: JSON</li>'+
        '<li>/task5: XML</li>'+
        '<li>/task6: POST your file</li>'+
        '<li>/task7: GET your file</li>'+
        '</ul>');
    }
    this.StatusSocket=(req,res)=>{
        res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
        res.end('<h1>xd</h1>');
    }
    this.ParameterSocket=(req,res)=>{
        let query=url.parse(req.url,true).query;
        let parameters='';

        res.writeHead(200,{'Content-Type':'text/html; charset=utf-8;'});
        res.write('<h2>Query Parameters</h2>');
        for(key in query){
            parameters+=`${key} = ${query[key]}\n`
        }
        res.end(parameters);
    }
    this.PostParameters=(req,res)=>{
        let pp='';
        req.on('data',chunk=>{pp+=chunk.toString()});
        req.on('end',()=>{
            let xd=qs.parse(pp);
            for(key in xd){
                pp+=`${key}. ${xd[key]}\n`
            }
            res.writeHead(200,{'Content-Type':'text/html; charset=utf-8;'});
            res.write('<h2>POST parameters</h2>')
            res.end(pp);
        })
    }
    this.JsonPostParameters=(req,res)=>{
        res.writeHead(200,{'Content-Type':'application/json; charset=utf-8;'})
        let data='';
        req.on('data',chunk=>{data+=chunk.toString()});
        req.on('end',()=>{
            data=JSON.parse(data);
            let result={};
            result._comment='resp: HTTP-Client';
            result.x_plus_y=data.x+data.y;
            result.Concatinations_s_o=`${data.s}: ${data.o.surname} ${data.o.name}`;
            result.Length_m=data.m.length;
            res.end(JSON.stringify(result,null,2))
        })
    }
    this.XmlPostParameters=(req,res)=>{
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
    this.UploadFile=(req,res)=>{
        let result = '';
        let form=new multiParty.Form({uploadDir:'./static'});
        form.on('field', (name, field) => {
            console.log('-------------------  FIELD  -------------------');
            console.log(field);
            result += `<br/> '${name}' = ${field}`;
        });
        form.on('file',(name,file)=>{
            result += `<br/> '${name}': Original filename – ${file.originalFilename}, Filepath – ${file.path}`;
        });
        form.on('error',err=>{
            res.writeHead(500, { 'Content-Type': 'text/html' });
            console.log(' [ERROR] ', err.message);
            res.end(`<h1>${err}</h1>`);
        });
        form.on('close',()=>{
            res.writeHead(200, { 'Content-Type': 'text/html' });
            res.write('<h2> [OK] Form data: </h2>');
            res.end(result);
        });
        form.parse(req);
    }
    this.GetFile=(req,res)=>{
        let regexFile = new RegExp(`^\/[a-zA-Z0-9]+\/[a-zA-Z0-9]+\.[a-zA-Z]+$`);

        if (regexFile.test(url.parse(req.url,true).pathname)) {
            try {
                res.end(fs.readFileSync('static/' + url.parse(req.url, true).pathname.split('/')[2]));
            }
            catch {
                res.writeHead(404, 'Resource not found', { 'Content-Type': 'text/html; charset=utf-8' });
                res.end('<h1> [ERROR] 404: Resource not found. </h1>')
            }
        }
    }
}
module.exports=(server)=>new ClientServer(server)