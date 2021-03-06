
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoProgressIndicatorDemo extends StatelessWidget {
  static const String routeName = '/cupertino/progress_indicator';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Cupertino Activity Indicator'),
      ),
      body: const Center(
        child: const CupertinoActivityIndicator(),
      ),
    );
  }
}
