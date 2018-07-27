import 'package:flutter/material.dart';
import 'dart:math' as math;

class Category {
  const Category({this.title, this.assets});
  final String title;
  final List<String> assets;
  @override
  String toString() => '$runtimeType("$title")';
}

const List<Category> _allCategorys = const <Category>[
  const Category(
    title: 'Home',
    assets: const <String>[
      'shrine/products/clock.png',
      'shrine/products/teapot.png',
      'shrine/products/radio.png',
      'shrine/products/lawn_chair.png',
      'shrine/products/chair.png',
    ],
  ),
  const Category(
    title: 'Red',
    assets: const <String>[
      'shrine/products/popsicle.png',
      'shrine/products/brush.png',
      'shrine/products/lipstick.png',
      'shrine/products/backpack.png',
    ],
  ),
  const Category(
    title: 'Sport',
    assets: const <String>[
      'shrine/products/helmet.png',
      'shrine/products/beachball.png',
      'shrine/products/flippers.png',
      'shrine/products/surfboard.png',
    ],
  ),
  const Category(
    title: 'Shoes',
    assets: const <String>[
      'shrine/products/chucks.png',
      'shrine/products/green-shoes.png',
      'shrine/products/heels.png',
      'shrine/products/flippers.png',
    ],
  ),
  const Category(
    title: 'Vision',
    assets: const <String>[
      'shrine/products/sunnies.png',
      'shrine/products/binoculars.png',
      'shrine/products/fish_bowl.png',
    ],
  ),
  const Category(
    title: 'Everything',
    assets: const <String>[
      'shrine/products/radio.png',
      'shrine/products/sunnies.png',
      'shrine/products/clock.png',
      'shrine/products/popsicle.png',
      'shrine/products/lawn_chair.png',
      'shrine/products/chair.png',
      'shrine/products/heels.png',
      'shrine/products/green-shoes.png',
      'shrine/products/teapot.png',
      'shrine/products/chucks.png',
      'shrine/products/brush.png',
      'shrine/products/fish_bowl.png',
      'shrine/products/lipstick.png',
      'shrine/products/backpack.png',
      'shrine/products/helmet.png',
      'shrine/products/beachball.png',
      'shrine/products/binoculars.png',
      'shrine/products/flippers.png',
      'shrine/products/surfboard.png',
    ],
  ),
];

class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({
    Key key,
    Listenable listenable,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return new DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: new Stack(
        children: <Widget>[
          new Opacity(
            opacity: new CurvedAnimation(
              parent: new ReverseAnimation(animation),
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Select a Category'),
          ),
          new Opacity(
            opacity: new CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Assert Viewer'),
          ),
        ],
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new Column(
      children: <Widget>[
        new Container(
          height: 48.0,
          padding: const EdgeInsetsDirectional.only(start: 16.0),
          alignment: AlignmentDirectional.centerStart,
          child: new DefaultTextStyle(
            style: theme.textTheme.subhead,
            child: new Tooltip(
              message: 'Tap to dismiss',
              child: new Text(category.title),
            ),
          ),
        ),
        const Divider(height: 1.0),
        new Expanded(
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            children: category.assets.map((String asset) {
              return new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Image.asset(
                        asset,
                        package: 'flutter_gallery_assets',
                        fit: BoxFit.contain,
                      ),
                      new Text(
                        asset,
                        style: new TextStyle(fontSize: 10.0),
                      ),
                      const Padding(
                          padding: const EdgeInsets.only(bottom: 10.0)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    this.categorys,
    this.selectedCategory,
    this.onCategorySelected,
  });

  final List<Category> categorys;
  final Category selectedCategory;
  final ValueChanged<Category> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return new ListTileTheme(
      iconColor: theme.primaryIconTheme.color,
      textColor: theme.primaryTextTheme.title.color.withOpacity(0.6),
      selectedColor: theme.primaryTextTheme.title.color,
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: categorys.map((Category category) {
            final bool selected = category == selectedCategory;

            return new Material(
              shape: const RoundedRectangleBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(4.0)),
              ),
              color: selected
                  ? Colors.white.withOpacity(0.25)
                  : Colors.transparent,
              child: new ListTile(
                title: new Text(category.title),
                selected: selected,
                onTap: () {
                  onCategorySelected(category);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BackdropDemo extends StatefulWidget {
  static const String routeName = 'material/backdrop';

  @override
  State createState() {
    return new _BackdropDemoState();
  }
}

class _BackdropDemoState extends State<BackdropDemo>
    with SingleTickerProviderStateMixin {

  final GlobalKey _backdropKey = new GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  Category _category = _allCategorys.first;

  @override
  void initState() {
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeCategory(Category category) {
    setState(() {
      _category = category;
      _controller.fling(velocity: 2.0);
    });
  }

  bool get categoryViewVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: categoryViewVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  // By design: the panel can only be opened with a swipe. To close the panel
  // the user must either tap its heading or the backdrop's menu icon.

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    _controller.value -= details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {

    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    Animation<RelativeRect> categoryViewAnimaton = new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(
        0.0,
        panelTop - MediaQuery.of(context).padding.bottom,
        0.0,
        panelTop - panelSize.height,
      ),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    final ThemeData theme = Theme.of(context);

    List<Widget> layers = <Widget>[
      new BackdropPanel(
        categorys: _allCategorys,
        selectedCategory: _category,
        onCategorySelected: _changeCategory,
      ),
      new PositionedTransition(
        rect: categoryViewAnimaton,
        child: new Material(
          elevation: 2.0,
          borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          child: new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            onTap: _toggleBackdropPanelVisibility,
            child: new CategoryView(
              category: _category,
            ),
          ),
        ),
      )
    ];

    return new Container(
      key: _backdropKey,
      color: theme.primaryColor,
      child: new Stack(
        children: layers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new BackdropTitle(
          listenable: _controller.view,
        ),
        actions: <Widget>[
          new IconButton(
            onPressed: _toggleBackdropPanelVisibility,
            icon: new AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller.view,
            ),
          )
        ],
      ),
      body: new LayoutBuilder(builder: _buildStack),
    );
  }
}
