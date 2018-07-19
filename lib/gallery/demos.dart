import 'package:flutter/material.dart';
import 'icons.dart';
import 'package:flutter_gallery_study/demo/all.dart';
import 'package:flutter_gallery_study/demo/material/buttons_demo.dart';

class GalleryDemo {
  const GalleryDemo({
    @required this.title,
    @required this.icon,
    this.subtitle,
    @required this.category,
    @required this.routeName,
    @required this.buildRoute,
  })  : assert(title != null),
        assert(category != null),
        assert(routeName != null),
        assert(buildRoute != null);

  final String title;
  final IconData icon;
  final String subtitle;
  final GalleryDemoCategory category;
  final String routeName;
  final WidgetBuilder buildRoute;

  @override
  String toString() {
    return '$runtimeType($title $routeName)';
  }
}

class GalleryDemoCategory {
  const GalleryDemoCategory._({this.name, this.icon});

  @required
  final String name;
  @required
  final IconData icon;

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;

    final GalleryDemoCategory typedOther = other;
    return typedOther.name == name && typedOther.icon == icon;
  }

  @override
  int get hashCode => hashValues(name, icon);
}

const GalleryDemoCategory _kDemos = const GalleryDemoCategory._(
  name: 'Studies',
  icon: GalleryIcons.animation,
);

const GalleryDemoCategory _kStyle = const GalleryDemoCategory._(
  name: 'Style',
  icon: GalleryIcons.custom_typography,
);

const GalleryDemoCategory _kMaterialComponents = const GalleryDemoCategory._(
  name: 'Material',
  icon: GalleryIcons.category_mdc,
);

const GalleryDemoCategory _kCupertinoComponents = const GalleryDemoCategory._(
  name: 'Cupertino',
  icon: GalleryIcons.phone_iphone,
);

const GalleryDemoCategory _kMedia = const GalleryDemoCategory._(
  name: 'Media',
  icon: GalleryIcons.drive_video,
);

