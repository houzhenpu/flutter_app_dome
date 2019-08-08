import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogShowDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog Unit'),
      ),
      body: DialogShow(),
    );
  }
}

class DialogShow extends StatefulWidget {
  @override
  _DialogShowState createState() => _DialogShowState();
}

class _DialogShowState extends State<DialogShow> {
  @override
  Widget build(BuildContext context) {
    var title = Container(
      alignment: AlignmentDirectional.center,
      child: Text(
        "Dialog Unit",
        style: TextStyle(fontSize: 30),
      ),
    );

    Map<String, Function> buttons = {
      "对话框SimpleDialog": _showSimpleDialog,
      "对话框AlertDialog": _showAlertDialog,
      "对话框CupertinoAlertDialog": _showCupertinoAlertDialog,
      "对话框显示自己": _showWidgetDialog,
      "对话框显示StatefulWidget": _showStatefulWidgetDialog,
      "Scaffold": _showScaffold,
      "BottomSheet": _showBottomSheet,
    };

    var btns = buttons.keys.toList().map((str) {
      //构建按钮组件列表
      return RaisedButton(
        onPressed: () {
          buttons[str](context);
        },
        child: Text(
          str,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList();

    var result = Column(
      children: <Widget>[
        title,
        Column(
          children: btns,
        )
      ],
    );
    return result;
  }

  _showSimpleDialog(BuildContext context) {
    var strs = [
      '云深不知处内亥时息,卯时起',
      "云深不知处内不可挑食留剩,不可境内杀生",
      "云深不知处内不可私自斗殴,不可淫乱",
      "云深不知处禁止魏无羡入内,不可吹笛"
    ];

    var title = Row(
      //标题
      children: <Widget>[
        Image.asset(
          "assets/images/dialog3.png",
          width: 30,
          height: 30,
        ),
        SizedBox(
          width: 10,
        ),
        new Text("蓝氏家规")
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: title,
            children: strs.map((str) {
              return SimpleDialogOption(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.turned_in_not,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        str,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop(str);
                  print(str);
                },
              );
            }).toList(),
          );
        });
  }

  _showAlertDialog(BuildContext context) {
    var title = Row(
      //标题
      children: <Widget>[
        Image.asset(
          "assets/images/dialog4.png",
          width: 30,
          height: 30,
          fit:BoxFit.cover,
        ),
        SizedBox(
          width: 10,
        ),
        new Text("表白")
      ],
    );
    var content = Row(
      //内容
      children: <Widget>[
        Text("我💖你，你是我的"),
        Image.asset(
          "assets/images/dialog2.png",
          width: 30,
          height: 30,
        )
      ],
    );

    showDialog(
        context: context,
        builder: (context) => //构造器
            AlertDialog(title: title, content: content, actions: <Widget>[
              FlatButton(
                child: Text("不要闹"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("走开"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]));
  }

  void _showCupertinoAlertDialog(BuildContext context) {
    var title = Row(
      //标题
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          "assets/images/dialog5.jpg",
          width: 30,
          height: 30,
        ),
        SizedBox(
          width: 10,
        ),
        new Text("表白")
      ],
    );
    var content = Row(
      children: <Widget>[
        Text(
          "我💖你，你是我的",
          style: TextStyle(fontSize: 20),
        ),
        Image.asset(
          "assets/images/dialog1.png",
          width: 40,
          height: 40,
        )
      ],
    );
    var dialog = CupertinoAlertDialog(
      content: content,
      title: title,
      actions: <Widget>[
        CupertinoButton(
          child: Text("不要闹"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: Text("走开"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    showDialog(context: context, builder: (context) => dialog);
  }

  _showWidgetDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return this.widget;
        });
  }

  _showStatefulWidgetDialog(BuildContext context) {
    var progress = 0.0;
    StateSetter stateSetter;

    Timer.periodic(Duration(milliseconds: 100), (timer) {
      //计时器模拟进度增加
      progress += 0.1;
      if (stateSetter != null) {
        stateSetter(() {});
      }
      if (progress >= 1) {
        timer.cancel();
        stateSetter = null;
        Navigator.of(context).pop();
      }
    });

    var statefulBuilder = StatefulBuilder(
      builder: (ctx, state) {
        stateSetter = state;
        return Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Card(
              elevation: 24.0,
              color: Colors.blue.withAlpha(240),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    value: progress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Loading...",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "done ${((progress - 0.1) * 100).toStringAsFixed(1)}%",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    showDialog(context: context, builder: (ctx) => statefulBuilder);
  }

  _showScaffold(BuildContext context) {
    var snackBar = SnackBar(
        backgroundColor: Color(0xffFB6431), //颜色
        content: Text('Hello!'), //内容
        duration: Duration(seconds: 3), //持续时间
        action: SnackBarAction(
            label: '确定',
            onPressed: () {
              print("Flutter之旅");
            }));
    Scaffold.of(context).showSnackBar(snackBar); //这样就行了
  }

  bool _showing = false;

  _showBottomSheet(BuildContext context) {
    var bottomSheet = BottomSheet(
        onClosing: () {},
        builder: (context) => (Container(
              color: Color(0xdde3fbf6),
              height: 150,
              child: Center(
                child: Image.asset("assets/images/dialog.png"),
              ),
            )));
    if (_showing) {
      Navigator.of(context).pop();
    } else {
      Scaffold.of(context).showBottomSheet(bottomSheet.builder); //这样就行了
    }
    _showing = !_showing;
  }
}
