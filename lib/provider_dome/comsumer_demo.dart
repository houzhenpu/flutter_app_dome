import 'package:flutter/material.dart';
import 'counter_model.dart';
import 'package:provider/provider.dart';
import 'test_icon.dart';

class ConsumerTabPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ConsumerTabPage1 build");
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<double>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Text(
          'Counter: ${_counter.counter}',
          style: TextStyle(fontSize: textSize),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ConsumerTabPage2())),
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class ConsumerTabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ConsumerTabPage2 build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Column(
        children: <Widget>[
          Consumer2<CounterModel, double>(
              builder: (context, CounterModel counter, double textSize, _) =>
                  Text('Counter: ${counter.counter}',
                      style: TextStyle(fontSize: textSize))),
          TestNormal(),
        ],
      ),
      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),
        child: TestIcon(),
      ),
    );
  }
}

class TestNormal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("TestNormal build");
    return Text("TestNormal build");
  }
}
