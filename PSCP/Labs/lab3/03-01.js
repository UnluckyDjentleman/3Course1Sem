const http=require('http')
global.state='norm'
global.oldState='norm'

http.createServer((request,response)=>{
    response.writeHead(200,{'Content-Type':'text/html;charset=utf-8'})
    response.end('<h1>'+state+'</h1>')
}).listen(5000,()=>{console.log('Server is runnuing on port 5000')});

var stdin=process.openStdin();
stdin.addListener('data',(cmd)=>{
    var argument=cmd.toString().trim();
    if(argument==='norm'||argument==='test'||argument==='idle'||argument==='stop'){
        oldState=state;
        state=argument;
        process.stdout.write(oldState+'--->'+state+'\n');
    }
    else if(cmd.toString().trim()==='exit'){
        process.exit(0)
    }
    else{
        process.stdout.write('You have arguments test, idle, norm, stop. If you\'d like to exit Enter exit\n');
    }
})