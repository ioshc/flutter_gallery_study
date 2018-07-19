import 'package:flutter/material.dart';

enum GridDemoTileStyle { imageOnly, oneLine, twoLine }

typedef void BannerTapCallback(Photo photo);

const double _kMinFlingVelocity = 800.0;
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class Photo {
  Photo({
    this.assetName,
    this.assetPackage,
    this.title,
    this.caption,
    this.isFavorite: false,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final String caption;

  bool isFavorite;
  String get tag => assetName; // Assuming that all asset names are unique.

  bool get isValid =>
      assetName != null &&
      title != null &&
      caption != null &&
      isFavorite != null;
}

class GridDemo extends StatefulWidget {
  static const routeName = "material/grid";

  _GridDemoState createState() => new _GridDemoState();
}

class _GridDemoState extends State<GridDemo> {
  GridDemoTileStyle _tileStyle = GridDemoTileStyle.twoLine;

  List<Photo> _photos = <Photo>[
    new Photo(
      assetName: 'landscape_0.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Philippines',
      caption: 'Batad rice terraces',
    ),
    new Photo(
      assetName: 'landscape_1.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Italy',
      caption: 'Ceresole Reale',
    ),
    new Photo(
      assetName: 'landscape_2.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Somewhere',
      caption: 'Beautiful mountains',
    ),
    new Photo(
      assetName: 'landscape_3.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'A place',
      caption: 'Beautiful hills',
    ),
    new Photo(
      assetName: 'landscape_4.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'New Zealand',
      caption: 'View from the van',
    ),
    new Photo(
      assetName: 'landscape_5.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Autumn',
      caption: 'The golden season',
    ),
    new Photo(
      assetName: 'landscape_6.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Germany',
      caption: 'Englischer Garten',
    ),
    new Photo(
      assetName: 'landscape_7.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'A country',
      caption: 'Grass fields',
    ),
    new Photo(
      assetName: 'landscape_8.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Mountain country',
      caption: 'River forest',
    ),
    new Photo(
      assetName: 'landscape_9.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Alpine place',
      caption: 'Green hills',
    ),
    new Photo(
      assetName: 'landscape_10.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Desert land',
      caption: 'Blue skies',
    ),
    new Photo(
      assetName: 'landscape_11.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: 'Narnia',
      caption: 'Rocks and rivers',
    ),
  ];

  void _changeTileStyle(GridDemoTileStyle style) {
    setState(() {
      _tileStyle = style;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: new AppBar(
        title: const Text('Grid List'),
        actions: <Widget>[
          new PopupMenuButton<GridDemoTileStyle>(
            onSelected: _changeTileStyle,
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<GridDemoTileStyle>>[
                  new PopupMenuItem<GridDemoTileStyle>(
                    value: GridDemoTileStyle.imageOnly,
                    child: const Text('Image only'),
                  ),
                  new PopupMenuItem(
                    value: GridDemoTileStyle.oneLine,
                    child: const Text('One line'),
                  ),
                  new PopupMenuItem(
                    value: GridDemoTileStyle.twoLine,
                    child: const Text('Two line'),
                  ),
                ],
          ),
        ],
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new GridView.count(
          crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: const EdgeInsets.all(4.0),
          childAspectRatio: (orientation == Orientation.portrait) ? 1.0 : 1.3,
          children: _photos.map((Photo photo) {
            return new _GridItem(
              photo: photo,
              tileStyle: _tileStyle,
              onBannerTap: (Photo photo) {
                setState(() {
                  photo.isFavorite = !photo.isFavorite;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({this.photo, this.tileStyle, this.onBannerTap});

  final Photo photo;
  final GridDemoTileStyle tileStyle;
  final BannerTapCallback onBannerTap;

  void _showPhoto(BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: new AppBar(
              title: new Text(photo.title),
            ),
            body: new SizedBox.expand(
              child: new Hero(
                tag: photo.tag,
                child: new _GridItemViewer(photo: photo),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget image = new GestureDetector(
        onTap: () {
          _showPhoto(context);
        },
        child: new Hero(
            key: new Key(photo.assetName),
            tag: photo.tag,
            child: new Image.asset(
              photo.assetName,
              package: photo.assetPackage,
              fit: BoxFit.cover,
            )));

    final IconData icon = photo.isFavorite ? Icons.star : Icons.star_border;

    switch (tileStyle) {
      case GridDemoTileStyle.imageOnly:
        return image;

      case GridDemoTileStyle.oneLine:
        return new GridTile(
          header: new GestureDetector(
            onTap: () {
              onBannerTap(photo);
            },
            child: new GridTileBar(
              title: new _GridTitleText(photo.title),
              backgroundColor: Colors.black45,
              leading: new Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          child: image,
        );

      case GridDemoTileStyle.twoLine:
        return new GridTile(
          footer: new GestureDetector(
            onTap: () {
              onBannerTap(photo);
            },
            child: new GridTileBar(
              backgroundColor: Colors.black45,
              title: new _GridTitleText(photo.title),
              subtitle: new _GridTitleText(photo.caption),
              trailing: new Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          child: image,
        );
    }
    assert(tileStyle != null);
    return null;
  }
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: new Text(text),
    );
  }
}

class _GridItemViewer extends StatefulWidget {

  const _GridItemViewer({ Key key, this.photo }) : super(key: key);
  final Photo photo;

  @override
  _GridItemViewerState createState() => new _GridItemViewerState();
}

class _GridItemViewerState extends State<_GridItemViewer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _flingAnimation;
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  Offset _normalizedOffset;
  double _previousScale;

  @override
  void initState() {
    _controller = AnimationController(
      duration: new Duration(microseconds: 200),
      vsync: this,
    )..addListener(_handleFlingAnimation);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // The maximum offset value is 0,0. If the size of this renderer's box is w,h
  // then the minimum offset value is w - _scale * w, h - _scale * h.
  Offset _clampOffset(Offset offset) {
    final Size size = context.size;
    final Offset minOffset = new Offset(size.width, size.height) * (1.0 - _scale);
    return new Offset(offset.dx.clamp(minOffset.dx, 0.0), offset.dy.clamp(minOffset.dy, 0.0));
  }

  void _handleFlingAnimation() {
    setState(() {
      _offset = _flingAnimation.value;
    });
  }

  void _handleOnScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.focalPoint - _offset) / _scale;
      // The fling animation stops if an input gesture starts.
      _controller.stop();
    });
  }

  void _handleOnScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = (_previousScale * details.scale).clamp(1.0, 4.0);
      // Ensure that image location under the focal point stays in the same place despite scaling.
      _offset = _clampOffset(details.focalPoint - _normalizedOffset * _scale);
    });
  }

  void _handleOnScaleEnd(ScaleEndDetails details) {
    final double magnitude = details.velocity.pixelsPerSecond.distance;
    if (magnitude < _kMinFlingVelocity)
      return;
    final Offset direction = details.velocity.pixelsPerSecond / magnitude;
    final double distance = (Offset.zero & context.size).shortestSide;
    _flingAnimation = new Tween<Offset>(
        begin: _offset,
        end: _clampOffset(_offset + direction * distance)
    ).animate(_controller);
    _controller
      ..value = 0.0
      ..fling(velocity: magnitude / 1000.0);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onScaleStart: _handleOnScaleStart,
      onScaleUpdate: _handleOnScaleUpdate,
      onScaleEnd: _handleOnScaleEnd,
      child: new ClipRect(
        child: new Transform(
          transform: new Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale),
          child: new Image.asset(
            widget.photo.assetName,
            package: widget.photo.assetPackage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
