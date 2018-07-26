import 'package:flutter/material.dart';
import 'full_screen_dialog_demo.dart';

enum DialogDemoAction {
  cancel,
  discard,
  disagree,
  agree,
}

const String _alertWithoutTitleText = 'Discard draft?';

const String _alertWithTitleText =
    'Let Google help apps determine location. This means sending anonymous location '
    'data to Google, even when no apps are running.';

class DialogsDemo extends StatefulWidget {
  static const routeName = 'material/dialogs';

  @override
  _DialogsDemoState createState() => new _DialogsDemoState();
}

class _DialogsDemoState extends State<DialogsDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    final DateTime now = new DateTime.now();
    _selectedTime = new TimeOfDay(hour: now.hour, minute: now.minute);
  }

  void _showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: new Text('You selected: $value')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Dialogs'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                _showDemoDialog(
                    context: context,
                    child: new AlertDialog(
                      title: new Text(
                        _alertWithoutTitleText,
                        style: dialogTextStyle,
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.cancel);
                          },
                          child: const Text('CANCEL'),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.discard);
                          },
                          child: const Text('DISCARD'),
                        ),
                      ],
                    ));
              },
              child: const Text('ALERT'),
            ),
            new SizedBox(
              height: 20.0,
            ),
            new RaisedButton(
              onPressed: () {
                _showDemoDialog(
                    context: context,
                    child: new AlertDialog(
                      title: const Text("Use Google's location service?"),
                      content:
                          new Text(_alertWithTitleText, style: dialogTextStyle),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.disagree);
                          },
                          child: const Text('DISAGREE'),
                        ),
                        new FlatButton(
                          onPressed: () {
                            Navigator.pop(context, DialogDemoAction.agree);
                          },
                          child: const Text('AGREE'),
                        ),
                      ],
                    ));
              },
              child: const Text('ALERT WITH TITLE'),
            ),
            new SizedBox(
              height: 20.0,
            ),
            new RaisedButton(
              onPressed: () {
                _showDemoDialog(
                    context: context,
                    child: new SimpleDialog(
                      title: const Text("Set backup account"),
                      children: <Widget>[
                        new SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'username@gmail.com');
                          },
                          child: new ListTile(
                            leading: const Icon(
                              Icons.perm_contact_calendar,
                              color: Colors.blue,
                            ),
                            title: const Text('username@gmail.com'),
                          ),
                        ),
                        new SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, 'user2@gmail.com');
                          },
                          child: new ListTile(
                            leading: const Icon(
                              Icons.perm_contact_calendar,
                              color: Colors.blue,
                            ),
                            title: const Text('user2@gmail.com'),
                          ),
                        ),
                        new SimpleDialogOption(
                          child: new ListTile(
                            leading: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.grey,
                            ),
                            title: const Text('add account'),
                          ),
                        ),
                      ],
                    ));
              },
              child: const Text('SIMPLE'),
            ),
            new SizedBox(
              height: 20.0,
            ),
            new RaisedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                ).then((TimeOfDay value) {
                  if (value != null && value != _selectedTime) {
                    _selectedTime = value;
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        content: new Text(
                            'You selected: ${value.format(context)}')));
                  }
                });
              },
              child: const Text('CONFIRMATION'),
            ),
            new SizedBox(
              height: 20.0,
            ),
            new RaisedButton(
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute<DismissDialogAction>(
                  builder: (BuildContext context) => new FullScreenDialogDemo(),
                  fullscreenDialog: true,
                ));
              },
              child: const Text('FULLSCREEN'),
            ),
          ],
        ),
      ),
    );
  }
}
