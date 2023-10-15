const http = require('http');
const fs = require('fs');
const axios=require('axios')


getImage=async ()=>{
    try{
        let config={
            responseType:"stream"
        };
        let response=await axios.get('http://localhost:5000/task7/image.png',config);
        response.data.pipe(fs.createWriteStream("image.png"))
    }
    catch(e){
        console.log(e);
    }
}
getImage();

/*const fileName="kyoto.png";
const fileStream = fs.createWriteStream(fileName);


let options = {
    host: 'localhost',
    path: '/task7/image.png',
    port: 5000,
    method: 'GET'
}



const req = http.request(options, (res) => {

    console.log(`\nResponse status:  ${res.statusCode} ${res.statusMessage}`);
    if (res.statusCode != 404) {
        res.pipe(fileStream);
        res.on('end', () => { console.log(`Downloaded file:  ${fileName}\n`); });
    }
});

req.on('error', e => { console.log(`[FATAL] ${e.message}\n\n`); })
req.end();*/
