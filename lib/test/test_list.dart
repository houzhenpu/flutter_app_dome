import 'package:flutter/material.dart';

class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  List _list = [1, 2, 3];
  AnimatedListState get _animatedList => _listKey.currentState;

  void _insert() {
    var index = _list.length;
    for (int i = 0; i < 10; i++) {
      _list.insert(index + i, index + i);
      _animatedList.insertItem(index + i);
    }
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return new CardItem(animation: animation, item: _list[index]);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('AnimatedList'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
          ],
        ),
        body: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.animation,
    @required this.item,
  })  : assert(animation != null),
        assert(item != null && item >= 0),
        super(key: key);

  final Animation<double> animation;
  final int item;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Padding(
      padding: const EdgeInsets.all(2.0),
      child: new SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: new SizedBox(
          height: 128.0,
          child: new Card(
            color: Colors.primaries[item % Colors.primaries.length],
            child: new Center(
              child: new Text('Item $item', style: textStyle),
            ),
          ),
        ),
      ),
    );
  }
}
