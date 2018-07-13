import 'package:flutter/material.dart';
import '../../gallery/demo.dart';

const String _raisedText =
    'Raised buttons add dimension to mostly flat layouts. They emphasize '
    'functions on busy or wide spaces.';

const String _raisedCode = 'buttons_raised';

const String _flatText = 'A flat button displays an ink splash on press '
    'but does not lift. Use flat buttons on toolbars, in dialogs and '
    'inline with padding';

const String _flatCode = 'buttons_flat';

const String _outlineText =
    'Outline buttons become opaque and elevate when pressed. They are often '
    'paired with raised buttons to indicate an alternative, secondary action.';

const String _outlineCode = 'buttons_outline';

const String _dropdownText =
    'A dropdown button displays a menu that\'s used to select a value from a '
    'small set of values. The button displays the current value and a down '
    'arrow.';

const String _dropdownCode = 'buttons_dropdown';

const String _iconText =
    'IconButtons are appropriate for toggle buttons that allow a single choice '
    'to be selected or deselected, such as adding or removing an item\'s star.';

const String _iconCode = 'buttons_icon';

const String _actionText =
    'Floating action buttons are used for a promoted action. They are '
    'distinguished by a circled icon floating above the UI and can have motion '
    'behaviors that include morphing, launching, and a transferring anchor '
    'point.';

const String _actionCode = 'buttons_action';

class ButtonsDemo extends StatefulWidget {
  static const String routeName = '/buttons';

  _ButtonsDemoState createState() => _ButtonsDemoState();
}

class _ButtonsDemoState extends State<ButtonsDemo> {
  ShapeBorder _buttonShape;

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonTheme =
        ButtonTheme.of(context).copyWith(shape: _buttonShape);

    final List<ComponentDemoTabData> demos = <ComponentDemoTabData>[
      new ComponentDemoTabData(
        tabName: 'RAISED',
        description: _raisedText,
        demoWidget: new ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildRaisedButton(),
        ),
        exampleCodeTag: _raisedCode,
      ),
      new ComponentDemoTabData(
        tabName: 'FLAT',
        description: _flatText,
        demoWidget: new ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildFlatButton(),
        ),
        exampleCodeTag: _flatCode,
      ),
      new ComponentDemoTabData(
        tabName: 'OUTLINE',
        description: _outlineText,
        demoWidget: new ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildOutlineButton(),
        ),
        exampleCodeTag: _outlineCode,
      ),
      new ComponentDemoTabData(
        tabName: 'DROPDOWN',
        description: _dropdownText,
        demoWidget: new ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildDropdownButton(),
        ),
        exampleCodeTag: _dropdownCode,
      ),
      new ComponentDemoTabData(
        tabName: 'ICON',
        description: _iconText,
        demoWidget: new ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildIconButton(),
        ),
        exampleCodeTag: _iconCode,
      ),
      new ComponentDemoTabData(
        tabName: 'ACTION',
        description: _actionText,
        demoWidget: new ButtonTheme.fromButtonThemeData(
          data: buttonTheme,
          child: buildActionButton(),
        ),
        exampleCodeTag: _actionCode,
      )
    ];

    return new TabbedComponentDemoScaffold(
      title: 'Buttons',
      actions: <Widget>[
        new IconButton(
          icon: const Icon(Icons.sentiment_very_satisfied),
          onPressed: () {
            setState(() {
              _buttonShape =
                  (_buttonShape == null) ? const StadiumBorder() : null;
            });
          },
        ),
      ],
      demos: demos,
    );
  }

  Widget buildRaisedButton() {
    return new Align(
      alignment: const Alignment(0.0, -0.2),
      child: new Column(
        children: <Widget>[
          new ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new RaisedButton(
                child: const Text('RAISED BUTTON'),
                onPressed: () {
                  // Perform some action
                },
              ),
              const RaisedButton(
                child: const Text('DISABLED'),
                onPressed: null,
              ),
            ],
          ),
          new ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('RAISED BUTTON'),
                onPressed: () {
                  // Perform some action
                },
              ),
              new RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('DISABLED'),
                onPressed: null,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildFlatButton() {
    return new Column(
      children: <Widget>[
        new ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FlatButton(
              child: const Text('FLAT BUTTON'),
              onPressed: () {
                // Perform some action
              },
            ),
            const FlatButton(
              child: const Text('DISABLED'),
              onPressed: null,
            ),
          ],
        ),
        new ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new FlatButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('FLAT BUTTON'),
              onPressed: () {
                // Perform some action
              },
            ),
            new FlatButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('DISABLED'),
              onPressed: null,
            ),
          ],
        )
      ],
    );
  }

  Widget buildOutlineButton() {
    return new Column(
      children: <Widget>[
        new ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new OutlineButton(
              child: const Text('OUTLINE BUTTON'),
              onPressed: () {
                // Perform some action
              },
            ),
            const OutlineButton(
              child: const Text('DISABLED'),
              onPressed: null,
            ),
          ],
        ),
        new ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new OutlineButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('OUTLINE BUTTON'),
              onPressed: () {
                // Perform some action
              },
            ),
            new OutlineButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('DISABLED'),
              onPressed: null,
            ),
          ],
        )
      ],
    );
  }

  String dropdown1Value = 'Three';
  String dropdown2Value;
  String dropdown3Value = 'Four';

  Widget buildDropdownButton() {
    return new Column(
      children: <Widget>[
        new Padding(padding: const EdgeInsets.all(24.0)),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Text('Simple dropdown'),
            new DropdownButton<String>(
              value: dropdown1Value,
              onChanged: (String value) {
                setState(() {
                  dropdown1Value = value;
                });
              },
              items:
                  <String>['One', 'Two', 'Three', 'Four'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        new Padding(padding: const EdgeInsets.all(24.0)),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Text('Dropdown with a hint'),
            new DropdownButton<String>(
              hint: const Text('Choose'),
              value: dropdown2Value,
              onChanged: (String value) {
                setState(() {
                  dropdown2Value = value;
                });
              },
              items:
                  <String>['One', 'Two', 'Three', 'Four'].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ],
        ),
        new Padding(padding: const EdgeInsets.all(24.0)),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Text('Scrollable dropdown'),
            new DropdownButton<String>(
              value: dropdown3Value,
              onChanged: (String value) {
                setState(() {
                  dropdown3Value = value;
                });
              },
              items: <String>[
                'One',
                'Two',
                'Free',
                'Four',
                'Can',
                'I',
                'Have',
                'A',
                'Little',
                'Bit',
                'More',
                'Five',
                'Six',
                'Seven',
                'Eight',
                'Nine',
                'Ten'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildIconButton() {
    return new ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: () {
            // Perform some action
          },
        ),
        const IconButton(
          icon: const Icon(Icons.thumb_up),
          onPressed: null,
        ),
      ],
    );
  }

  Widget buildActionButton() {
    return new FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // Perform some action
      },
    );
  }
}
