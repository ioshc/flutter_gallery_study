import 'package:flutter/material.dart';
import 'backdrop.dart';
import 'demos.dart';
import 'dart:math' as math;

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';
const Color _kFlutterBlue = const Color(0xFF003D75);
const Duration _kFrontLayerSwitchDuration = const Duration(milliseconds: 300);

class _FlutterLogo extends StatelessWidget {
  const _FlutterLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        width: 34.0,
        height: 34.0,
        child: new DecoratedBox(
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                'white_logo/logo.png',
                package: _kGalleryAssetsPackage,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key key,
    this.category,
    this.onTap,
  }) : super(key: key);

  final GalleryDemoCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    // This repaint boundary prevents the entire _CategoriesPage from being
    // repainted when the button's ink splash animates.
    return new RepaintBoundary(
      child: new RawMaterialButton(
        padding: EdgeInsets.zero,
        splashColor: theme.primaryColor.withOpacity(0.12),
        highlightColor: Colors.transparent,
        onPressed: onTap,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new Icon(
                category.icon,
                size: 60.0,
                color: isDark ? Colors.white : _kFlutterBlue,
              ),
            ),
            const SizedBox(height: 10.0),
            new Container(
              height: 48.0,
              alignment: Alignment.center,
              child: new Text(
                category.name,
                textAlign: TextAlign.center,
                style: theme.textTheme.subhead.copyWith(
                  fontFamily: 'GoogleSans',
                  color: isDark ? Colors.white : _kFlutterBlue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CategoriesPage extends StatelessWidget {
  const _CategoriesPage({
    Key key,
    this.categories,
    this.onCategoryTap,
  }) : super(key: key);

  final Iterable<GalleryDemoCategory> categories;
  final ValueChanged<GalleryDemoCategory> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = 160.0 / 180.0;
    final List<GalleryDemoCategory> categoriesList = categories.toList();
    final int columnCount =
        (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3;

    Widget _buildContent(BuildContext context, BoxConstraints constraints) {
      final double columnWidth =
          constraints.biggest.width / columnCount.toDouble();
      final double rowHeight = math.min(225.0, columnWidth * aspectRatio);
      final int rowCount = (categories.length + columnCount - 1) ~/ columnCount;

      // This repaint boundary prevents the inner contents of the front layer
      // from repainting when the backdrop toggle triggers a repaint on the
      // LayoutBuilder.
      return new RepaintBoundary(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: new List<Widget>.generate(rowCount, (int rowIndex) {
            final int columnCountForRow = (rowIndex == (rowCount - 1))
                ? categories.length - columnCount * math.max(0, rowCount - 1)
                : columnCount;
            return new Row(
              children: new List<Widget>.generate(columnCountForRow,
                  (int columnIndex) {
                final int index = rowIndex * columnCount + columnIndex;
                final GalleryDemoCategory category = categoriesList[index];

                return new SizedBox(
                  width: columnWidth,
                  height: rowHeight,
                  child: new _CategoryItem(
                    category: category,
                    onTap: () {
                      onCategoryTap(category);
                    },
                  ),
                );
              }),
            );
          }),
        ),
      );
    }

    return new Semantics(
      scopesRoute: true,
      namesRoute: true,
      label: 'categories',
      explicitChildNodes: true,
      child: new SingleChildScrollView(
        child: new LayoutBuilder(builder: _buildContent),
      ),
    );
  }
}

class GalleryHome extends StatefulWidget {

  const GalleryHome({
    Key key,
    this.optionsPage,
  }) : super(key: key);

  final Widget optionsPage;

  @override
  _GalleryHomeState createState() => new _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {

  GalleryDemoCategory _category;

  static Widget _topHomeLayout(Widget currentChild, List<Widget> previousChildren) {
    List<Widget> children = previousChildren;
    if (currentChild != null)
      children = children.toList()..add(currentChild);
    return new Stack(
      children: children,
      alignment: Alignment.topCenter,
    );
  }

  static const AnimatedSwitcherLayoutBuilder _centerHomeLayout =
      AnimatedSwitcher.defaultLayoutBuilder;

  @override
  Widget build(BuildContext context) {
    const Curve switchOutCurve =
        const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn);
    const Curve switchInCurve =
        const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn);

    return new Scaffold(
      backgroundColor: _kFlutterBlue,
      body: new SafeArea(
        bottom: false,
        child: new Backdrop(
          backTitle: new Text('Options'),
          backLayer: widget.optionsPage,
          frontTitle: new AnimatedSwitcher(
            duration: _kFrontLayerSwitchDuration,
            child: const Text('Flutter gallery'),
          ),
          frontAction: new AnimatedSwitcher(
            duration: _kFrontLayerSwitchDuration,
            switchOutCurve: switchOutCurve,
            switchInCurve: switchInCurve,
            child: _category == null
                ? const _FlutterLogo()
                : new IconButton(
              icon: const BackButtonIcon(),
              tooltip: 'Back',
              onPressed: () => setState(() => _category = null),
            ),
          ),
          frontHeading: new Container(height: 24.0),
          frontLayer: new AnimatedSwitcher(
            duration: _kFrontLayerSwitchDuration,
            switchOutCurve: switchOutCurve,
            switchInCurve: switchInCurve,
            layoutBuilder: _topHomeLayout,
            child: new _CategoriesPage(
              categories: kAllGalleryDemoCategories,
              onCategoryTap: (GalleryDemoCategory category) {
                setState(() => _category = category);
              },
            ),
          ),
        ),
      ),
    );
  }
}
