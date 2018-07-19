import 'package:flutter/material.dart';

class SearchDemo extends StatefulWidget {
  static const String routeName = "material/search";

  _SearchDemoState createState() => new _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  final _SearchDemoSearchDelegate _delegate = new _SearchDemoSearchDelegate();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _lastSelectedInt;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Numbers'),
        leading: new IconButton(
          tooltip: 'Navigation menu',
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            color: Colors.white,
            progress: _delegate.transitionAnimation,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[
          new IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final int selected = await showSearch(
                context: context,
                delegate: _delegate,
              );
              if (selected != null && selected != _lastSelectedInt) {
                setState(() {
                  _lastSelectedInt = selected;
                });
              }
            },
          ),
          new IconButton(
            tooltip: 'More (not implemented)',
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Press the '),
                const Tooltip(
                  message: 'search',
                  child: const Icon(
                    Icons.search,
                    size: 18.0,
                  ),
                ),
                const Text(' in the AppBar'),
              ],
            ),
            const Text('and search for an integer between 0 and 100,000.'),
            const Padding(padding: const EdgeInsets.only(top: 60.0)),
            new Text("Last selected integer: ${_lastSelectedInt ?? 'NONE'}"),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton.extended(
        tooltip: 'Back', // Tests depend on this label to exit the demo.
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: const Text('Close demo'),
        icon: const Icon(Icons.close),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: const Text('Peter Widget'),
              accountEmail: const Text('peter.widget@examle.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: const AssetImage(
                  'shrine/vendors/zach.jpg',
                  package: 'flutter_gallery_assets',
                ),
              ),
              margin: EdgeInsets.zero,
            ),
            const ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Placeholder'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchDemoSearchDelegate extends SearchDelegate<int> {
  final List<int> _data =
      new List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<int> _history = <int>[42607, 85604, 66374, 44, 174];

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final int searched = int.tryParse(query);
    if (searched == null || !_data.contains(searched)) {
      return new Center(
        child: new Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return new ListView(
      children: <Widget>[
        new _ResultCard(
          title: 'This integer',
          integer: searched,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Next integer',
          integer: searched + 1,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Previous integer',
          integer: searched - 1,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<int> suggestions = query.isEmpty
        ? _history
        : _data.where((int i) => '$i'.startsWith(query)).toList();

    return new _SuggestionList(
      suggestions: suggestions.map((int i) => '$i').toList(),
      query: query,
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : new IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemExtent: 50.0,
      itemBuilder: (BuildContext context, int index) {
        final String suggestion = suggestions[index];

        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : Icon(null),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                    text: suggestion.substring(query.length),
                    style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.integer, this.title, this.searchDelegate});

  final int integer;
  final String title;
  final SearchDelegate<int> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Text(title),
            new Text(
              '$integer',
              style: theme.textTheme.headline.copyWith(fontSize: 72.0),
            ),
          ],
        ),
      ),
    );
  }
}
