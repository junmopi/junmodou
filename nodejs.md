\#\#\#阻塞和非阻塞，同步和异步是node.js里经常遇到的词汇，举个简单的例子来说明：

1. 我要看足球比赛，但是妈妈叫我烧水，电视机在客厅，烧水要在厨房。家里有2个水壶，一个是普通的水壶，另一个是水开了会叫的那种水壶。我可以：

   1. 用普通的水壶烧，人在边上看着，水开了再去看球。
      **（同步，阻塞）**
      这个是常规做法，但是我看球不爽了。
   2. 用普通水壶烧，人去看球，隔几分钟去厨房看看。
      **（同步，非阻塞）**
      这个又大问题，万一在我离开的几分钟水开了，我就麻烦了。
   3. 用会叫的水壶，人在边上看着。
      **（异步，阻塞）**
      这个没有问题，但是我太傻了。
   4. 用会叫的水壶，人去看球，听见水壶叫了再去看。
      **（异步，非阻塞）**
      这个应该是最好的。

   等着看球的我：阻塞

   看着电视的我：非阻塞

   普通水壶：同步

   会叫的水壶：异步

   所以，异步往往配合非阻塞，才能发挥出威力。

\#\#\#阻塞和非阻塞

1.阻塞：就像单线程cpu一样，一个任务由多个小任务组成，但是只能一个任务接一个任务流程的往想下走，谁在任务排序的前面就谁先执行，执行完了进行下一个，如果遇到错误，下面的小任务就不要做了，一直卡住。

2.非阻塞：就像多线程cpu一样，一个任务由多个小任务组成，可以分开线程来做，哪个线程做分配到的任务，完成了对应的任务就行，某个线程的任务没做完那就做报对应的错，其他的不受影响。

/n

Node.js 是单进程单线程应用程序，但是因为 V8 引擎提供的异步执行回调接口，通过这些接口可以处理大量的并发，所以性能非常高。

Node.js 几乎每一个 API 都是支持回调函数的。

Node.js 基本上所有的事件机制都是用设计模式中观察者模式实现。

Node.js 单线程类似进入一个while\(true\)的事件循环，直到没有事件观察者退出，每个异步事件都生成一个事件观察者，如果有事件发生就调用该回调函数.

# Node.js EventEmitter

Node.js 所有的异步 I/O 操作在完成时都会发送一个事件到事件队列。

Node.js里面的许多对象都会分发事件：一个net.Server对象会在每次有新连接时分发一个事件， 一个fs.readStream对象会在文件被打开的时候发出一个事件。 所有这些产生事件的对象都是 events.EventEmitter 的实例。

EventEmitter 提供了多个属性，如 on 和 emit。on 函数用于绑定事件函数，emit 属性用于触发一个事件。接下来我们来具体看下 EventEmitter 的属性介绍。

方法

1	addListener\(event, listener\)

为指定事件添加一个监听器到监听器数组的尾部。

2	on\(event, listener\)

为指定事件注册一个监听器，接受一个字符串 event 和一个回调函数。

server.on\('connection', function \(stream\) {

  console.log\('someone connected!'\);

}\);

3	once\(event, listener\)

为指定事件注册一个单次监听器，即 监听器最多只会触发一次，触发后立刻解除该监听器。

server.once\('connection', function \(stream\) {

  console.log\('Ah, we have our first user!'\);

}\);

4	removeListener\(event, listener\)

移除指定事件的某个监听器，监听器必须是该事件已经注册过的监听器。

它接受两个参数，第一个是事件名称，第二个是回调函数名称。

var callback = function\(stream\) {

  console.log\('someone connected!'\);

};

server.on\('connection', callback\);

// ...

server.removeListener\('connection', callback\);

5	removeAllListeners\(\[event\]\)

移除所有事件的所有监听器， 如果指定事件，则移除指定事件的所有监听器。

6	setMaxListeners\(n\)

默认情况下， EventEmitters 如果你添加的监听器超过 10 个就会输出警告信息。 setMaxListeners 函数用于提高监听器的默认限制的数量。

7	listeners\(event\)

返回指定事件的监听器数组。

8	emit\(event, \[arg1\], \[arg2\], \[...\]\)

按参数的顺序执行每个监听器，如果事件有注册监听返回 true，否则返回 false。

类方法

1	listenerCount\(emitter, event\)

返回指定事件的监听器数量。

事件

1	newListener

event - 字符串，事件名称

listener - 处理事件函数

该事件在添加新监听器时被触发。

2	removeListener

event - 字符串，事件名称

listener - 处理事件函数

从指定监听器数组中删除一个监听器。需要注意的是，此操作将会改变处于被删监听器之后的那些监听器的索引。

