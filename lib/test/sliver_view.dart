import 'package:flutter/material.dart';

class SliverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        //SliverAppBar 作为头图控件
        title: Text('CustomScrollView Demo'),
        // 标题
        floating: true,
        // 设置悬浮样式
        flexibleSpace: Image.asset("assets/images/test.png", fit: BoxFit.cover),
        // 设置悬浮头图背景
        expandedHeight: 200, // 头图控件高度
      ),
      SliverList(
        //SliverList 作为列表控件
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(
                title: Text('Item #$index'),
                subtitle: Text('subtitle $index'),
                trailing: Text('trailing $index'),
                isThreeLine: false,
              ),
          // 列表项创建方法
          childCount: 100, // 列表元素个数
        ),
      ),
    ]));
  }
}


