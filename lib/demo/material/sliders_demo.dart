import 'package:flutter/material.dart';

class SlidersDemo extends StatefulWidget {
  static const String routeName = 'material/sliders';

  @override
  _SlidersDemoState createState() => _SlidersDemoState();
}

class _SlidersDemoState extends State<SlidersDemo> {
  double _slider1Value = 0.0;
  double _discreteValue = 30.0;

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Sliders'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Padding(
          padding: const EdgeInsets.all(40.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Slider(
                    value: _slider1Value,
                    onChanged: (double value) {
                      setState(() {
                        _slider1Value = value;
                      });
                    },
                  ),
                  new Text('Countinues'),
                ],
              ),
              new Column(
                children: <Widget>[
                  new Slider(
                    value: 0.2,
                  ),
                  new Text('Disabled'),
                ],
              ),
              new Column(
                children: <Widget>[
                  new Slider(
                    min: 0.0,
                    max: 200.0,
                    value: _discreteValue,
                    divisions: 5,
                    label: '${_discreteValue.round()}',
                    onChanged: (double value) {
                      setState(() {
                        _discreteValue = value;
                      });
                    },
                  ),
                  new Text('Discreate'),
                ],
              ),
              new Column(
                children: <Widget>[
                  new SliderTheme(
                    data: theme.sliderTheme.copyWith(
                      activeTrackColor: Colors.deepPurple,
                      inactiveTrackColor: Colors.black26,
                      activeTickMarkColor: Colors.white70,
                      inactiveTickMarkColor: Colors.black,
                      overlayColor: Colors.black12,
                      thumbColor: Colors.deepPurple,
                      valueIndicatorColor: Colors.deepPurpleAccent,
                    ),
                    child: new Slider(
                      min: 0.0,
                      max: 200.0,
                      value: _discreteValue,
                      divisions: 5,
                      label: '${_discreteValue.round()}',
                      onChanged: (double value) {
                        setState(() {
                          _discreteValue = value;
                        });
                      },
                    ),
                  ),
                  new Text('Discreate with Custom Theme'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
