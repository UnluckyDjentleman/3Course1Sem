const async = require('async');
const rpcClient = require('rpc-websockets').Client;
let ws = new rpcClient('ws://localhost:4000/');


let h = (x = ws) => async.parallel({
    'square[3]': cb => { ws.call('square', [3]).catch(e => cb(e, null)).then(r => cb(null, r)); },
    'square[5, 4]': cb => { ws.call('square', [5, 4]).catch(e => cb(e, null)).then(r => cb(null, r)); },
    'sum[2]': cb => { ws.call('sum', [2]).catch(e => cb(e, null)).then(r => cb(null, r)); },
    'sum[2, 4, 6, 8, 10]': cb => { ws.call('sum', [2, 4, 6, 8, 10]).catch(e => cb(e, null)).then(r => cb(null, r)); },
    'mul[3]': cb => { ws.call('mul', [3]).catch(e => cb(e, null)).then(r => cb(null, r)); },
    'mul[3, 5, 7, 9, 11, 13]': cb => { ws.call('mul', [3, 5, 7, 9, 11, 13]).catch(e => cb(e, null)).then(r => cb(null, r)); },
    'fib[1]': cb => {
        ws.login({ login: 'dalvhikii', password: 'qwertasdf' }).then(login => {
            ws.call('fib', [1]).catch(e => cb(e, null)).then(r => cb(null, r));
        })
    },
    'fib[2]': cb => {
        ws.login({ login: 'dalvhikii', password: 'qwertasdf' }).then(login => {
            ws.call('fib', [2]).catch(e => cb(e, null)).then(r => cb(null, r));
        })
    },
    'fib[7]': cb => {
        ws.login({ login: 'dalvhikii', password: 'qwertasdf' }).then(login => {
            ws.call('fib', [7]).catch(e => cb(e, null)).then(r => cb(null, r));
        })
    },
    'fact[0]': cb => {
        ws.login({ login: 'dalvhikii', password: 'qwertasdf' }).then(login => {
            ws.call('fact', [0]).catch(e => cb(e, null)).then(r => cb(null, r));
        })
    },
    'fact[5]': cb => {
        ws.login({ login: 'dalvhikii', password: 'qwertasdf' }).then(login => {
            ws.call('fact', [5]).catch(e => cb(e, null)).then(r => cb(null, r));
        })
    },
    'fact[10]': cb => {
        ws.login({ login: 'dalvhikii', password: 'qwertasdf' }).then(login => {
            ws.call('fact', [10]).catch(e => cb(e, null)).then(r => cb(null, r));
        })
    }
}, (error, result) => {
    if (error)
        console.log('\n[ERROR]: ', error);
    else
        console.log('\n[OK] Result =', result);
    ws.close();
});


ws.on('open', h);