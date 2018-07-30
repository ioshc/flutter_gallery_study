import 'package:flutter/material.dart';

import 'shrine_data.dart';
import 'shrine_types.dart';

enum ShrineOrderPageAction {
  sortByPrice,
  sortByProduct,
  emptyShoppingCart,
}

enum ShrineOrderPageSortType {
  byPrice,
  byProduct,
}

class ShrineOrderPage extends StatefulWidget {
  const ShrineOrderPage(this.product);

  static const String routeName = '/shrine/order';

  final Product product;

  @override
  State createState() {
    return new _ShrineOrderPageState();
  }
}

class _ShrineOrderPageState extends State<ShrineOrderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ShrineOrderPageSortType _sortType = ShrineOrderPageSortType.byPrice;

  void _handleMenuAction(ShrineOrderPageAction action) {
    switch (action) {
      case ShrineOrderPageAction.sortByPrice:
      case ShrineOrderPageAction.sortByProduct:
        break;
      case ShrineOrderPageAction.emptyShoppingCart:
        showSnackBarMessage('Shopping cart is empty');
        break;
    }
  }

  void showSnackBarMessage(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: new AppBar(
        title: const Text('SHRINE'),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          new PopupMenuButton<ShrineOrderPageAction>(
            onSelected: _handleMenuAction,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ShrineOrderPageAction>>[
                new PopupMenuItem(
                  child: const Text('Sort by price'),
                  value: ShrineOrderPageAction.sortByPrice,
                ),
                new PopupMenuItem(
                  child: const Text('Sort by product'),
                  value: ShrineOrderPageAction.sortByProduct,
                ),
                new PopupMenuItem(
                  child: const Text('Empty shopping cart'),
                  value: ShrineOrderPageAction.emptyShoppingCart,
                ),
              ];
            },
          ),
        ],
      ),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverToBoxAdapter(
            child: new _Header(widget.product),
          ),
          new SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 8.0),
            sliver: new SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: allProducts().map((Product product) {
                return new Card(
                  child: new Image.asset(
                    product.imageAsset,
                    package: product.imageAssetPackage,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: const Icon(
          Icons.add_shopping_cart,
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  const _Header(this.product);
  final Product product;

  @override
  State createState() {
    return new _HeaderState();
  }
}

class _HeaderState extends State<_Header> {

  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.info_outline,
              size: 24.0,
              color: const Color(0xFFFFE0E0),
            ),
            onPressed: () {},
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 200.0,
                child: new Hero(
                  tag: widget.product.tag,
                  child: new Image.asset(
                    widget.product.imageAsset,
                    package: widget.product.imageAssetPackage,
                  ),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 20.0)),
              new Text(
                widget.product.name,
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 20.0)),
              new LimitedBox(
                maxWidth: 300.0,
                child: new Text(
                  widget.product.description,
                  softWrap: true,
                  style: new TextStyle(color: Colors.black54),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 20.0)),
              new Container(
                width: 240.0,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey),
                ),
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    value: _quantity,
                    items: <int>[0, 1, 2, 3, 4, 5].map((int value) {
                      return new DropdownMenuItem<int>(
                        value: value,
                        child: new Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: new Text('Quantity $value'),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _quantity = value;
                      });
                    },
                  ),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 20.0)),
              new Text(
                widget.product.vendor.name,
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 20.0)),
              new LimitedBox(
                maxWidth: 300.0,
                child: new Text(
                  widget.product.vendor.description,
                  softWrap: true,
                  style: new TextStyle(color: Colors.black54),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 50.0)),
            ],
          ),
        ],
      ),
    );
  }
}
