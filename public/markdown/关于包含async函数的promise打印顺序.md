`async` 函数处理返回值的问题，它会像 `Promise.prototype.then` 一样，会对返回值的类型进行辨识。

👉**根据返回值的类型，引起 `js引擎` 对返回值处理方式的不同**

> 📑结论：`async`函数在抛出返回值时，会根据返回值**类型**开启**不同数目的微任务**
>
> -   return结果值：非`thenable`、非`promise`（不等待）
> -   return结果值：`thenable`（等待 1个`then`的时间）
> -   return结果值：`promise`（等待 2个`then`的时间）

```js
async function async1() {
    console.log('1')
    await async2()
    console.log('async')
}

async function async2() {
    console.log('3')
    return new Promise((resolve, reject) => {
        resolve()
        console.log('4')
    })
}

console.log('5')

setTimeout(() => {
    console.log('6')
}, 0);

async1()

new Promise((resolve) => {
    console.log('7')
    resolve()
}).then(() => {
    console.log('8')
}).then(() => {
    console.log('9')
}).then(() => {
    console.log('10')
})
console.log('11')
```
