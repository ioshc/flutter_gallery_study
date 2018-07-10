import 'package:flutter/material.dart';

class PestoDemo extends StatelessWidget {
  const PestoDemo({ Key key }) : super(key: key);

  static const String routeName = '/pesto';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Typography'),
      ),
      body: new ListView(
        children: <Widget>[
          new Card(
            color: Colors.blueAccent,
            child: new Text('Typography'),
          )
        ],
      ),
    );
  }
}