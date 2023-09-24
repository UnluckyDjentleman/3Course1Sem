const prompt=require('prompt-sync')();
const crypto=require('crypto');
let cardId=prompt("Enter Card ID: ");
let uuid;
createOrder=(cardNumber)=>{
    if(/^\d{4}\s\d{4}\s\d{4}\s\d{3}$/.test(cardNumber.toString())){
        uuid=crypto.randomUUID()
        return new Promise((resolve,reject)=>{
            setTimeout(()=>{
                resolve(uuid)
            },5000);
        })
    }
    else{
        return new Promise((resolve,reject)=>{
            reject("Card is not valid");
        })
    }
}
validateCard=(cardNumber)=>{
    console.log('Card ID: ',cardNumber);
    return Math.random() > 0.5 ? true : false
}
proceedToPayment=(validator)=>{
    console.log('Order ID: ',validator);
    if (Math.random() > 0.5){
        return new Promise((resolve,reject)=>{
        resolve("Payment Successful")
        })
    }
    else{
        return new Promise((resolve,reject)=>{
        resolve("Payment Failed")
        })
    }
}
createOrder(cardId).then().catch(error=>{console.log(error)});
if(validateCard(cardId)){
    proceedToPayment(uuid).then(result=>{console.log(result)});
}

