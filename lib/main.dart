import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_app/htmlText/flutter_html_textview.dart';
import 'package:flutter_app/test/data_transfer.dart';
import 'package:flutter_app/test/demo_canvas.dart';
import 'package:flutter_app/test/dialog.dart';
import 'package:flutter_app/test/drag.dart';
import 'package:flutter_app/test/event.dart';
import 'package:flutter_app/test/font_test.dart';
import 'package:flutter_app/test/http_dome.dart';
import 'package:flutter_app/test/sliver_view.dart';
import 'package:flutter_app/test/spinkit.dart';
import 'package:flutter_app/test/state_life.dart';
import 'package:flutter_app/test/test_list.dart';
import 'package:flutter_app/test/theme.dart';
import 'package:flutter_app/video/video_dome.dart';
import 'package:flutter_app/video/video_player_dome.dart';
import 'package:oktoast/oktoast.dart';

import 'provider_dome/provider_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    start();
    return OKToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Colors.grey..withAlpha(200),
      radius: 8.0,
      child: MaterialApp(
        home: SingleChildScrollViewTestRoute(),
      ),
    );
  }
}

Isolate isolate;

start() async {
  Future(() => print('f1'))
      .then((_) async => await Future(() => print('f2')))
      .then((_) => print('f3'));
  Future(() async => await Future(() => print('f4')));

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

// ignore: must_be_immutable
class SingleChildScrollViewTestRoute extends StatelessWidget {
  String html =
      '<p><strong>维生素A报价继续向上 月涨幅超20%</strong></p><p>今日，市场消息称DSM瑞士工厂因废水处理的菌种被污染而停产2-3月，国内维生素A产品停报停签。目前，国内维生素A报价继续向上，报价提至370-400元/千克，月涨幅22.58%。</p><p>机构分析，近期VA厂家以停报为主，供应没有完全恢复，交货延缓；贸易商货源有限，惜售或停报观望；实际成交量有待观察。短期来看，5月维生素A价格大概率维持强势。维生素A行业格局良好，前几年无新增产能，目前各家企业维持合理毛利润为主，量紧价高。</p><p>A股上市公司中，<strong><a href="https://www.moer.cn/stockInfo/sz002001.htm" target="_blank">新和成</a>（<a href="https://www.moer.cn/stockInfo/sz002001.htm" target="_blank">002001</a>）</strong>目前公司维生素A粉产能10000吨。<strong><a href="https://www.moer.cn/stockInfo/sh600216.htm" target="_blank">浙江医药</a>（<a href="https://www.moer.cn/stockInfo/sh600216.htm" target="_blank">600216</a>）</strong>目前公司维生素A粉产能5000吨。</p>';
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String htmlUl =
      '<ul class=" list-paddingleft-2" style="list-style-type: disc;"><li><p>box constraints有人也翻译</p></li><li><p>为盒约束、箱约束</p></li><li><p>，我个人还是觉得边界约束可能更直观一些。</p></li></ul>';
  String centerUrl =
      '<p style="text-align: center;">这样做的好处，了统一的渲染。加入样式，会让布局复杂不少，在渲染层面会降低很多性能。因此，Flutter在大的方向上，加入不同类型的布局widget。在小的方向上，只给出很少的定制化的东西，将布局限定在有限的范围内，在完成布局的同时，让整个渲染能够统一，加快了更新和渲染居中结束</p><p style="text-align: right;">但是，缺点也是同样明显，少了很多灵活性，不同的布局方式都被抽离出了widget，大家需要了解的widget非常多，增加了学习成本。</p><p>1.2 约束种类</p>';
  String colorUrl =
      '<em><strong>布局空间。Flutter借鉴了很多React</strong></em></span>相关的东西，<span style="color: #92cf4f;">包括一些布局思想</span>';
  String htmlOl =
      '<p>Flutter中的边界约束，是指</p><ol class=" list-paddingleft-2" style="list-style-type: decimal;"><li><p>widget可以按照指定限定</p></li><li><p>条件，来决定自身如何</p></li></ol><p>占用<span style="text-decoration: underline; color: #e8451a;"><em><strong>布局空间。Flutter借鉴了很多React</strong></em></span>相关的东西，<span style="color: #92cf4f;">包括一些布局思想</span>';
  String moreHtml =
      '<span style="text-decoration: underline; color: #e8451a;"><em><strong>布局空间。Flutter借鉴了很多React</strong></em></span>';
  String emStrong =
      '<p><em><strong>我个人</strong></em>还<em>是觉</em>得边界约束<strong>可能</strong>更直观一些</p>';
  String emStrong1 =
      '<p><strong>在介绍Flutter布局之前，我们得先了解Flutter中的一些布局相关的特性</strong>。</p><p>1.1 边界约束（box constraints）</p><ul class=" list-paddingleft-2" style="list-style-type: disc;"><li><p>box constraints有人也翻译</p></li><li><p>为盒约束、箱约束</p></li><li><p>，我个人还是觉得边界约束可能更直观一些。</p></li></ul><p>Flutter中的边界约束，是指</p><ol class=" list-paddingleft-2" style="list-style-type: decimal;"><li><p>widget可以按照指定限定</p></li><li><p>条件，来决定自身如何</p></li></ol><p>占用<span style="text-decoration: underline; color: #e8451a;"><em><strong>布局空间。Flutter借鉴了很多React</strong></em></span>相关的东西，<span style="color: #92cf4f;">包括一些布局思想</span>，但是它自身没有抽离出布局样式，而是用<span style="color: #0070c0;">不同的widget去实现不同</span>的布局，</p><p><strong><em>将样式嵌入widget中</em></strong>，用户<em><strong>可以像搭</strong></em>积木<em>一样写</em><strong>布局</strong>，<a href="http://www.moer.cn/stockInfo/cn_sh601989.htm" title="中国重工" target="_blank" style="text-decoration:underline;">中国重工</a>&nbsp;&nbsp;写法上跟React很像，只不过没了样式的设定。</p><p><img src="https://static.moer.cn/O/201904307b35e691b0332bba01bf1d1af85ee107.jpeg?mark=1" title="201904307b35e691b0332bba01bf1d1af85ee107.jpeg" alt=""/></p><p>作者：<a href="https://www.imooc.com/article/details/id/31493" title="侯爷" target="_blank">侯爷</a>链接：https://www.imooc.com/article/details/id/31493<br/>来源：慕课网</p><p><img src="https://static.moer.cn/staticFile/1080*1246A/201804251c4be5b27990001655b3b1467952675b.png" alt=""/><br/></p>';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('sdfsdf'),
              Text('sdfsdf'),
              Text('sdfsdf'),
              Text('sdfsdf'),
              MaterialButton(
                child: Text('拖动'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) => DragTest()));
                },
              ),
              InkWell(
                child: Text('图片缩放'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) => ScaleTestRoute()));
                },
              ),
              InkWell(
                child: Text('字体变色点击'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) =>
                              GestureRecognizerTestRoute()));
                },
              ),
              InkWell(
                child: Text('生命周期'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext c) => Life()));
                },
              ),
              InkWell(
                child: Text('SliverView'),
                highlightColor: Colors.blue,
                splashColor: Colors.grey,
                hoverColor: Colors.teal,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) => SliverView()));
                },
              ),
              MaterialButton(
                child: Text('主题'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) => ThemeTestRoute()));
                },
              ),
              MaterialButton(
                child: Text('DialogShow'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) => DialogShowDome()));
                },
              ),
              MaterialButton(
                child: Text('EventDomeMaster'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => EventDome()))
                      .then((value) {});
                },
              ),
              MaterialButton(
                child: Text('VideoPlayerTest'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) => VideoPlayer()));
                },
              ),
              MaterialButton(
                child: Text('ShowVideo'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext c) => VideoApp()));
                },
              ),
              MaterialButton(
                child: Text('DataTransfer 跨组建数据传递'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => DataTransfer()))
                      .then((value) {});
                },
              ),
              MaterialButton(
                child: Text('HttpDome'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => HttpDome()))
                      .then((value) {});
                },
              ),
              MaterialButton(
                child: Text('FontTest'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => FontTest()))
                      .then((value) {});
                },
              ),
              MaterialButton(
                child: Text('ProviderMain'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => ProviderMain()))
                      .then((value) {});
                },
              ),
              //DemoCanvas
              MaterialButton(
                child: Text('DemoCanvas 虚线绘制'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => DemoCanvas()))
                      .then((value) {});
                },
              ),
              MaterialButton(
                child: Text('进度条'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => Spinkit()))
                      .then((value) {});
                },
              ),

              MaterialButton(
                child: Text('进度条'),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext c) => TestList()))
                      .then((value) {});
                },
              ),

              StatefulW("text1"),
              StatefulW("text2"),
              StatefulW("text3"),
              Container(
                child: new HtmlTextView(
                  data: html,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  data: htmlUl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  data: centerUrl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  data: colorUrl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  data: htmlOl,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  data: moreHtml,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  data: emStrong,
                ),
              ),
              Container(
                child: new HtmlTextView(
                  data: emStrong1,
                ),
              ),
              TextField(
                maxLines: 5,
                autofocus: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: "我来说两句",
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none, //隐藏下划线
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
