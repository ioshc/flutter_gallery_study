import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.blueAccent,
      child: new Text('Videos'),
    );
  }
}

class VideoDemo extends StatelessWidget {
  const VideoDemo({ Key key }) : super(key: key);

  static const String routeName = '/video';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Videos'),
      ),
      body: new ListView(
        children: <Widget>[
          new VideoCard(),
          new VideoCard(),
          new VideoCard(),
        ],
      ),
    );
  }
}