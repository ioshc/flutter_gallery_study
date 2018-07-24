import 'package:flutter/material.dart';
import 'dart:math';

class IconsDemo extends StatefulWidget {
  static const String routeName = 'material/icons';

  @override
  State createState() {
    return new _IconsDemoState();
  }
}

class _IconsDemoState extends State<IconsDemo> {
  static final List<MaterialColor> _colors = <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];

  Color _iconColor = _colors.first;

  void _changeIconColor() {
    setState(() {
      int index = Random().nextInt(17);
      _iconColor = _colors.elementAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Icons'),
      ),
      body: new ListView(
        itemExtent: 300.0,
        children: <Widget>[
          new _IconsCard(
            iconData: Icons.face,
            color: _iconColor,
            changeColor: _changeIconColor,
          ),
          new _IconsCard(
            iconData: Icons.battery_charging_full,
            color: _iconColor,
            changeColor: _changeIconColor,
          ),
        ],
      ),
    );
  }
}

class _IconsCard extends StatelessWidget {
  const _IconsCard({this.iconData, this.color, this.changeColor});

  final IconData iconData;

  final Color color;
  final VoidCallback changeColor;

  Widget _buildIconButton(double iconSize, IconData icon, bool enabled) {
    return new IconButton(
      color: color,
      icon: new Icon(icon),
      iconSize: iconSize,
      tooltip: "${enabled ? 'Enabled' : 'Disabled'} icon button",
      onPressed: enabled ? changeColor : null,
    );
  }

  Widget _centeredText(String label) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }

  TableRow _buildIconRow(double size) {
    return new TableRow(
      children: <Widget>[
        _centeredText('$size'),
        _buildIconButton(size, iconData, true),
        _buildIconButton(size, iconData, false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Card(
        child: new Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            new TableRow(children: <Widget>[
              _centeredText('Size'),
              _centeredText('Enabled'),
              _centeredText('Disabled'),
            ]),
            _buildIconRow(18.0),
            _buildIconRow(24.0),
            _buildIconRow(36.0),
            _buildIconRow(48.0),
          ],
        ),
      ),
    );
  }
}
