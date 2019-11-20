import 'package:flutter/material.dart';

class DemoCanvas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Flutter绘制虚线'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: CustomPaint(
          // size：当child为null时，代表默认绘制区域大小，如果有child则忽略此参数，画布尺寸则为child尺寸
          size: Size(MediaQuery.of(context).size.width, 300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint() // 创建一个画笔并配置其属性
      ..strokeWidth = 2 // 画笔的宽度
      ..isAntiAlias = true // 是否抗锯齿
      ..color=Color(0x77cdb175); // 画笔颜色

    var max =  size.width; // size获取到宽度
    var dashWidth = 5;
    var dashSpace = 5;
    double startX = 0;
    final space = (dashSpace + dashWidth);

    while (startX < max) {
      canvas.drawLine(Offset(startX, 100.0), Offset(startX + dashWidth, 100.0), paint);
      startX += space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}