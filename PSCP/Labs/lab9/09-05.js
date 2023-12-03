const rpcServer=require('rpc-websockets').Server;
const server=new rpcServer({port:4000,host:'localhost'});
server.setAuth(l=>l.login==='dalvhikii'&&l.password==='qwertasdf');

server.register('sum',params=>{
    let sum=0;
    params.forEach(elem=>{
        if(Number.isInteger(elem))
            sum+=elem;
    });
    return sum;
}).public();

server.register('mul',params=>{
    let mul=1;
    params.forEach(elem=>{
        if(Number.isInteger(elem))
            mul*=elem;
    });
    return mul
}).public();

server.register('square',params=>{
    switch(params.length){
        case 1: return Math.PI*(params[0]**2); break;
        case 2: return params[0]*params[1]; break;
        default: break;
    }
}).public();
server.register('fact', params => {
    if (params.length !== 1)
        return [1];
    return factorial(params);
}).protected();


server.register('fib', params => {
    if (params.length !== 1)
        return [1];
    return fibonacci(params-1);
}).protected();




function factorial(n) {
    return (n == 1 || n == 0) ? 1 : n * factorial(n - 1);
}

function fibonacci(n) {
    if (n <= 1) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
}