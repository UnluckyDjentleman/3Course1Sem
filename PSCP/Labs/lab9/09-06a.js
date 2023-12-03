const rpcClient = require('rpc-websockets').Client;
let ws = new rpcClient('ws://localhost:4000/');

ws.on('open', () => {
    ws.subscribe('A');

    ws.on('A', data => { console.log('on A event: ', data.toString()); });
})