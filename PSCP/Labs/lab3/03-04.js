const http=require('http')
const fs=require('fs')
const url=require('url')
const route='fact'

var factorialus=(x)=>{
    if(x<0){
        return 'Error! Invalid value'
    }
    else if(x==0||x==1){
        return 1
    }
    else{
        return x*factorialus(x-1)
    }
}

function Fac(k,func){
    this.k=k;
    this.factorialus=factorialus;
    this.func=func;
    this.FactCalculation=()=>{process.nextTick(()=>{this.func(null,this.factorialus(this.k))})}
}

http.createServer((request,response)=>{
    var jason=JSON.stringify({ k: 0});
    if(url.parse(request.url).pathname==='/'+route && typeof url.parse(request.url, true).query.k != 'undefined'){
        var k=parseInt(url.parse(request.url,true).query.k);
        if(Number.isInteger(k)){
            response.writeHead(200,{'Content-Type':'application/json;charset=utf-8'});
            var fac=new Fac(k,(err,res)=>{
                if(err!=null){
                    console.log(err)
                }
                else{
                    response.end(JSON.stringify({k: k, fact: res}))
                }
            })
            fac.FactCalculation();
        }
    }
    else if(url.parse(request.url).pathname==='/'){
        jason=fs.readFileSync('./03-03.html');
        response.writeHead(200,{'Content-Type':'text/html;charset=utf-8'});
        response.end(jason);
    }
    else{
        response.end(jason);
    }
}).listen(5000,()=>{console.log('Server is running at localhost:5000')})