firstJob=()=>{
    console.log("firstJob is running")
    return promiseA
}
const promiseA=new Promise((resolve,reject)=>{
    setTimeout(()=>{
        resolve('Hello World')
    },2000)
})

firstJob().then((result)=>{console.log(result)}).catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 1 is done")});

/*firstJob=async ()=>{
    console.log("firstJob is running")
    try{
        let result=await promiseA();
        console.log(result);
        return result;
    }
    catch(err){
        return err;
    }
}

firstJob().finally(()=>{console.log("Task 1 is done")});*/