import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeTestRoute extends StatefulWidget {
  @override
  _ThemeTestRouteState createState() => new _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  Color _themeColor = Colors.teal; //当前路由主题色
  ThemeData theme = kIOSTheme;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Icon(Icons.favorite),
              Icon(Icons.airport_shuttle),
              Text("  颜色跟随主题")
            ]),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: ThemeData(
                textTheme: TextTheme(body1: TextStyle(color: Colors.yellow)),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Icon(Icons.airport_shuttle),
                    Text("  颜色固定黑色", style: Theme
                        .of(context)
                        .textTheme
                        .body1,)
                  ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () =>
                setState(() =>
                theme = theme == kIOSTheme ? kAndroidTheme : kIOSTheme
                ),
            child: Icon(Icons.palette)),
      ),
    );
  }
}

// iOS 浅色主题
final ThemeData kIOSTheme = ThemeData(
    brightness: Brightness.light,
    // 亮色主题
    accentColor: Colors.white,
    //(按钮)Widget 前景色为白色
    primaryColor: Colors.blue,
    // 主题色为蓝色
    iconTheme: IconThemeData(color: Colors.grey),
    //icon 主题为灰色
    textTheme: TextTheme(body1: TextStyle(color: Colors.black)) // 文本主题为黑色
);
// Android 深色主题
final ThemeData kAndroidTheme = ThemeData(
    brightness: Brightness.dark,
    // 深色主题
    accentColor: Colors.black,
    //(按钮)Widget 前景色为黑色
    primaryColor: Colors.cyan,
    // 主题色 Wie 青色
    iconTheme: IconThemeData(color: Colors.blue),
    //icon 主题色为蓝色
    textTheme: TextTheme(body1: TextStyle(color: Colors.red)) // 文本主题色为红色
);
