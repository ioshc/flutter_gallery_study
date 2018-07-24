import 'package:flutter/material.dart';

const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class TravelDestination {
  const TravelDestination({
    this.assetName,
    this.assetPackage,
    this.title,
    this.description,
  });

  final String assetName;
  final String assetPackage;
  final String title;
  final List<String> description;

  bool get isValid =>
      assetName != null && title != null && description?.length == 3;
}

final List<TravelDestination> destinations = <TravelDestination>[
  const TravelDestination(
    assetName: 'landscape_1.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Top 10 Australian beaches',
    description: const <String>[
      'Number 10',
      'Whitehaven Beach',
      'Whitsunday Island, Whitsunday Islands',
    ],
  ),
  const TravelDestination(
    assetName: 'landscape_2.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Kangaroo Valley Safari',
    description: const <String>[
      '2031 Moss Vale Road',
      'Kangaroo Valley 2577',
      'New South Wales',
    ],
  ),
  const TravelDestination(
    assetName: 'landscape_3.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Top 10 Australian beaches',
    description: const <String>[
      'Number 10',
      'Whitehaven Beach',
      'Whitsunday Island, Whitsunday Islands',
    ],
  ),
  const TravelDestination(
    assetName: 'landscape_4.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Kangaroo Valley Safari',
    description: const <String>[
      '2031 Moss Vale Road',
      'Kangaroo Valley 2577',
      'New South Wales',
    ],
  ),
  const TravelDestination(
    assetName: 'landscape_5.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Top 10 Australian beaches',
    description: const <String>[
      'Number 10',
      'Whitehaven Beach',
      'Whitsunday Island, Whitsunday Islands',
    ],
  ),
  const TravelDestination(
    assetName: 'landscape_6.jpg',
    assetPackage: _kGalleryAssetsPackage,
    title: 'Kangaroo Valley Safari',
    description: const <String>[
      '2031 Moss Vale Road',
      'Kangaroo Valley 2577',
      'New South Wales',
    ],
  ),
];

class CardsDemo extends StatefulWidget {
  static const String routeName = "material/cards";

  @override
  _CardsDemoState createState() => _CardsDemoState();
}

class _CardsDemoState extends State<CardsDemo> {
  ShapeBorder _shape;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Travek stream'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.face),
            onPressed: () {
              setState(() {
                _shape = _shape != null
                    ? null
                    : const RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(26.0),
                          topRight: const Radius.circular(26.0),
                          bottomLeft: const Radius.circular(4.0),
                          bottomRight: const Radius.circular(4.0),
                        ),
                      );
              });
            },
          )
        ],
      ),
      body: new ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: destinations.length,
        itemBuilder: (BuildContext context, int index) {

          return new Container(
            padding: const EdgeInsets.all(10.0),
            child: new _CardItem(
              destination: destinations[index],
              shape: _shape,
            ),
          );
        },
      ),
    );
  }
}

class _CardItem extends StatelessWidget {
  const _CardItem({this.destination, this.shape});

  final TravelDestination destination;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: shape,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget>[
              new Image.asset(
                destination.assetName,
                package: destination.assetPackage,
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Top 10 Cities to Visit Tamil Nadu',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
          new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(destination.description[0],
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.black54)),
                new Padding(padding: const EdgeInsets.only(top: 10.0)),
                new Text(destination.description[1]),
                new Text(destination.description[2]),
              ],
            ),
          ),
          new ButtonTheme.bar(
            child: new ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                new FlatButton(
                  child: const Text('SHARE'),
                  textColor: Colors.amber.shade500,
                  onPressed: () {/* do nothing */},
                ),
                new FlatButton(
                  child: const Text('EXPLORE'),
                  textColor: Colors.amber.shade500,
                  onPressed: () {/* do nothing */},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
