/*secondJob=()=>{
    console.log("secondJob is running")
    return promiseB.then((result)=>{console.log(result)})
}*/
const promiseB=new Promise((resolve,reject)=>{
    setTimeout(()=>{
        reject('Oops...')
    },3000)
})

//secondJob().then().catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 2 is done")});

secondJob=async ()=>{
    console.log("secondJob is running")
    let result=await promiseB;
    return result;
}

secondJob().then(result=>{console.log(result)}).catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 2 is done")});