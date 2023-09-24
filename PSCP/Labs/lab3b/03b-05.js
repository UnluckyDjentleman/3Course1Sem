const prompt=require('prompt-sync')();
let num=prompt("Value = ");
squareFunc=(number)=>{
    let num=parseFloat(number)
    if(Number.isFinite(num)){
        return new Promise((resolve,reject)=>{
            setTimeout(()=>{resolve(num**2)},1000)
        })
    }
    else{
        return new Promise((resolve,reject)=>{
            reject("Promise 1 message: Invalid value")
        })
    }
}
cubeFunc=(number)=>{
    let num=parseFloat(number)
    if(Number.isFinite(num)){
        return new Promise((resolve,reject)=>{
            setTimeout(()=>{resolve(num**3)},2000)
        })
    }
    else{
        return new Promise((resolve,reject)=>{
            reject("Promise 2 message: Invalid value")
        })
    }
}
fourthFunc=(number)=>{
    let num=parseFloat(number)
    if(Number.isFinite(num)){
        return new Promise((resolve,reject)=>{
            setTimeout(()=>{resolve(num**4),500})
        })
    }
    else{
        return new Promise((resolve,reject)=>{
            reject("Promise 3 message: Invalid value")
        })
    }
}
Promise.all([squareFunc(num),cubeFunc(num),fourthFunc(num)])
.then((data)=>{console.log(data)})
.catch((error)=>{console.log(error)});
Promise.race([squareFunc(num),cubeFunc(num),fourthFunc(num)])
.then((data)=>{console.log(data)})
.catch((error)=>{console.log(error)});
Promise.any([squareFunc(num),cubeFunc(num),fourthFunc(num)])
.then((data)=>{console.log(data)})
.catch((error)=>{console.log(error)})
//Promise.race() gets first completed promise
//Promise.any() gets first successfully completed promise