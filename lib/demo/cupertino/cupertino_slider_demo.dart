import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSliderDemo extends StatefulWidget {
  static const String routeName = 'cupertino/slider';

  @override
  _CupertinoSliderDemoState createState() => _CupertinoSliderDemoState();
}

class _CupertinoSliderDemoState extends State<CupertinoSliderDemo> {
  double _fistValue = 0.0;
  double _secondValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Cupertino Sliders'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new CupertinoSlider(
                  value: _fistValue,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (double value) {
                    setState(() {
                      _fistValue = value;
                    });
                  },
                ),
                new Text('Cupertino Countinues:${_fistValue.toStringAsFixed(1)}'),
              ],
            ),
            new Column(
              children: <Widget>[
                new CupertinoSlider(
                  value: _secondValue,
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  onChanged: (double value) {
                    setState(() {
                      _secondValue = value;
                    });
                  },
                ),
                new Text('Cupertino Discrete:${_secondValue.toStringAsFixed(1)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
