import 'package:flutter/material.dart';

enum _MaterialListType {
  oneLine,
  oneLineWithAvatar,
  twoLine,
  threeLine,
}

class ListDemo extends StatefulWidget {
  static const String routeName = '/material/list';

  @override
  State createState() {
    return new _ListDemoState();
  }
}

class _ListDemoState extends State<ListDemo> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  PersistentBottomSheetController<Null> _bottomSheet;
  _MaterialListType _itemType = _MaterialListType.oneLine;
  bool _dense = false;
  bool _showAvatars = true;
  bool _showIcons = false;
  bool _showDividers = false;
  bool _reverseSort = false;

  List<String> _items = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
  ];

  void changeItemType(_MaterialListType type) {
    setState(() {
      _itemType = type;
    });
    _bottomSheet?.setState(() { });
  }

  void _showConfigurationSheet() {
    final PersistentBottomSheetController<Null> bottomSheet = _scaffoldKey
        .currentState.showBottomSheet((BuildContext bottomSheetContext) {
      return new Container(
        child: new DecoratedBox(
          decoration: new BoxDecoration(
            border: new Border(
              top: new BorderSide(color: Colors.black26),
            ),
          ),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('One-line'),
                  new Radio(
                    value: _MaterialListType.oneLine,
                    groupValue: _itemType,
                    onChanged: changeItemType,
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Two-line'),
                  new Radio(
                    value: _MaterialListType.twoLine,
                    groupValue: _itemType,
                    onChanged: changeItemType,
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Three-line'),
                  new Radio(
                    value: _MaterialListType.threeLine,
                    groupValue: _itemType,
                    onChanged: changeItemType,
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Show avatar'),
                  new Checkbox(value: _showAvatars, onChanged: (value) {
                    setState(() {
                      _showAvatars = value;
                      _bottomSheet.setState((){ });
                    });
                  },),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Show icon'),
                  new Checkbox(value: _showIcons, onChanged: (value) {
                    setState(() {
                      _showIcons = value;
                      _bottomSheet.setState((){ });
                    });
                  },),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Show dividers'),
                  new Checkbox(value: _showDividers, onChanged: (value) {
                    setState(() {
                      _showDividers = value;
                      _bottomSheet.setState((){ });
                    });
                  },),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Dense layout'),
                  new Checkbox(value: _dense, onChanged: (value) {
                    setState(() {
                      _dense = value;
                      _bottomSheet.setState((){ });
                    });
                  },),
                ],
              ),
            ],
          ),
        ),
      );
    });

    setState(() {
      _bottomSheet = bottomSheet;
    });

    _bottomSheet.closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheet = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final String layoutText = _dense ? ' \u2013 Dense' : '';
    String itemTypeText;
    switch (_itemType) {
      case _MaterialListType.oneLine:
      case _MaterialListType.oneLineWithAvatar:
        itemTypeText = 'Single-line';
        break;
      case _MaterialListType.twoLine:
        itemTypeText = 'Two-line';
        break;
      case _MaterialListType.threeLine:
        itemTypeText = 'Three-line';
        break;
    }

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Scrolling list\n$itemTypeText$layoutText'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            tooltip: 'Sort',
            onPressed: () {
              setState(() {
                _reverseSort = !_reverseSort;
                _items.sort((String a, String b) =>
                    _reverseSort ? b.compareTo(a) : a.compareTo(b));
              });
            },
          ),
          new IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'Show menu',
            onPressed: _bottomSheet == null ? _showConfigurationSheet : null,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          String item = _items[index];

          bool isThreeLine = false;
          String text;
          switch (_itemType) {
            case _MaterialListType.oneLine:
            case _MaterialListType.oneLineWithAvatar:
              break;
            case _MaterialListType.twoLine:
              text = 'Additional item information';
              break;
            case _MaterialListType.threeLine:
              text =
                  'Even more additional list item information appears online three';
              isThreeLine = true;
              break;
          }

          return new DecoratedBox(
            decoration: new BoxDecoration(
                border: _showDividers
                    ? Border(bottom: new BorderSide(color: Colors.red))
                    : null),
            child: new ListTile(
              dense: _dense,
              leading: _showAvatars
                  ? new CircleAvatar(
                      child: new Text(item),
                    )
                  : null,
              title: new Text('This item represents $item'),
              subtitle: text != null ? new Text(text) : null,
              isThreeLine: isThreeLine,
              trailing: _showIcons
                  ? new IconButton(
                      icon: const Icon(Icons.info),
                      onPressed: () {},
                    )
                  : null,
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
