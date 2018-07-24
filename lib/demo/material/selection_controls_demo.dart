import 'package:flutter/material.dart';
import '../../gallery/demo.dart';

const String _checkboxText =
    'Checkboxes allow the user to select multiple options from a set. '
    'A normal checkbox\'s value is true or false and a tristate checkbox\'s '
    'value can also be null.';

const String _checkboxCode = 'selectioncontrols_checkbox';

const String _radioText =
    'Radio buttons allow the user to select one option from a set. Use radio '
    'buttons for exclusive selection if you think that the user needs to see '
    'all available options side-by-side.';

const String _radioCode = 'selectioncontrols_radio';

const String _switchText =
    'On/off switches toggle the state of a single settings option. The option '
    'that the switch controls, as well as the state it’s in, should be made '
    'clear from the corresponding inline label.';

const String _switchCode = 'selectioncontrols_switch';

class SelectionControlsDemo extends StatefulWidget {
  static const String routeName = 'material/selection-controls';

  @override
  _SelectionControlsDemo createState() => new _SelectionControlsDemo();
}

class _SelectionControlsDemo extends State<SelectionControlsDemo> {
  @override
  Widget build(BuildContext context) {
    List<ComponentDemoTabData> demos = <ComponentDemoTabData>[
      new ComponentDemoTabData(
        tabName: 'CHECKBOX',
        description: _checkboxText,
        exampleCodeTag: _checkboxCode,
        demoWidget: buildCheckbox(),
      ),
      new ComponentDemoTabData(
        tabName: 'RADIO',
        description: _radioText,
        exampleCodeTag: _radioCode,
        demoWidget: buildRadio(),
      ),
      new ComponentDemoTabData(
        tabName: 'SWITCH',
        description: _switchText,
        exampleCodeTag: _switchCode,
        demoWidget: buildSwitch(),
      ),
    ];

    return new TabbedComponentDemoScaffold(
      title: 'Slection controls',
      demos: demos,
    );
  }

  bool _checkboxValueA = true;
  bool _checkboxValueB = false;
  bool _checkboxValueC;
  int _radioValue = 0;
  bool _switchValue = false;

  void handleRadioValueChanged(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  Widget buildCheckbox() {
    return new Column(
      children: <Widget>[
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Checkbox(
              value: _checkboxValueA,
              onChanged: (bool value) {
                setState(() {
                  _checkboxValueA = value;
                });
              },
            ),
            new Checkbox(
              value: _checkboxValueB,
              onChanged: (bool value) {
                setState(() {
                  _checkboxValueB = value;
                });
              },
            ),
            new Checkbox(
              value: _checkboxValueC,
              tristate: true,
              onChanged: (bool value) {
                setState(() {
                  _checkboxValueC = value;
                });
              },
            ),
          ],
        ),
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Checkbox(value: true, onChanged: null),
            new Checkbox(value: false, onChanged: null),
            new Checkbox(value: null, tristate: true, onChanged: null),
          ],
        )
      ],
    );
  }

  Widget buildRadio() {
    return new Column(
      children: <Widget>[
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Radio(
              value: 0,
              groupValue: _radioValue,
              onChanged: handleRadioValueChanged,
            ),
            new Radio(
              value: 1,
              groupValue: _radioValue,
              onChanged: handleRadioValueChanged,
            ),
            new Radio(
              value: 2,
              groupValue: _radioValue,
              onChanged: handleRadioValueChanged,
            ),
          ],
        ),
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Radio(value: true, groupValue: _radioValue, onChanged: null,),
            new Radio(value: false, groupValue: _radioValue, onChanged: null,),
            new Radio(value: null, groupValue: _radioValue, onChanged: null,),
          ],
        )
      ],
    );
  }

  Widget buildSwitch() {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Switch(
          value: _switchValue,
          onChanged: (bool value) {
            setState(() {
              _switchValue = value;
            });
          },
        ),
        new Switch(value: true, onChanged: null),
        new Switch(value: false, onChanged: null),
      ],
    );
  }
}
