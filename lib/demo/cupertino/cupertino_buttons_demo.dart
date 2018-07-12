import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoButtonsDemo extends StatefulWidget {
  static const String routeName = '/cupertino/buttons';

  @override
  _CupertinoButtonsDemoState createState() => new _CupertinoButtonsDemoState();
}

class _CupertinoButtonsDemoState extends State<CupertinoButtonsDemo> {
  int _pressedCount = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Cupertino Buttons'),
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(16.0),
            child: new Text(
                'iOS themed buttons are flat. They can have borders or backgrounds but '
                'only when necessary.'),
          ),
          new Expanded(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(_pressedCount > 0 ? 'Button pressed $_pressedCount time${_pressedCount == 1 ? "" : "s"}'
                      : ' ',),
                  new Padding(padding: new EdgeInsets.all(12.0)),
                  new Align(
                    alignment: new Alignment(0.0, -0.2),
                    child: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new CupertinoButton(
                          child: const Text('Cupertino Button'),
                          onPressed: () {
                            setState(() {
                              _pressedCount++;
                            });
                          },
                        ),
                        new CupertinoButton(
                          child: const Text('Disabled'),
                          onPressed: null,
                        ),
                      ],
                    ),
                  ),
                  new Padding(padding: new EdgeInsets.all(12.0)),
                  new CupertinoButton(
                    child: const Text('With Background'),
                    color: CupertinoColors.activeBlue,
                    onPressed: () {
                      setState(() {
                        _pressedCount++;
                      });
                    },
                  ),
                  new Padding(padding: new EdgeInsets.all(12.0)),
                  new CupertinoButton(
                    child: const Text('Disabled'),
                    color: CupertinoColors.activeBlue,
                    onPressed: null,
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
