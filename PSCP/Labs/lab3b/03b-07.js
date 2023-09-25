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
/* 
1.Выполняется функция main.
2.В консоль выводится сообщение "main".
3.Выполняется функция setTimeout с задержкой 50 миллисекунд, которая ставит функцию f1 в очередь для выполнения.
4.Выполняется функция setTimeout с задержкой 30 миллисекунд, которая ставит функцию f3 в очередь для выполнения.
5.Создается новый Promise, который сразу же выполняется и возвращает строку 'I am Promise, right after f1 and f3! Really?'.
6.Затем вызывается метод then для Promise, который ставит функцию обратного вызова в очередь для выполнения. Функция выводит в консоль сообщение 'I am Promise, right after f1 and f3! Really?'.
7.Создается еще один новый Promise, который сразу же выполняется и возвращает строку 'I am Promise after Promise!'.
8.Затем вызывается метод then для Promise, который ставит функцию обратного вызова в очередь для выполнения. Функция выводит в консоль сообщение 'I am Promise after Promise!'.
9.Выполняется функция f2, которая выводит в консоль сообщение 'f2'.
*/