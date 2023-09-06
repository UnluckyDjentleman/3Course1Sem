const http=require('http')

http.createServer((req,resp)=>{
    resp.writeHead(200,{'Content-type': 'text/html'})
    resp.write('<h1>Hello World</h1>')
    resp.write('<h2>Hello World</h2>')
    resp.write('<h3>Hello World</h3>')
    resp.write('<h4>Hello World</h4>')
    resp.write('<h5>Hello World</h5>')
    resp.write('<h6>Hello World</h6>')
    resp.end();
}).listen(3000);
console.log('Server is running')