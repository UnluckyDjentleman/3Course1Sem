const rpcClient = require('rpc-websockets').Client;
let ws = new rpcClient('ws://localhost:4000/');

ws.on('open', () => {
    ws.subscribe('C');

    ws.on('C', data => { console.log('on C event: ', data.toString()); });
})