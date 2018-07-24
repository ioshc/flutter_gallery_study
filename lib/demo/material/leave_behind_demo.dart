import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum LeaveBehindDemoAction { reset, horizontalSwipe, leftSwipe, rightSwipe }

class LeaveBehindItem implements Comparable<LeaveBehindItem> {
  LeaveBehindItem({this.index, this.name, this.subject, this.body});

  LeaveBehindItem.from(LeaveBehindItem item)
      : index = item.index,
        name = item.name,
        subject = item.subject,
        body = item.body;

  final int index;
  final String name;
  final String subject;
  final String body;

  @override
  int compareTo(LeaveBehindItem other) => index.compareTo(other.index);
}

class LeaveBehindDemo extends StatefulWidget {
  static const String routeName = 'material/leave-behind';

  @override
  State createState() {
    return new _LeaveBehindDemoState();
  }
}

class _LeaveBehindDemoState extends State<LeaveBehindDemo> {
  DismissDirection _dismissDirection = DismissDirection.horizontal;
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  List<LeaveBehindItem> leaveBehindItems;

  void initListItems() {
    leaveBehindItems = new List<LeaveBehindItem>.generate(16, (int index) {
      return new LeaveBehindItem(
          index: index,
          name: 'Item $index Sender',
          subject: 'Subject: $index',
          body: "[$index] first line of the message's body...");
    });
  }

  @override
  void initState() {
    super.initState();
    initListItems();
  }

  void _handleDemoAction(LeaveBehindDemoAction action) {
    setState(() {
      switch (action) {
        case LeaveBehindDemoAction.reset:
          initListItems();
          break;
        case LeaveBehindDemoAction.horizontalSwipe:
          _dismissDirection = DismissDirection.horizontal;
          break;
        case LeaveBehindDemoAction.leftSwipe:
          _dismissDirection = DismissDirection.endToStart;
          break;
        case LeaveBehindDemoAction.rightSwipe:
          _dismissDirection = DismissDirection.startToEnd;
          break;
      }
    });
  }

  void _handleUndo(LeaveBehindItem item) {
    final int insertionIndex = lowerBound(leaveBehindItems, item);
    setState(() {
      leaveBehindItems.insert(insertionIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Swipe to dismiss'),
        actions: <Widget>[
          new PopupMenuButton<LeaveBehindDemoAction>(
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<LeaveBehindDemoAction>>[
                  const PopupMenuItem<LeaveBehindDemoAction>(
                    child: const Text('Reset the list'),
                    value: LeaveBehindDemoAction.reset,
                  ),
                  const PopupMenuDivider(),
                  new CheckedPopupMenuItem(
                    child: const Text('Horizontal swipe'),
                    value: LeaveBehindDemoAction.horizontalSwipe,
                    checked: _dismissDirection == DismissDirection.horizontal,
                  ),
                  new CheckedPopupMenuItem(
                    child: const Text('Only swipe left'),
                    value: LeaveBehindDemoAction.leftSwipe,
                    checked: _dismissDirection == DismissDirection.endToStart,
                  ),
                  new CheckedPopupMenuItem(
                    child: const Text('Only swipe right'),
                    value: LeaveBehindDemoAction.rightSwipe,
                    checked: _dismissDirection == DismissDirection.startToEnd,
                  ),
                ],
            onSelected: _handleDemoAction,
          ),
        ],
      ),
      body: leaveBehindItems.isEmpty
          ? new Center(
              child: new RaisedButton(
              onPressed: () => _handleDemoAction(LeaveBehindDemoAction.reset),
              child: const Text('Reset the list'),
            ))
          : new ListView(
              children: leaveBehindItems.map((LeaveBehindItem item) {
                return new Dismissible(
                  key: new ObjectKey(item),
                  direction: _dismissDirection,
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      leaveBehindItems.remove(item);
                    });

                    final String action =
                    (direction == DismissDirection.endToStart)
                        ? 'archived'
                        : 'deleted';
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content: new Text('You $action item ${item.index}'),
                      action: new SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            _handleUndo(item);
                          }),
                    ));
                  },
                  background: new Container(
                    alignment: Alignment.center,
                    color: theme.primaryColor,
                    child: new ListTile(
                        leading: const Icon(Icons.delete,
                            color: Colors.white, size: 36.0)),
                  ),
                  secondaryBackground: new Container(
                    alignment: Alignment.center,
                    color: theme.primaryColor,
                    child: new ListTile(
                      trailing: const Icon(Icons.archive,
                          color: Colors.white, size: 36.0),
                    ),
                  ),
                  child: new Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                          bottom: new BorderSide(color: theme.dividerColor)),
                    ),
                    child: new ListTile(
                      title: new Text(item.name),
                      subtitle: new Text('${item.subject}\n${item.body}'),
                      isThreeLine: true,
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
