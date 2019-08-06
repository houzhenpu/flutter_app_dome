import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DragTest extends StatefulWidget {
  @override
  _DragTestState createState() => new _DragTestState();
}

class _DragTestState extends State<DragTest>
    with SingleTickerProviderStateMixin {
  double _top = 12.0; //距顶部的偏移
  double _left = 0.0; //距左边的偏移
  double _leftB = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            child: CircleAvatar(
              child: Text("来"),
              radius: 40,
            ),
            //手指按下时会触发此回调
            onPanDown: (DragDownDetails e) {
              //打印手指按下的位置(相对于屏幕)
              print("用户手指按下：${e.globalPosition}");
            },
            //手指滑动时会触发此回调
            onPanUpdate: (DragUpdateDetails e) {
              //用户手指滑动时，更新偏移，重新构建
              setState(() {
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
            onPanEnd: (DragEndDetails e) {
              //打印滑动结束时在x、y轴上的速度
              print(e.velocity);
            },
          ),
        ),
        Positioned(
          top: 80.0,
          left: _leftB,
          child: Listener(
            onPointerDown: (details) {
              print("down");
            },
            onPointerUp: (details) {
              //会触发
              print("up");
            },
            child: GestureDetector(
              child: CircleAvatar(child: Text("B")),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                setState(() {
                  _leftB += details.delta.dx;
                });
              },
              onHorizontalDragEnd: (details) {
                print("onHorizontalDragEnd");
              },
            ),
          ),
        )
      ],
    );
  }
}

class ScaleTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScaleTestRouteState();
  }
}

class ScaleTestRouteState extends State<ScaleTestRoute> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset("assets/images/test.png", width: _width),
        onDoubleTap: () {
          setState(() {
            _width = 200 * 2.0.clamp(0.5, 100.0);
            print('_width---->$_width');
          });
        },
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
          });
        },
      ),
    );
  }
}

class GestureRecognizerTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GestureRecognizerTestRouteState();
  }
}

class GestureRecognizerTestRouteState
    extends State<GestureRecognizerTestRoute> {
  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false; //变色开关

  @override
  void dispose() {
    //用到GestureRecognizer的话一定要调用其dispose方法释放资源
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text.rich(TextSpan(children: [
          TextSpan(text: "你好世界"),
          TextSpan(
            text: "点我变色",
            style: TextStyle(
                fontSize: 30.0,
                color: _toggle ? Colors.blue : Colors.red,
                backgroundColor: _toggle ? Colors.grey : Colors.white),
            recognizer: _tapGestureRecognizer
              ..onTap = () {
                setState(() {
                  print('onTap------->');
                  //_toggle = !_toggle;
                });
              }
              ..onTapCancel = () {
                setState(() {
                  print('onTapCancel------->');
                  _toggle = !_toggle;
                });
              }
              ..onTapDown = (TapDownDetails t) {
                setState(() {
                  print('onTapDown------->');
                  _toggle = !_toggle;
                });
              }
              ..onTapUp = (TapUpDetails t){
                setState(() {
                  print('onTapUp------->');
                  _toggle = !_toggle;
                });
              },
          ),
          TextSpan(text: "你好世界"),
        ])),
      ),
    );
  }
}
