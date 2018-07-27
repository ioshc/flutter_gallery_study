import 'package:flutter/material.dart';


class _NavigationItem {
  const _NavigationItem({this.icon, this.label, this.color});

  final IconData icon;
  final String label;
  final Color color;
}

final List<_NavigationItem> _items = <_NavigationItem>[
  new _NavigationItem(icon: Icons.alarm, label: 'Alarm', color: Colors.deepPurple),
  new _NavigationItem(icon: Icons.inbox, label: 'Inbox', color: Colors.amber),
  new _NavigationItem(icon: Icons.cloud_queue, label: 'Cloud', color: Colors.blue),
  new _NavigationItem(icon: Icons.favorite_border, label: 'Favorite', color: Colors.cyan),
  new _NavigationItem(icon: Icons.event, label: 'Event', color: Colors.greenAccent),
  new _NavigationItem(icon: Icons.dashboard, label: 'Dashboard', color: Colors.pink),
  new _NavigationItem(icon: Icons.email, label: 'Email', color: Colors.deepOrange),
];

class BottomNavigationDemo extends StatefulWidget {
  static const String routeName = 'material/bottom-navigation';

  @override
  State createState() {
    return new _BottomNavigationDemoState();
  }
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo> {
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    _NavigationItem item = _items[_currentIndex];

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Bottom navigation'),
        actions: <Widget>[
          new PopupMenuButton(
            itemBuilder: (BuildContext ctx) {
              return <PopupMenuItem>[
                new PopupMenuItem(
                  child: const Text('Fixed'),
                  value: BottomNavigationBarType.fixed,
                ),
                new PopupMenuItem(
                    child: const Text('Shifting'),
                    value: BottomNavigationBarType.shifting),
              ];
            },
            onSelected: (value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ],
      ),
      body: new Center(
        child: new Icon(item.icon, color: item.color, size: 120.0,),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        type: _type,
        currentIndex: _currentIndex,
        items: _items.map((_NavigationItem item) {
          return new BottomNavigationBarItem(
            backgroundColor: item.color,
            icon: new Icon(item.icon),
            title: new Text(item.label),
          );
        }).toList(),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
