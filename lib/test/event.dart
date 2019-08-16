import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Dome'),
      ),
      body: Listener(
        child: Container(
          color: Colors.red, // 背景色红色
          width: double.infinity,
          child: Image.asset(
            "assets/images/dialog2.png",
            fit: BoxFit.fill,
          ),
        ),
        onPointerDown: (event) => print("down $event"), // 手势按下回调
        onPointerMove: (event) => print("move $event"), // 手势移动回调
        onPointerUp: (event) {
          print("up $event");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext c) => GestureDetectorDome()));
        }, // 手势抬起回调
      ),
    );
  }
}

class GestureDetectorDome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GestureDetectorState();
  }
}

class GestureDetectorState extends State<GestureDetectorDome> {
  double _top = 100.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return // 红色 container 坐标
        Stack(
      // 使用 Stack 组件去叠加视图，便于直接控制视图坐标
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            // 手势识别
            child: Container(color: Colors.red, width: 50, height: 50),
            // 红色子视图
            onTap: () {
              print("Tap");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext c) =>
                          CustomGestureDetectorDome()));
            },
            // 点击回调
            onDoubleTap: () => print("Double Tap"),
            // 双击回调
            onLongPress: () => print("Long Press"),
            // 长按回调
            onPanUpdate: (e) {
              // 拖动回调
              setState(() {
                // 更新位置
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
          ),
        )
      ],
    );
  }
}

class CustomGestureDetectorDome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomGestureDetectorState();
  }
}

class CustomGestureDetectorState extends State<CustomGestureDetectorDome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Parent tapped'), // 父视图的点击回调
      child: Container(
        color: Colors.cyan[200],
        child: Center(
          child: GestureDetector(
            onTap: () {
              print('Child tapped');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext c) =>
                          MultipleTapGesture()));
            }, // 子视图的点击回调
            child: Container(
              color: Colors.blueAccent,
              width: 200.0,
              height: 200.0,
            ),
          ),
        ),
      ),
    );
    ;
  }
}

class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}

class MultipleTapGesture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RawGestureDetector(
      // 自己构造父 Widget 的手势识别映射关系
      gestures: {
        // 建立多手势识别器与手势识别工厂类的映射关系，从而返回可以响应该手势的 recognizer
        MultipleTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<MultipleTapGestureRecognizer>(
          () => MultipleTapGestureRecognizer(),
          (MultipleTapGestureRecognizer instance) {
            instance.onTap = () => print('parent tapped '); // 点击回调
          },
        )
      },
      child: Container(
        color: Colors.pinkAccent[50],
        child: Center(
          child: GestureDetector(
            // 子视图可以继续使用 GestureDetector
            onTap: () => print('Child tapped'),
            child: Container(
              color: Colors.deepPurple[100],
              width: 200.0,
              height: 200.0,
            ),
          ),
        ),
      ),
    );
    ;
  }
}
