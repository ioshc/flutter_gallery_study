import 'package:flutter/material.dart';

const List<String> _defaultMaterials = const <String>[
  'poker',
  'tortilla',
  'fish and',
  'micro',
  'wood',
];

const List<String> _defaultActions = const <String>[
  'flake',
  'cut',
  'fragment',
  'splinter',
  'nick',
  'fry',
  'solder',
  'cash in',
  'eat',
];

const Map<String, String> _results = const <String, String>{
  'flake': 'flaking',
  'cut': 'cutting',
  'fragment': 'fragmenting',
  'splinter': 'splintering',
  'nick': 'nicking',
  'fry': 'frying',
  'solder': 'soldering',
  'cash in': 'cashing in',
  'eat': 'eating',
};

const List<String> _defaultTools = const <String>[
  'hammer',
  'chisel',
  'fryer',
  'fabricator',
  'customer',
];

const Map<String, String> _avatars = const <String, String>{
  'hammer': 'shrine/vendors/ali-connors.png',
  'chisel': 'shrine/vendors/sandra-adams.jpg',
  'fryer': 'shrine/vendors/zach.jpg',
  'fabricator': 'shrine/vendors/peter-carlsson.png',
  'customer': 'shrine/vendors/16c477b.jpg',
};

final Map<String, Set<String>> _toolActions = <String, Set<String>>{
  'hammer': new Set<String>()
    ..addAll(<String>['flake', 'fragment', 'splinter']),
  'chisel': new Set<String>()..addAll(<String>['flake', 'nick', 'splinter']),
  'fryer': new Set<String>()..addAll(<String>['fry']),
  'fabricator': new Set<String>()..addAll(<String>['solder']),
  'customer': new Set<String>()..addAll(<String>['cash in', 'eat']),
};

final Map<String, Set<String>> _materialActions = <String, Set<String>>{
  'poker': new Set<String>()..addAll(<String>['cash in']),
  'tortilla': new Set<String>()..addAll(<String>['fry', 'eat']),
  'fish and': new Set<String>()..addAll(<String>['fry', 'eat']),
  'micro': new Set<String>()..addAll(<String>['solder', 'fragment']),
  'wood': new Set<String>()
    ..addAll(<String>['flake', 'cut', 'splinter', 'nick']),
};

class _ChipTile extends StatelessWidget {
  const _ChipTile({this.label, this.children});

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
        child: new Text(
          label,
          textAlign: TextAlign.start,
        ),
      ),
      subtitle: children.isEmpty
          ? new Center(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text('None'),
              ),
            )
          : new Wrap(
              children: children
                  .map((Widget chip) => new Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: chip,
                      ))
                  .toList(),
            ),
    );
  }
}

class ChipDemo extends StatefulWidget {
  static const routeName = 'material/chip';

  @override
  State createState() {
    return new _ChipDemoState();
  }
}

class _ChipDemoState extends State<ChipDemo> {

  _ChipDemoState() {
    _reset();
  }

  final Set<String> _materials = new Set<String>();
  String _selectedMaterial = '';
  String _selectedAction = '';
  final Set<String> _tools = new Set<String>();
  final Set<String> _selectedTools = new Set<String>();
  final Set<String> _actions = new Set<String>();
  bool _showShapeBorder = false;

  // Initialize members with the default data.
  void _reset() {
    _materials.clear();
    _materials.addAll(_defaultMaterials);
    _actions.clear();
    _actions.addAll(_defaultActions);
    _tools.clear();
    _tools.addAll(_defaultTools);
    _selectedMaterial = '';
    _selectedAction = '';
    _selectedTools.clear();
  }

