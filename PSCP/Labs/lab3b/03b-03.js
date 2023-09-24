/*thirdJob=(data)=>{
    if(!Number.isFinite(data)){
        return new Promise((resolve,reject)=>{
            reject("data should be Number!!!")
        })
    }
    else{
        if(data%2===0){
            return new Promise((resolve,reject)=>{
                setTimeout(()=>{
                    resolve("odd")
                },1000)
            })
        }
        else{
            return new Promise((resolve,reject)=>{
                setTimeout(()=>{
                    resolve("even")
                },2000)
            })
        }
    }
}*/

thirdJob=async (data)=>{
    let result;
    if(!Number.isFinite(data)){
        result = await new Promise((resolve,reject)=>{
            reject("data should be Number!!!")
        })
    }
    else{
        if(data%2===0){
            result = await new Promise((resolve,reject)=>{
                setTimeout(()=>{
                    resolve("odd")
                },1000)
            })
        }
        else{
            result = await new Promise((resolve,reject)=>{
                setTimeout(()=>{
                    resolve("even")
                },2000)
            })
        }
    }
    return result;
}

thirdJob(232).then((result)=>{console.log(result)}).catch((error)=>{console.log('Error: ',error)}).finally("Task 3 is done");