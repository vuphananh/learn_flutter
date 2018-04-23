// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'shrine_theme.dart';
import 'shrine_types.dart';

enum ShrineAction {
  sortByPrice,
  sortByProduct,
  emptyCart
}

class ShrinePage extends StatefulWidget {
  const ShrinePage({
    Key key,
    @required this.scaffoldKey,
    @required this.body,
    this.floatingActionButton,
    this.products,
    this.shoppingCart
  }) : assert(body != null),
       assert(scaffoldKey != null),
       super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget body;
  final Widget floatingActionButton;
  final List<Product> products;
  final Map<Product, Order> shoppingCart;

  @override
  ShrinePageState createState() => new ShrinePageState();
}

/// Defines the Scaffold, AppBar, etc that the demo pages have in common.
class ShrinePageState extends State<ShrinePage> {
  double _appBarElevation = 0.0;

  bool _handleScrollNotification(ScrollNotification notification) {
    final double elevation = notification.metrics.extentBefore <= 0.0 ? 0.0 : 1.0;
    if (elevation != _appBarElevation) {
      setState(() {
        _appBarElevation = elevation;
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: widget.scaffoldKey,
      body: new NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: widget.body
      )
    );
  }
}