  String _capitalize(String name) {
    assert(name != null && name.isNotEmpty);
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  AssetImage _nameToAvatar(String name) {
    assert(_avatars.containsKey(name));
    return new AssetImage(
      _avatars[name],
      package: 'flutter_gallery_assets',
    );
  }
  
  // This converts a String to a unique color, based on the hash value of the
  // String object.  It takes the bottom 16 bits of the hash, and uses that to
  // pick a hue for an HSV color, and then creates the color (with a preset
  // saturation and value).  This means that any unique strings will also have
  // unique colors, but they'll all be readable, since they have the same
  // saturation and value.
  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = 360.0 * hash / (1 << 15);
    return new HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  void _removeMaterial(String name) {
    _materials.remove(name);
  }

  void _removeTool(String name) {
    _tools.remove(name);
  }

  String _createResult() {
    if (_selectedAction.isEmpty) {
      return '';
    }
    return _capitalize(_results[_selectedAction]) + '!';
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final List<Chip> chips = _materials.map((String name) {
      return new Chip(
        label: new Text(name),
        backgroundColor: _nameToColor(name),
        onDeleted: (){
          setState(() {
            _removeMaterial(name);
          });
        },
      );
    }).toList();

    final List<Chip> inputChips = _tools.map((String name) {
      return new Chip(
        label: new Text(name),
        backgroundColor: _nameToColor(name),
        avatar: new CircleAvatar(
          backgroundImage: _nameToAvatar(name),
        ),
        onDeleted: (){
          setState(() {
            _removeTool(name);
          });
        },
      );
    }).toList();

    final List<ChoiceChip> choseChips = _materials.map((String name) {
      return new ChoiceChip(
        label: new Text(name),
        backgroundColor: _nameToColor(name),
        selected: _selectedMaterial == name,
        onSelected: (bool value) {
          setState(() {
            _selectedMaterial = value ? name : '';
          });
        },
      );
    }).toList();

    final List<FilterChip> filterChips = _defaultTools.map((String name) {
      return new FilterChip(
        label: new Text(name),
        backgroundColor: _nameToColor(name),
        selected: _selectedTools.contains(name),
        onSelected: (bool value) {
          setState(() {

            if (value) {
              _selectedTools.add(name);
            } else {
              _selectedTools.remove(name);
            }
          });
        },
      );
    }).toList();

    Set<String> allowedActions = new Set<String>();
    if (_selectedMaterial != null && _selectedMaterial.isNotEmpty) {
      for (String tool in _selectedTools) {
        allowedActions.addAll(_toolActions[tool]);
      }
      allowedActions = allowedActions.intersection(_materialActions[_selectedMaterial]);
    }

    final List<Widget> actionChips = allowedActions.map<Widget>((String name) {
      return new ActionChip(
        label: new Text(_capitalize(name)),
        onPressed: () {
          setState(() {
            _selectedAction = name;
          });
        },
      );
    }).toList();

    final List<Widget> _tiles = <Widget>[
      new _ChipTile(
        label: 'Available Materials (Chip)',
        children: chips,
      ),
      new _ChipTile(
        label: 'Available Tools (InputChip)',
        children: inputChips,
      ),
      new _ChipTile(
        label: 'Choose Material (ChoiceChip)',
        children: choseChips,
      ),
      new _ChipTile(
        label: 'Choose Tools (FilterChip)',
        children: filterChips,
      ),
      new _ChipTile(
        label: 'Perform Allowed Action (ActionChip)',
        children: actionChips,
      ),
      const Divider(),
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Text(
            _createResult(),
            style: theme.textTheme.title,
          ),
        ),
      ),
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Chips'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.vignette),
            onPressed: () {
              setState(() {
                _showShapeBorder = !_showShapeBorder;
              });
            },
          ),
        ],
      ),
      body: new ChipTheme(
        data: _showShapeBorder
            ? theme.chipTheme.copyWith(
                shape: new BeveledRectangleBorder(
                side: const BorderSide(
                  width: 0.66,
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
                borderRadius: new BorderRadius.circular(10.0),
              ))
            : theme.chipTheme,
        child: new ListView(
          children: _tiles,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _reset();
          });
        },
      ),
    );
  }
}
