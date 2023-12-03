const rpcServer = require('rpc-websockets').Server;
const server = new rpcServer({ port: 4000, host: 'localhost' });


server.event('A');
server.event('B');
server.event('C');

process.stdin.setEncoding('utf-8');
process.stdin.on('readable', () => {
    let data = null;
    while ((data = process.stdin.read()) != null) {
        switch (data.trim().toUpperCase()) {
            case 'A': server.emit('A', 'event A emitted'); break;
            case 'B': server.emit('B', 'event B emitted'); break;
            case 'C': server.emit('C', 'event C emitted'); break;
        }
    }
});