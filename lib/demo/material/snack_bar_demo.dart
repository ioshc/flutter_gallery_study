import 'package:flutter/material.dart';

const String _text1 =
    'Snackbars provide lightweight feedback about an operation by '
    'showing a brief message at the bottom of the screen. Snackbars '
    'can contain an action.';

const String _text2 =
    'Snackbars should contain a single line of text directly related '
    'to the operation performed. They cannot contain icons.';

const String _text3 =
    'By default snackbars automatically disappear after a few seconds ';

class SnackbarDemo extends StatefulWidget {
  static const String routeName = 'material/snack-bar';

  _SnackbarDemoState createState() => _SnackbarDemoState();
}

class _SnackbarDemoState extends State<SnackbarDemo> {
  int _tappedCount = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Snackbar'),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new SafeArea(
          top: false,
          bottom: false,
          child: new ListView(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
            children: <Widget>[
              new Text(_text1),
              new Padding(padding: const EdgeInsets.only(top: 30.0)),
              new Text(_text2),
              new Padding(padding: const EdgeInsets.only(top: 30.0)),
              new Center(
                child: new RaisedButton(
                  child: const Text('SHOW A SNACKBAR'),
                  onPressed: () {
                    final int thisSnackBarIndex = _tappedCount++;
                    Scaffold.of(context).showSnackBar(
                          new SnackBar(
                            content:
                                new Text('This is snackbar #$thisSnackBarIndex'),
                            action: new SnackBarAction(
                              label: 'ACTION',
                              onPressed: () {
                                Scaffold.of(context).showSnackBar(
                                      new SnackBar(
                                        content: new Text(
                                            'You pressed snackbar $thisSnackBarIndex\'s action.'),
                                      ),
                                    );
                              },
                            ),
                          ),
                        );
                  },
                ),
              ),
              new Padding(padding: const EdgeInsets.only(top: 30.0)),
              new Text(_text3),
            ],
          ),
        );
      }),
    );
  }
}
