import 'package:flutter/material.dart';

import 'shrine_data.dart';
import 'shrine_types.dart';
import 'shrine_order.dart';

enum ShrineHomePageAction {
  sortByPrice,
  sortByProduct,
  emptyShoppingCart,
}

enum ShrineHomePageSortType {
  byPrice,
  byProduct,
}

class ShrineHomePage extends StatefulWidget {
  @override
  State createState() {
    return new _ShrineHomePageState();
  }
}

class _ShrineHomePageState extends State<ShrineHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ShrineHomePageSortType _sortType = ShrineHomePageSortType.byPrice;

  void _handleMenuAction(ShrineHomePageAction action) {}

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
          new PopupMenuButton<ShrineHomePageAction>(
            onSelected: _handleMenuAction,
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ShrineHomePageAction>>[
                new PopupMenuItem(
                  child: const Text('Sort by price'),
                  value: ShrineHomePageAction.sortByPrice,
                ),
                new PopupMenuItem(
                  child: const Text('Sort by product'),
                  value: ShrineHomePageAction.sortByProduct,
                ),
                new PopupMenuItem(
                  child: const Text('Empty shopping cart'),
                  value: ShrineHomePageAction.emptyShoppingCart,
                ),
              ];
            },
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new _ShrineHomePageDayShop(),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                new _ShrineHomePageSection(
                  products: allProducts().sublist(0, 8),
                ),
                new _ShrineHomePageSection(
                  products: allProducts().sublist(8, 16),
                ),
                new _ShrineHomePageSection(
                  products: allProducts().sublist(16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ShrineHomePageDayShop extends StatelessWidget {
  final Product any = allProducts()
      .singleWhere((Product product) => product.featureDescription != null);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        border: new Border(
          bottom: new BorderSide(color: theme.dividerColor),
        ),
      ),
      child: new Stack(
        children: <Widget>[
          new Align(
            widthFactor: 0.0,
            child: new Image.asset(
              any.imageAsset,
              package: any.imageAssetPackage,
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Text(any.priceString),
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 150.0),
                child: Column(
                  children: <Widget>[
                    new Text(
                      any.featureTitle,
                      style: new TextStyle(fontSize: 38.0),
                      softWrap: true,
                    ),
                    new Container(
                      padding: const EdgeInsets.only(top: 10.0, right: 40.0),
                      child: new Text(
                        any.featureDescription,
                        style: new TextStyle(color: Colors.black54),
                        softWrap: true,
                      ),
                    ),
                    new SizedBox(
                      height: 10.0,
                    ),
                    new _ShrineHomePageVendor(any.vendor),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShrineHomePageVendor extends StatelessWidget {
  const _ShrineHomePageVendor(this.vendor);

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 24.0,
      child: new Row(
        children: <Widget>[
          new ClipRRect(
            borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
            child: new Image.asset(
              vendor.avatarAsset,
              package: vendor.avatarAssetPackage,
            ),
          ),
          new Padding(padding: const EdgeInsets.only(left: 10.0)),
          new Text(
            vendor.name,
            style: new TextStyle(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}

class _ShrineHomePageSection extends StatelessWidget {
  const _ShrineHomePageSection({this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty)
      return new SizedBox(
        width: 0.0,
        height: 0.0,
      );

    List<List<Product>> _splitedList = <List<Product>>[];

    if (products.length < 3) {
      products.forEach((Product product) {
        _splitedList.add([product]);
      });
    } else {
      for (int i = 0; i < products.length; i++) {
        Product product = products[i];

        //前面6个俩俩组合
        if (i < 6) {
          if (i % 2 == 0) {
            //偶数加在新数组中
            _splitedList.add([product]);
          } else {
            //奇数加在最后一个数组中
            _splitedList.last.add(product);
          }

          continue;
        }

        //6个之后的单独放
        _splitedList.add([product]);
      }
    }

    return new Column(
      children: _splitedList.map((List<Product> rows) {
        if (rows.length == 1) {
          return new _ShrineHomePageCard(rows.first);
        }

        return new Row(
          children: rows.map((Product product) {
            return new Expanded(child: new _ShrineHomePageCard(product));
          }).toList(),
        );
      }).toList(),
    );
  }
}

class _ShrineHomePageCard extends StatelessWidget {

  const _ShrineHomePageCard(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(context, new MaterialPageRoute<void>(
          settings: const RouteSettings(name: ShrineOrderPage.routeName),
          builder: (BuildContext context) {
            return new ShrineOrderPage(product);
          },
        ));
      },
      child: new Container(
        padding: const EdgeInsets.all(5.0),
        child: new Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(product.priceString),
              ),
              new Hero(
                tag: product.tag,
                child: new Center(
                  child: new Image.asset(
                    product.imageAsset,
                    height: 120.0,
                    package: product.imageAssetPackage,
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new _ShrineHomePageVendor(product.vendor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
