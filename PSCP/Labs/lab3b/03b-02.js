secondJob=()=>{
    console.log("secondJob is running")
    return promiseB.then((result)=>{console.log(result)})
}
const promiseB=new Promise((resolve,reject)=>{
    setTimeout(()=>{
        reject('Oops...')
    },3000)
})

secondJob().then().catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 2 is done")});

/*async function secondJob(){
    console.log("secondJob is running")
    let result=await promiseB;
    console.log(result)
}

secondJob().catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 2 is done")});*/