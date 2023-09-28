/*secondJob=()=>{
    console.log("secondJob is running")
    return promiseB
}*/
const promiseB=new Promise((resolve,reject)=>{
    setTimeout(()=>{
        reject('Oops...')
    },3000)
})

//secondJob().then((result)=>{console.log(result)}).catch(error=>{console.log("Error: ",error)}).finally(()=>{console.log("Task 2 is done")});

secondJob=async ()=>{
    console.log("secondJob is running")
    try{
        let result=await promiseB();
        console.log(result);
        return result;
    }
    catch(err){
        return err;
    }
}

secondJob();