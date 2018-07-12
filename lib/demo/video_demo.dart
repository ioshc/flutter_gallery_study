import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

const String beeUri =
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

class VideoCard extends StatelessWidget {
  const VideoCard({Key key, this.controller, this.title, this.subtitle}) : super(key: key);

  final VideoPlayerController controller;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return new SafeArea(top: false, bottom: false, child: new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(title: new Text(title), subtitle: new Text(subtitle),),
          new GestureDetector(
            onTap: null,
            child: new VideoPlayer(controller),
          )
        ],
      ),
    ),);
  }
}

class VideoDemo extends StatefulWidget {
  const VideoDemo({Key key}) : super(key: key);

  static const String routeName = '/video';

  @override
  VideoDemoState createState() => new VideoDemoState();
}

class VideoDemoState extends State<VideoDemo> with SingleTickerProviderStateMixin {

  final VideoPlayerController butterflyController =
  new VideoPlayerController.asset(
    'videos/butterfly.mp4',
    package: 'flutter_gallery_assets',
  );
  final VideoPlayerController beeController = new VideoPlayerController.network(
    beeUri,
  );

  final Completer<Null> connectedCompleter = new Completer<Null>();

  @override
  void initState() {
    Future<Null> initController(VideoPlayerController controller) async {
      controller.setLooping(true);
      controller.setVolume(0.0);
      controller.play();
      await connectedCompleter.future;
      await controller.initialize();
      setState(() {});
    }

    initController(butterflyController);
    initController(beeController);

    super.initState();
  }

  @override
  void dispose() {
    butterflyController.dispose();
    beeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Videos'),
      ),
      body: new ListView(
        children: <Widget>[
          new VideoCard(
            controller: butterflyController,
            title: 'Butterfly',
            subtitle: '… flutters by',
          ),
          new VideoCard(
            controller: beeController,
            title: 'Bee',
            subtitle: '… gently buzzing',
          ),
        ],
      ),
    );
  }
}
