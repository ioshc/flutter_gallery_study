import 'package:flutter/material.dart';
import 'home.dart';
import 'options.dart';

class GalleryApp extends StatefulWidget {
  _GalleryAppState createState() => new _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {

  Widget home = new GalleryHome(
    optionsPage: new GalleryOptionsPage(),
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.light(),
      title: 'Flutter Gallery Study',
      color: Colors.grey,
      home: home,
    );
  }
  
}