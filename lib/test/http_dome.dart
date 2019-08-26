import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HttpDome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  httpClientDemo() async {
    try {
      var httpClient = HttpClient();
      httpClient.idleTimeout = Duration(seconds: 5);
      var uri = Uri.parse("https://flutter.dev");
      var request = await httpClient.getUrl(uri);
      request.headers.add("user-agent", "Custom-UA");
      var response = await request.close();

      print('Respone code: ${response.statusCode}');
      print(await response.transform(utf8.decoder).join());
    } catch (e) {
      print('Error:$e');
    }
  }

  httpDemo() async {
    try {
      var client = http.Client();
      var uri = Uri.parse("https://flutter.dev");
      http.Response response =
          await client.get(uri, headers: {"user-agent": "Custom-UA"});
      print('Respone code: ${response.statusCode}');
      print(response.body);
    } catch (e) {
      print('Error:$e');
    }
  }

  dioDemo() async {
    try {
      Dio dio = new Dio();
      var response = await dio.get("https://flutter.dev",
          options: Options(headers: {"user-agent": "Custom-UA"}));
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioParallDemo() async {
    try {
      Dio dio = new Dio();
      List<Response> responseX = await Future.wait([
        dio.get("https://flutter.dev"),
        dio.get("https://pub.dev/packages/dio")
      ]);

      //打印请求1响应结果
      print("Response1: ${responseX[0].toString()}");
      //打印请求2响应结果
      print("Response2: ${responseX[1].toString()}");
    } catch (e) {
      print('Error:$e');
    }
  }

  dioInterceptorReject() async {
    Dio dio = new Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      return dio.reject("Error：拦截的原因");
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioIntercepterCache() async {
    Dio dio = new Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      return dio.resolve("返回缓存数据");
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  dioIntercepterCustomHeader() async {
    Dio dio = new Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.headers["user-agent"] = "Custom-UA";
      return options;
    }));

    try {
      var response = await dio.get("https://flutter.dev");
      print(response.data.toString());
    } catch (e) {
      print('Error:$e');
    }
  }

  String jsonString = '''
    {
      "id":"123",
      "name":"张三",
      "score" : 95,
      "teacher": 
         {
           "name": "李四",
           "age" : 40
         }
    }
    ''';

  static Student parseStudent(String content) {
    final jsonResponse = json.decode(content);
    Student student = Student.fromJson(jsonResponse);
    return student;
  }

  Future<Student> loadStudent() {
    return compute(parseStudent, jsonString);
  }

  jsonParseDemo() {
    loadStudent().then((s) {
      String content = '''
        name: ${s.name}
        score:${s.score}
        teacher:${s.teacher.name}
        ''';
      print(content);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('HttpClient demo'),
              onPressed: () => httpClientDemo(),
            ),
            RaisedButton(
              child: Text('http demo'),
              onPressed: () => httpDemo(),
            ),
            RaisedButton(
              child: Text('Dio demo'),
              onPressed: () => dioDemo(),
            ),
            RaisedButton(
              child: Text('Dio 并发demo'),
              onPressed: () => dioParallDemo(),
            ),
            RaisedButton(
              child: Text('Dio 拦截'),
              onPressed: () => dioInterceptorReject(),
            ),
            RaisedButton(
              child: Text('Dio 缓存'),
              onPressed: () => dioIntercepterCache(),
            ),
            RaisedButton(
              child: Text('Dio 自定义header'),
              onPressed: () => dioIntercepterCustomHeader(),
            ),
            RaisedButton(
              child: Text('JSON解析demo'),
              onPressed: () => jsonParseDemo(),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Student {
  String id;
  String name;
  int score;
  Teacher teacher;

  Student({this.id, this.name, this.score, this.teacher});

  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
        id: parsedJson['id'],
        name: parsedJson['name'],
        score: parsedJson['score'],
        teacher: Teacher.fromJson(parsedJson['teacher']));
  }
}

class Teacher {
  String name;
  int age;

  Teacher({this.name, this.age});

  factory Teacher.fromJson(Map<String, dynamic> parsedJson) {
    return Teacher(name: parsedJson['name'], age: parsedJson['age']);
  }
}
