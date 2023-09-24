f1=()=>{
    console.log('f1');
}
f2=()=>{
    console.log('f2');
}
f3=()=>{
    console.log('f3');
}
main=()=>{
    console.log('main');
    setTimeout(f1,50);
    setTimeout(f3,30);

    new Promise((resolve,reject)=>{
        resolve('I am Promise, right after f1 and f3! Really?')//No lol
    }).then(resolve=>{console.log(resolve)});
    new Promise((resolve,reject)=>{
        resolve('I am Promise after Promise!')//Real (I'm mentally insane)
    }).then(resolve=>{console.log(resolve)});
    f2();
}
main()