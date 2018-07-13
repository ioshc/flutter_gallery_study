import 'package:flutter/material.dart';

class ProgressIndicatorDemo extends StatefulWidget {
  static const String routeName = '/material/progress-indicator';

  @override
  _ProgressIndicatorDemoState createState() =>
      new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _animation = new CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.9, curve: Curves.fastOutSlowIn),
        reverseCurve: Curves.fastOutSlowIn
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed)
        _controller.forward();
      else if (status == AnimationStatus.completed)
        _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      // valueAnimation.isAnimating is part of our build state
      if (_controller.isAnimating) {
        _controller.stop();
      } else {
        switch (_controller.status) {
          case AnimationStatus.dismissed:
          case AnimationStatus.forward:
            _controller.forward();
            break;
          case AnimationStatus.reverse:
          case AnimationStatus.completed:
            _controller.reverse();
            break;
        }
      }
    });
  }

  Widget _buildIndicator(BuildContext context, Widget child) {
    return new Padding(
      padding: const EdgeInsets.all(40.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
              width: 200.0, child: const LinearProgressIndicator()),
          new Padding(padding: const EdgeInsets.only(top: 40.0)),
          new LinearProgressIndicator(),
          new Padding(padding: const EdgeInsets.only(top: 40.0)),
          new LinearProgressIndicator(),
          new Padding(padding: const EdgeInsets.only(top: 40.0)),
          new LinearProgressIndicator(value: _animation.value,),
          new Padding(padding: const EdgeInsets.only(top: 80.0)),
          new Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new CircularProgressIndicator(),
              new Padding(padding: const EdgeInsets.only(left: 40.0)),
              new SizedBox(
                width: 20.0,
                height: 20.0,
                child:
                new CircularProgressIndicator(value: _animation.value),
              ),
              new Padding(padding: const EdgeInsets.only(left: 100.0)),
              new Text('${(_animation.value * 100.0).toStringAsFixed(1)}%')
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Progress indicators'),
      ),
      body: new GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new AnimatedBuilder(
              animation: _animation,
              builder: _buildIndicator,
          ),
        ),
      ),
    );
  }
}
