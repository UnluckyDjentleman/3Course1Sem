//C:\Users\User\AppData\Roaming\npm\node_modules
const send = require('C:\\Users\\User\\AppData\\Roaming\\npm\\node_modules\\dalvhikkimail');
const http = require('http');

http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    send('enjoyhockeyleague@gmail.com','jwvh fzdd kpkr wcor','[06-04] hello from dalvhikkimail GLOBAL module!');
    res.end('<h2>Message sucessfully sent.</h2>');
}).listen(5000, () => console.log('Server running at http://localhost:5000/\n'));