List<GalleryDemo> _buildGalleryDemos() {
  final List<GalleryDemo> galleryDemos = <GalleryDemo>[
    // Demos
    new GalleryDemo(
      title: 'Colors',
      subtitle: 'All of the predefined colors',
      icon: GalleryIcons.colors,
      category: _kStyle,
      routeName: ColorsDemo.routeName,
      buildRoute: (BuildContext context) => new ColorsDemo(),
    ),
    new GalleryDemo(
      title: 'Typography',
      subtitle: 'All of the predefined text styles',
      icon: GalleryIcons.custom_typography,
      category: _kStyle,
      routeName: TypographyDemo.routeName,
      buildRoute: (BuildContext context) => new TypographyDemo(),
    ),

    //Material
    new GalleryDemo(
      title: 'Buttons',
      subtitle: 'Flat, raised, dropdown, and more',
      icon: GalleryIcons.generic_buttons,
      category: _kMaterialComponents,
      routeName: ButtonsDemo.routeName,
      buildRoute: (BuildContext context) => new ButtonsDemo(),
    ),
    new GalleryDemo(
      title: 'Buttons:Floating Action Button',
      subtitle: 'FAB with transitions',
      icon: Icons.add,
      category: _kMaterialComponents,
      routeName: TabsFabDemo.routeName,
      buildRoute: (BuildContext context) => new TabsFabDemo(),
    ),
    new GalleryDemo(
      title: 'Tooltip',
      subtitle: 'Short message displayed on long-press',
      icon: Icons.message,
      category: _kMaterialComponents,
      routeName: TooltipDemo.routeName,
      buildRoute: (BuildContext context) => new TooltipDemo(),
    ),
    new GalleryDemo(
      title: 'Snackbar',
      subtitle: 'Temporary messaging',
      icon: Icons.computer,
      category: _kMaterialComponents,
      routeName: SnackbarDemo.routeName,
      buildRoute: (BuildContext context) => new SnackbarDemo(),
    ),
    new GalleryDemo(
      title: 'Tabs',
      subtitle: 'Tabs with independently scrollable views',
      icon: Icons.tab,
      category: _kMaterialComponents,
      routeName: TabsDemo.routeName,
      buildRoute: (BuildContext context) => new TabsDemo(),
    ),
    new GalleryDemo(
      title: 'Tabs:Scrolling',
      subtitle: 'Tabs that scrolls',
      icon: Icons.tab,
      category: _kMaterialComponents,
      routeName: ScrollableTabsDemo.routeName,
      buildRoute: (BuildContext context) => new ScrollableTabsDemo(),
    ),
    new GalleryDemo(
      title: 'Sliders',
      subtitle: 'Widgets for selecting a value by swiping',
      icon: GalleryIcons.sliders,
      category: _kMaterialComponents,
      routeName: SlidersDemo.routeName,
      buildRoute: (BuildContext context) => new SlidersDemo(),
    ),
    new GalleryDemo(
      title: 'Selection controls',
      subtitle: 'Checkboxes,radio buttons,and switches',
      icon: GalleryIcons.check_box,
      category: _kMaterialComponents,
      routeName: SelectionControlsDemo.routeName,
      buildRoute: (BuildContext context) => new SelectionControlsDemo(),
    ),
    new GalleryDemo(
      title: 'Progress indicator',
      subtitle: 'Liner,circle,indeterminate',
      icon: GalleryIcons.progress_activity,
      category: _kMaterialComponents,
      routeName: ProgressIndicatorDemo.routeName,
      buildRoute: (BuildContext context) => new ProgressIndicatorDemo(),
    ),
    new GalleryDemo(
      title: 'Bottom sheet: Modal',
      subtitle: 'A dismissable bottom sheet',
      icon: GalleryIcons.bottom_sheets,
      category: _kMaterialComponents,
      routeName: ModalBottomSheetDemo.routeName,
      buildRoute: (BuildContext context) => new ModalBottomSheetDemo(),
    ),
    new GalleryDemo(
      title: 'Menus',
      icon: GalleryIcons.menu,
      category: _kMaterialComponents,
      routeName: MenuButtonDemo.routeName,
      buildRoute: (BuildContext context) => new MenuButtonDemo(),
    ),
    new GalleryDemo(
      title: 'Search',
      subtitle: 'Expandable search',
      icon: Icons.search,
      category: _kMaterialComponents,
      routeName: SearchDemo.routeName,
      buildRoute: (BuildContext context) => new SearchDemo(),
    ),
    new GalleryDemo(
      title: 'Navigation drawer',
      subtitle: 'Navigation drawer with standard header',
      icon: Icons.menu,
      category: _kMaterialComponents,
      routeName: DrawerDemo.routeName,
      buildRoute: (BuildContext context) => new DrawerDemo(),
    ),
    new GalleryDemo(
      title: 'Grid',
      subtitle: 'Row and column layout',
      icon: Icons.grid_on,
      category: _kMaterialComponents,
      routeName: GridDemo.routeName,
      buildRoute: (BuildContext context) => new GridDemo(),
    ),


    //Cupertino
    new GalleryDemo(
      title: 'Activity Indicator',
      icon: GalleryIcons.cupertino_progress,
      category: _kCupertinoComponents,
      routeName: CupertinoProgressIndicatorDemo.routeName,
      buildRoute: (BuildContext context) =>
          new CupertinoProgressIndicatorDemo(),
    ),
    new GalleryDemo(
      title: 'Buttons',
      icon: GalleryIcons.generic_buttons,
      category: _kCupertinoComponents,
      routeName: CupertinoButtonsDemo.routeName,
      buildRoute: (BuildContext context) =>
      new CupertinoButtonsDemo(),
    ),
    new GalleryDemo(
      title: 'Pickers',
      icon: GalleryIcons.event,
      category: _kCupertinoComponents,
      routeName: CupertinoPickerDemo.routeName,
      buildRoute: (BuildContext context) =>
      new CupertinoPickerDemo(),
    ),
    new GalleryDemo(
      title: 'Sliders',
      icon: GalleryIcons.sliders,
      category: _kCupertinoComponents,
      routeName: CupertinoSliderDemo.routeName,
      buildRoute: (BuildContext context) =>
      new CupertinoSliderDemo(),
    ),
    new GalleryDemo(
      title: 'Switches',
      icon: GalleryIcons.cupertino_switch,
      category: _kCupertinoComponents,
      routeName: CupertinoSwitchDemo.routeName,
      buildRoute: (BuildContext context) =>
      new CupertinoSwitchDemo(),
    ),
    new GalleryDemo(
      title: 'Pull to refresh',
      icon: GalleryIcons.cupertino_pull_to_refresh,
      category: _kCupertinoComponents,
      routeName: CupertinoRefreshControlDemo.routeName,
      buildRoute: (BuildContext context) =>
      new CupertinoRefreshControlDemo(),
    ),
    new GalleryDemo(
      title: 'Dialogs',
      icon: GalleryIcons.dialogs,
      category: _kCupertinoComponents,
      routeName: CupertinoDialogsDemo.routeName,
      buildRoute: (BuildContext context) =>
      new CupertinoDialogsDemo(),
    ),
    new GalleryDemo(
      title: 'Navigation',
      icon: GalleryIcons.dialogs,
      category: _kCupertinoComponents,
      routeName: CupertinoNavigationDemo.routeName,
      buildRoute: (BuildContext context) =>
      new CupertinoNavigationDemo(),
    ),

    // Media
    new GalleryDemo(
      title: 'Animated images',
      subtitle: 'GIF and WebP animations',
      icon: GalleryIcons.animation,
      category: _kMedia,
      routeName: ImagesDemo.routeName,
      buildRoute: (BuildContext context) => new ImagesDemo(),
    ),
    new GalleryDemo(
      title: 'Video',
      subtitle: 'Video playback',
      icon: GalleryIcons.drive_video,
      category: _kMedia,
      routeName: VideoDemo.routeName,
      buildRoute: (BuildContext context) => const VideoDemo(),
    ),
  ];

  // Keep Pesto around for its regression test value. It is not included
  // in (release builds) the performance tests.
  assert(() {
    galleryDemos.insert(
      0,
      new GalleryDemo(
        title: 'Pesto',
        subtitle: 'Simple recipe browser',
        icon: Icons.adjust,
        category: _kDemos,
        routeName: PestoDemo.routeName,
        buildRoute: (BuildContext context) => const PestoDemo(),
      ),
    );
    return true;
  }());

  return galleryDemos;
}

final List<GalleryDemo> kAllGalleryDemos = _buildGalleryDemos();

final Set<GalleryDemoCategory> kAllGalleryDemoCategories = kAllGalleryDemos
    .map<GalleryDemoCategory>((GalleryDemo demo) => demo.category)
    .toSet();

final Map<GalleryDemoCategory, List<GalleryDemo>> kGalleryCategoryToDemos =
    new Map<GalleryDemoCategory, List<GalleryDemo>>.fromIterable(
  kAllGalleryDemoCategories,
  value: (dynamic category) {
    return kAllGalleryDemos
        .where((GalleryDemo demo) => demo.category == category)
        .toList();
  },
);
