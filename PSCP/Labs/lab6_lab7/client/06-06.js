const http=require('http');
const fs=require('fs');
const multiParty=require('multiparty');

let bound= 'dalvhikki';
let body=`--${bound}\r\n`
body+='Content-Disposition:form-data; name="pngUpload"; filename="Stockholm.png"\r\n';
body+='Content-Type:application/octet-stream\r\n\r\n';

let options={
    host:'localhost',
    path:'/task6',
    port:5000,
    method:'POST',
    headers: {'Content-Type':`multipart/form-data;boundary=${bound}`}
}

const req=http.request(options,(res)=>{
    let data='';
    console.log(`\nResponse status: ${res.statusCode} ${res.statusMessage}\n`);
    console.log('------------------------------------------------------------------------\n');
    res.on('data', chunk => { console.log(`Response body (data): ${data += chunk.toString('utf8')}`); });

    res.on('end', () => {
        console.log('\n------------------------------------------------------------------------\n');
        console.log(`Response body (end): ${data}\n`);
        console.log(`Response body length: ${Buffer.byteLength(data)}\n`);
    });
});
req.write(body);

let stream=new fs.ReadStream('Stockholm.png');
stream.on('data',chunk=>{
    req.write(chunk);
    console.log('Length chunk = ',Buffer.byteLength(chunk));
})
stream.on('end',()=>{
    req.end(`\r\n--${bound}--`);
})
req.on('error',e=>{console.log(e)});