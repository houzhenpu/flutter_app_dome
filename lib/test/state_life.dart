import 'package:flutter/material.dart';

import 'drag.dart';

class Life extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LifeState();
  }
}

class LifeState extends State<Life> {
  LifeState();

  @override
  void initState() {
    super.initState();
    print('initState()---->');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies()---->');
  }

  String name = '测试';
  @override
  Widget build(BuildContext context) {
    print('build()---->');

    setState(() {

    });

    return Container(
      width: 300,
      height: 300,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext c) => GestureRecognizerTestRoute()));
        },
        child: Text('测试一下'),
      ),
    );
  }

  @override
  void didUpdateWidget(Life oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget()---->');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate()---->');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose()---->');
  }
}
