import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoSwitchDemo extends StatefulWidget {
  static const String routeName = 'cupertino/switch';

  @override
  _CupertinoSwitchDemoState createState() => _CupertinoSwitchDemoState();
}

class _CupertinoSwitchDemoState extends State<CupertinoSwitchDemo> {
  bool _isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Cupertino Switchs'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new CupertinoSwitch(
                  value: _isSwitchOn,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitchOn = value;
                    });
                  },
                ),
                new Text('Active'),
              ],
            ),
            new Column(
              children: <Widget>[
                new CupertinoSwitch(
                  value: true,
                  onChanged: null,
                ),
                new Text('Disabled'),
              ],
            ),
            new Column(
              children: <Widget>[
                new CupertinoSwitch(
                  value: false,
                  onChanged: null,
                ),
                new Text('Disabled'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
