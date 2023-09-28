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
    try{
        if(!Number.isFinite(data)){
            result = await new Promise((resolve,reject)=>{
                reject(new Error("data should be Number!!!"))
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
        console.log(result);
        return result;
    }
    catch(error){
        console.log(error);
        return error;
    }
}

thirdJob('/');