// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

import 'shrine_data.dart';
import 'shrine_order.dart';
import 'shrine_page.dart';
import 'shrine_theme.dart';
import 'shrine_types.dart';

const double unitSize = kToolbarHeight;

final List<Product> _products = new List<Product>.from(allProducts());
final Map<Product, Order> _shoppingCart = <Product, Order>{};

const int _childrenPerBlock = 8;
const int _rowsPerBlock = 5;

int _minIndexInRow(int rowIndex) {
  final int blockIndex = rowIndex ~/ _rowsPerBlock;
  return const <int>[0, 2, 4, 6, 7][rowIndex % _rowsPerBlock] + blockIndex * _childrenPerBlock;
}

int _maxIndexInRow(int rowIndex) {
  final int blockIndex = rowIndex ~/ _rowsPerBlock;
  return const <int>[1, 3, 5, 6, 7][rowIndex % _rowsPerBlock] + blockIndex * _childrenPerBlock;
}

int _rowAtIndex(int index) {
  final int blockCount = index ~/ _childrenPerBlock;
  return const <int>[0, 0, 1, 1, 2, 2, 3, 4][index - blockCount * _childrenPerBlock] + blockCount * _rowsPerBlock;
}

int _columnAtIndex(int index) {
  return const <int>[0, 1, 0, 1, 0, 1, 0, 0][index % _childrenPerBlock];
}

int _columnSpanAtIndex(int index) {
  return const <int>[1, 1, 1, 1, 1, 1, 2, 2][index % _childrenPerBlock];
}

// The Shrine home page arranges the product cards into two columns. The card
// on every 4th and 5th row spans two columns.
class _ShrineGridLayout extends SliverGridLayout {
  const _ShrineGridLayout({
    @required this.rowStride,
    @required this.columnStride,
    @required this.tileHeight,
    @required this.tileWidth,
  });

  final double rowStride;
  final double columnStride;
  final double tileHeight;
  final double tileWidth;

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return _minIndexInRow(scrollOffset ~/ rowStride);
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    return _maxIndexInRow(scrollOffset ~/ rowStride);
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final int row = _rowAtIndex(index);
    final int column = _columnAtIndex(index);
    final int columnSpan = _columnSpanAtIndex(index);
    return new SliverGridGeometry(
      scrollOffset: row * rowStride,
      crossAxisOffset: column * columnStride,
      mainAxisExtent: tileHeight,
      crossAxisExtent: tileWidth + (columnSpan - 1) * columnStride,
    );
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0)
      return 0.0;
    final int rowCount = _rowAtIndex(childCount - 1) + 1;
    final double rowSpacing = rowStride - tileHeight;
    return rowStride * rowCount - rowSpacing;
  }
}

class _ShrineGridDelegate extends SliverGridDelegate {
  static const double _kSpacing = 8.0;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth = (constraints.crossAxisExtent - _kSpacing) / 2.0;
    const double tileHeight = 40.0 + 144.0 + 40.0;
    return new _ShrineGridLayout(
      tileWidth: tileWidth,
      tileHeight: tileHeight,
      rowStride: tileHeight + _kSpacing,
      columnStride: tileWidth + _kSpacing,
    );
  }

  @override
  bool shouldRelayout(covariant SliverGridDelegate oldDelegate) => false;
}

// Displays the Vendor's name and avatar.
class _VendorItem extends StatelessWidget {
  const _VendorItem({ Key key, @required this.vendor })
    : assert(vendor != null),
      super(key: key);

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: 24.0,
      child: new Row(
        children: <Widget>[
          new SizedBox(
            width: 24.0,
            child: new ClipRRect(
              borderRadius: new BorderRadius.circular(12.0),
              child: new Image.asset(
                vendor.avatarAsset,
                package: vendor.avatarAssetPackage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          new Expanded(
            child: new Text(vendor.name, style: ShrineTheme.of(context).vendorItemStyle),
          ),
        ],
      ),
    );
  }
}

// Displays the product's price. If the product is in the shopping cart then the
// background is highlighted.
abstract class _PriceItem extends StatelessWidget {
  const _PriceItem({ Key key, @required this.product })
      : assert(product != null),
        super(key: key);

  final Product product;

  Widget buildItem(BuildContext context, TextStyle style, EdgeInsets padding) {
    BoxDecoration decoration;
    if (_shoppingCart[product] != null)
      decoration = new BoxDecoration(color: ShrineTheme.of(context).priceHighlightColor);

    return new Container(
      padding: padding,
      decoration: decoration,
      child: new Text(product.priceString, style: style),
    );
  }
}

class _ProductPriceItem extends _PriceItem {
  const _ProductPriceItem({ Key key, Product product }) : super(key: key, product: product);

  @override
  Widget build(BuildContext context) {
    return buildItem(
      context,
      ShrineTheme.of(context).priceStyle,
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    );
  }
}

// A card that displays a product's image, price, and vendor. The _ProductItem
// cards appear in a grid below the heading.
class _ProductItem extends StatelessWidget {
  const _ProductItem({ Key key, @required this.product, this.onPressed })
    : assert(product != null),
      super(key: key);

  final Product product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new MergeSemantics(
      child: new Card(
        child: new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Align(
                  alignment: Alignment.centerRight,
                  child: new _ProductPriceItem(product: product),
                ),
                new Container(
                  width: 144.0,
                  height: 144.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: new Hero(
                      tag: product.tag,
                      child: new Image.asset(
                        product.imageAsset,
                        package: product.imageAssetPackage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: new _VendorItem(vendor: product.vendor),
                ),
              ],
            ),
            new Material(
              type: MaterialType.transparency,
              child: new InkWell(onTap: onPressed),
            ),
          ],
        ),
      ),
    );
  }
}

// The Shrine app's home page. Displays the featured item above a grid
// of the product items.
class ShrineHome extends StatefulWidget {
  @override
  _ShrineHomeState createState() => new _ShrineHomeState();
}

class _ShrineHomeState extends State<ShrineHome> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(debugLabel: 'Shrine Home');
  static final _ShrineGridDelegate gridDelegate = new _ShrineGridDelegate();

  Future<Null> _showOrderPage(Product product) async {
    final Order order = _shoppingCart[product] ?? new Order(product: product);
    final Order completedOrder = await Navigator.push(context, new ShrineOrderRoute(
      order: order,
      builder: (BuildContext context) {
        return new OrderPage(
          order: order,
          products: _products,
          shoppingCart: _shoppingCart,
        );
      }
    ));
    assert(completedOrder.product != null);
    if (completedOrder.quantity == 0)
      _shoppingCart.remove(completedOrder.product);
  }

  @override
  Widget build(BuildContext context) {
    return new ShrinePage(
      scaffoldKey: _scaffoldKey,
      products: _products,
      shoppingCart: _shoppingCart,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.all(16.0),
            sliver: new SliverGrid(
              gridDelegate: gridDelegate,
              delegate: new SliverChildListDelegate(
                _products.map((Product product) {
                  return new _ProductItem(
                    product: product,
                    onPressed: () { _showOrderPage(product); },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
