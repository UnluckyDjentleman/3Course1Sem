firstJob=()=>{
    console.log("firstJob is running")
    return promiseA.then((result)=>{console.log(result)})
}
const promiseA=new Promise((resolve,reject)=>{
    setTimeout(()=>{
        resolve('Hello World')
    },2000)
})

firstJob().then().catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 1 is done")});

async function firstJob(){
    console.log("firstJob is running")
    let result=await promiseA;
    console.log(result)
}

firstJob().catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 1 is done")});