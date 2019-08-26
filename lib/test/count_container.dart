import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0;

  void _incrementCounter() => setState(() {
        count++;
        Future(() => print('f1')); // 声明一个匿名 Future
        Future fx = Future(() => null); // 声明 Future fx，其执行体为 null

// 声明一个匿名 Future，并注册了两个 then。在第一个 then 回调里启动了一个微任务
        Future(() => print('f2')).then((_) {
          print('f3');
          scheduleMicrotask(() => print('f4'));
        }).then((_) => print('f5'));

// 声明了一个匿名 Future，并注册了两个 then。第一个 then 是一个 Future
        Future(() => print('f6'))
            .then((_) => Future(() => print('f7')))
            .then((_) => print('f8'));

// 声明了一个匿名 Future
        Future(() => print('f9'));

// 往执行体为 null 的 fx 注册了了一个 then
        fx.then((_) => print('f10'));

// 启动一个微任务
        scheduleMicrotask(() => print('f11'));
        print('f12');

        //f1 比 f2 先执行
        Future(() => print('ffff1'));
        Future(() => print('ffff2'));

//f3 执行后会立刻同步执行 then 3
        Future(() => print('ffff3')).then((_) => print('then 3'));

//then 4 会加入微任务队列，尽快执行
        Future(() => null).then((_) => print('then 4'));

//    print("func before");
//    delayedFetchContent();
//    print("func after");

        testAwait();
        Future(() => print('f1'))
            .then((_) async => await Future(() => print('f2')))
            .then((_) => print('f3'));
        Future(() => print('f4'));

      });

  testAwait() async {
    print("func before");
    delayedFetchContent();
    print("func after");
    start();
  }

  delayedFetchContent() async {
    print(await fetchContent()); // 等待 Hello 2019 的返回
  }

  // 声明了一个延迟 3 秒返回 Hello 的 Future，并注册了一个 then 返回拼接后的 Hello 2019
  Future<String> fetchContent() =>
      Future<String>.delayed(Duration(seconds: 3), () => "Hello")
          .then((x) => "$x 2019");

  @override
  Widget build(BuildContext context) {
    return CountContainer(
        //increment: _incrementCounter,
        model: this,
        increment: _incrementCounter,
        child: Counter());
  }
}


Isolate isolate;

start() async {
  ReceivePort receivePort = ReceivePort(); // 创建管道
  // 创建并发 Isolate，并传入发送管道
  isolate = await Isolate.spawn(getMsg, receivePort.sendPort);
  // 监听管道消息
  receivePort.listen((data) {
    print('Data：$data');
    receivePort.close(); // 关闭管道
    isolate?.kill(priority: Isolate.immediate); // 杀死并发 Isolate
    isolate = null;
  });
}

// 并发 Isolate 往管道发送一个字符串
getMsg(sendPort) => sendPort.send("Hello  ReceivePort");

// 同步计算阶乘
int syncFactorial(n) => n < 2 ? n : n * syncFactorial(n-1);
// 使用 compute 函数封装 Isolate 的创建和结果的返回
main() async => print(await compute(syncFactorial, 4));

class CountContainer extends InheritedWidget {
  static CountContainer of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CountContainer) as CountContainer;

  final _CounterPageState model;

  final Function() increment;

  CountContainer({
    Key key,
    @required this.model,
    @required this.increment,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountContainer oldWidget) => model != oldWidget.model;
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountContainer state = CountContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("InheritedWidget demo"),
      ),
      body: Text(
        'You have pushed the button this many times: ${state.model.count}',
      ),
      floatingActionButton: FloatingActionButton(onPressed: state.increment),
    );
  }
}
