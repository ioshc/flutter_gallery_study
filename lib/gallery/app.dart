import 'dart:async';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'package:url_launcher/url_launcher.dart';

import 'home.dart';
import 'options.dart';
import 'themes.dart';
import 'scales.dart';
import 'demos.dart';

class GalleryApp extends StatefulWidget {

  const GalleryApp({
    Key key,
    this.onSendFeedback,
  }) : super(key: key);

  final VoidCallback onSendFeedback;

  _GalleryAppState createState() => new _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {

  GalleryOptions _options;
  Timer _timeDilationTimer;

  Map<String, WidgetBuilder> _buildRoutes() {
    // For a different example of how to set up an application routing table
    // using named routes, consider the example in the Navigator class documentation:
    // https://docs.flutter.io/flutter/widgets/Navigator-class.html
    return new Map<String, WidgetBuilder>.fromIterable(
      kAllGalleryDemos,
      key: (dynamic demo) => '${demo.routeName}',
      value: (dynamic demo) => demo.buildRoute,
    );
  }

  @override
  void initState() {
    super.initState();
    _options = new GalleryOptions(
      theme: kLightGalleryTheme,
      textScaleFactor: kAllGalleryTextScaleValues[0],
      timeDilation: timeDilation,
      platform: defaultTargetPlatform,
    );
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  Widget _applyTextScaleFactor(Widget child) {
    return new Builder(
      builder: (BuildContext context) {
        return new MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: _options.textScaleFactor.scale,
          ),
          child: child,
        );
      },
    );
  }

  void _handleOptionsChanged(GalleryOptions newOptions) {
    setState(() {
      if (_options.timeDilation != newOptions.timeDilation) {
        _timeDilationTimer?.cancel();
        _timeDilationTimer = null;
        if (newOptions.timeDilation > 1.0) {
          // We delay the time dilation change long enough that the user can see
          // that UI has started reacting and then we slam on the brakes so that
          // they see that the time is in fact now dilated.
          _timeDilationTimer = new Timer(const Duration(milliseconds: 150), () {
            timeDilation = newOptions.timeDilation;
          });
        } else {
          timeDilation = newOptions.timeDilation;
        }
      }

      _options = newOptions;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget home = new GalleryHome(
      optionsPage: new GalleryOptionsPage(
          options: _options,
          onOptionsChanged: _handleOptionsChanged,
          onSendFeedback: widget.onSendFeedback ?? () {
            launch('https://www.baidu.com', forceSafariVC: false);
          }
      ),
    );

    return new MaterialApp(
      theme: _options.theme.data.copyWith(platform: _options.platform),
      title: 'Flutter Gallery Study',
      color: Colors.grey,
      showPerformanceOverlay: _options.showPerformanceOverlay,
      checkerboardOffscreenLayers: _options.showOffscreenLayersCheckerboard,
      checkerboardRasterCacheImages: _options.showRasterCacheImagesCheckerboard,
      routes: _buildRoutes(),
      builder: (BuildContext context, Widget child) {
        return new Directionality(
          textDirection: _options.textDirection,
          child: _applyTextScaleFactor(child),
        );
      },
      home: home,
    );
  }
  
}