const http=require('http')
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

http.createServer((request,response)=>{
    var jason=JSON.stringify({ k: 0});
    if(url.parse(request.url).pathname==='/'+route && typeof url.parse(request.url, true).query.k != 'undefined'){
        console.log(url.parse(request.url).pathname);
        console.log(typeof url.parse(request.url,true).query.k);
        var k=parseInt(url.parse(request.url,true).query.k);
        if(Number.isInteger(k)){
            response.writeHead(200,{'Content-Type':'application/json;charset=utf-8'});
            response.end(JSON.stringify({ k: k, fact: factorialus(k) }));
        }
    }
    else{
        console.log(url.parse(request.url).pathname);
        console.log(typeof url.parse(request.url,true).query.k);
        response.end(jason);
    }
}).listen(5000,()=>{console.log('Server is running at localhost:5000/'+route)})