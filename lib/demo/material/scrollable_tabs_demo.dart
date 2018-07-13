import 'package:flutter/material.dart';

enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

class _Page {
  const _Page({this.icon, this.text});
  final IconData icon;
  final String text;
}

const List<_Page> _allPages = const <_Page>[
  const _Page(icon: Icons.grade, text: 'TRIUMPH'),
  const _Page(icon: Icons.playlist_add, text: 'NOTE'),
  const _Page(icon: Icons.check_circle, text: 'SUCCESS'),
  const _Page(icon: Icons.question_answer, text: 'OVERSTATE'),
  const _Page(icon: Icons.sentiment_very_satisfied, text: 'SATISFACTION'),
  const _Page(icon: Icons.camera, text: 'APERTURE'),
  const _Page(icon: Icons.assignment_late, text: 'WE MUST'),
  const _Page(icon: Icons.assignment_turned_in, text: 'WE CAN'),
  const _Page(icon: Icons.group, text: 'ALL'),
  const _Page(icon: Icons.block, text: 'EXCEPT'),
  const _Page(icon: Icons.sentiment_very_dissatisfied, text: 'CRYING'),
  const _Page(icon: Icons.error, text: 'MISTAKE'),
  const _Page(icon: Icons.loop, text: 'TRYING'),
  const _Page(icon: Icons.cake, text: 'CAKE'),
];

class ScrollableTabsDemo extends StatefulWidget {
  static const String routeName = 'material/scrollable-tabs';

  _ScrollableTabsDemoState createState() => new _ScrollableTabsDemoState();
}

class _ScrollableTabsDemoState extends State<ScrollableTabsDemo> {

  TabsDemoStyle _demoStyle = TabsDemoStyle.iconsAndText;
  bool _customIndicator = false;

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

  Decoration getIndicator() {
    if (!_customIndicator)
      return const UnderlineTabIndicator();

    switch(_demoStyle) {
      case TabsDemoStyle.iconsAndText:
        return new ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
            side: const BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
            side: const BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );

      case TabsDemoStyle.iconsOnly:
        return new ShapeDecoration(
          shape: const CircleBorder(
            side: const BorderSide(
              color: Colors.white24,
              width: 4.0,
            ),
          ) + const CircleBorder(
            side: const BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );

      case TabsDemoStyle.textOnly:
        return new ShapeDecoration(
          shape: const StadiumBorder(
            side: const BorderSide(
              color: Colors.white24,
              width: 2.0,
            ),
          ) + const StadiumBorder(
            side: const BorderSide(
              color: Colors.transparent,
              width: 4.0,
            ),
          ),
        );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {

    final Color iconColor = Theme.of(context).accentColor;

    return new DefaultTabController(
      length: _allPages.length,
      child: new Scaffold(
        appBar: new AppBar(
          title: const Text('Scrollable tabs'),
          bottom: new TabBar(
            isScrollable: true,
            tabs: _allPages.map((_Page page) {
              switch (_demoStyle) {
                case TabsDemoStyle.iconsAndText:
                  return new Tab(text: page.text, icon: new Icon(page.icon));
                case TabsDemoStyle.iconsOnly:
                  return new Tab(icon: new Icon(page.icon));
                case TabsDemoStyle.textOnly:
                  return new Tab(text: page.text);
              }
            }).toList(),
            indicator: getIndicator(),
          ),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.sentiment_very_satisfied),
              onPressed: () {
                setState(() {
                  _customIndicator = !_customIndicator;
                });
              },
            ),
            new PopupMenuButton<TabsDemoStyle>(
              onSelected: changeDemoStyle,
                itemBuilder: (BuildContext context) => <PopupMenuItem<TabsDemoStyle>>[
                  const PopupMenuItem<TabsDemoStyle>(
                      value: TabsDemoStyle.iconsAndText,
                      child: const Text('Icons and text')
                  ),
                  const PopupMenuItem<TabsDemoStyle>(
                      value: TabsDemoStyle.iconsOnly,
                      child: const Text('Icons only')
                  ),
                  const PopupMenuItem<TabsDemoStyle>(
                      value: TabsDemoStyle.textOnly,
                      child: const Text('Text only')
                  ),
                ],
            ),
          ],
        ),
        body: new TabBarView(
          children: _allPages.map(
            (_Page page) {
              return new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Card(
                  child: new Center(
                    child: new Icon(
                      page.icon,
                      size: 128.0,
                      color: iconColor,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
