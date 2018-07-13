import 'package:flutter/material.dart';

const String _introText =
    'Tooltips are short identifying messages that briefly appear in response to '
    'a long press. Tooltip messages are also used by services that make Flutter '
    'apps accessible, like screen readers.';

class TooltipDemo extends StatelessWidget {
  static const String routeName = '/material/tooltips';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Tolltips'),
      ),
      body: new Builder(builder: (BuildContext context) {
        return new SafeArea(
          top: false,
          bottom: false,
          child: new ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              new Text(_introText),
              new Padding(padding: const EdgeInsets.only(top: 20.0)),
              new Row(
                children: <Widget>[
                  new Text('Long press the '),
                  new Tooltip(
                      message: 'call icon',
                      child: new Icon(Icons.call,
                          size: 18.0, color: theme.iconTheme.color)),
                  new Text(' icon.'),
                ],
              ),
              new Padding(padding: const EdgeInsets.only(top: 30.0)),
              new Center(
                child: new IconButton(
                    icon: const Icon(Icons.call, size: 48.0),
                    tooltip: 'Place a phone call',
                    color: theme.iconTheme.color,
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(const SnackBar(
                          content: const Text('That was an ordinary tap.')));
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
