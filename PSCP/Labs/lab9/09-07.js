const rpcServer = require('rpc-websockets').Server;
const server = new rpcServer({ port: 4000, host: 'localhost' });

server.register('A', params => { console.log('A notify'); }).public();
server.register('B', params => { console.log('B notify'); }).public();
server.register('C', params => { console.log('C notify'); }).public();