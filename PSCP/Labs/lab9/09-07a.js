const rpcClient = require('rpc-websockets').Client;
let ws = new rpcClient('ws://localhost:4000/');

ws.on('open', () => {
    process.stdin.setEncoding('utf-8');
    process.stdin.on('readable', () => {
        let data = null;
        while ((data = process.stdin.read()) != null) {
            switch (data.trim().toUpperCase()) {
                case 'A': ws.notify('A'); break;
                case 'B': ws.notify('B'); break;
                case 'C': ws.notify('C'); break;
            }
        }
    });
})