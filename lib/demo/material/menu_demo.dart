import 'package:flutter/material.dart';

class MenuButtonDemo extends StatefulWidget {
  static const String routeName = "material/menu";

  _MenuButtonDemoState createState() => new _MenuButtonDemoState();
}

class _MenuButtonDemoState extends State<MenuButtonDemo> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final String _simpleValue1 = 'Menu item value one';
  final String _simpleValue2 = 'Menu item value two';
  final String _simpleValue3 = 'Menu item value three';
  String _simpleValue;

  final String _checkedValue1 = 'One';
  final String _checkedValue2 = 'Two';
  final String _checkedValue3 = 'Free';
  final String _checkedValue4 = 'Four';
  List<String> _checkedValues;

  @override
  void initState() {
    super.initState();
    _simpleValue = _simpleValue2;
    _checkedValues = <String>[_checkedValue3];
  }

  void _showInSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }

  void _showMenuSelection(String value) {

    if (<String>[_simpleValue1, _simpleValue2, _simpleValue3].contains(value))
    setState(() {
      _simpleValue = value;
    });

    _showInSnackBar('You selected: $value');
  }

  void _showCheckedMenuSelections(String value) {
    if (_checkedValues.contains(value))
      _checkedValues.remove(value);
    else
      _checkedValues.add(value);

    _showInSnackBar('Checked $_checkedValues');
  }

  bool _isChecked(String value) => _checkedValues.contains(value);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Menus'),
        actions: <Widget>[
          new PopupMenuButton<String>(
            onSelected: _showMenuSelection,
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  const PopupMenuItem<String>(
                    value: 'Toolbar menu',
                    child: const Text('Toolbar menu'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Right here',
                    child: const Text('Right here'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Hooray!',
                    child: const Text('Hooray!'),
                  ),
                ],
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: const Text('An item with an context menu button'),
            trailing: new PopupMenuButton<String>(
              onSelected: _showMenuSelection,
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  new PopupMenuItem<String>(
                    value: _simpleValue1,
                    child: const Text('Context menu item one'),
                  ),
                  new PopupMenuItem<String>(
                    child: const Text('A disabled menu item'),
                    enabled: false,
                  ),
                  new PopupMenuItem<String>(
                    value: _simpleValue3,
                    child: const Text('Context menu item three'),
                  ),
                ],
            ),
          ),
          new ListTile(
            title: const Text('An item with a selectioned menu'),
            trailing: new PopupMenuButton<String>(
              onSelected: _showMenuSelection,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                new PopupMenuItem<String>(
                  value: 'Preview',
                  child: const ListTile(
                      leading: const Icon(Icons.visibility),
                      title: const Text('Preview')
                  ),
                ),
                new PopupMenuItem<String>(
                  value: 'Share',
                  child: const ListTile(
                      leading: const Icon(Icons.person_add),
                      title: const Text('Share')
                  ),
                ),
                new PopupMenuItem<String>(
                  value: 'Get link',
                  child: const ListTile(
                      leading: const Icon(Icons.link),
                      title: const Text('Get link')
                  ),
                ),
                new PopupMenuDivider(),
                new PopupMenuItem<String>(
                  value: 'Remove',
                  child: const ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Remove')
                  ),
                ),
              ],
            ),
          ),
          new PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              initialValue: _simpleValue,
              onSelected: _showMenuSelection,
              child: new ListTile(
                  title: const Text('An item with a simple menu'),
                  subtitle: new Text(_simpleValue),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                new PopupMenuItem<String>(
                    value: _simpleValue1,
                    child: new Text(_simpleValue1)
                ),
                new PopupMenuItem<String>(
                    value: _simpleValue2,
                    child: new Text(_simpleValue2)
                ),
                new PopupMenuItem<String>(
                    value: _simpleValue3,
                    child: new Text(_simpleValue3)
                )
              ]
          ),
          new ListTile(
            title: const Text('An item with a checklist menu'),
            trailing: new PopupMenuButton<String>(
              onSelected: _showCheckedMenuSelections,
              itemBuilder: (BuildContext context) => <CheckedPopupMenuItem<String>>[
                new CheckedPopupMenuItem<String>(
                  value: _checkedValue1,
                  child: new Text(_checkedValue1),
                  checked: _isChecked(_checkedValue1),
                ),
                new CheckedPopupMenuItem<String>(
                  value: _checkedValue2,
                  child: new Text(_checkedValue2),
                  checked: _isChecked(_checkedValue2),
                ),
                new CheckedPopupMenuItem<String>(
                  value: _checkedValue3,
                  child: new Text(_checkedValue3),
                  checked: _isChecked(_checkedValue3),
                  enabled: false,
                ),
                new CheckedPopupMenuItem<String>(
                  value: _checkedValue4,
                  child: new Text(_checkedValue4),
                  checked: _isChecked(_checkedValue4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
