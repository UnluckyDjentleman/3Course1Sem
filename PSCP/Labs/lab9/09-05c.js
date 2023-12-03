const rpcClient = require('rpc-websockets').Client;
let ws = new rpcClient('ws://localhost:4000/');



ws.on('open', () => {
    ws.login({ login: 'dalvhikii', password: 'qwertasdf' })
        .then(async login => { await calculate(); });
});


async function calculate() {
    console.log('\nsum + fib * mul = ' +
        (await ws.call('sum',
            [
                await ws.call('square', [3]),
                await ws.call('square', [5, 4]),
                await ws.call('mul', [3, 5, 7, 9, 11, 13])
            ])
            + await ws.call('fib', [7])
            * await ws.call('mul', [2, 4, 6]))
    );
}