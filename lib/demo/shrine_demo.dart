// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:learn_flutter_app/demo/shrine/shrine_home.dart' show ShrineHome;
import 'package:learn_flutter_app/demo/shrine/shrine_theme.dart' show ShrineTheme;

// This code would ordinarily be part of the MaterialApp's home. It's being
// used by the ShrineDemo and by each route pushed from there because this
// isn't a standalone app with its own main() and MaterialApp.
Widget buildShrine(BuildContext context, Widget child) {
  return new Theme(
    data: new ThemeData(
      primarySwatch: Colors.grey,
      iconTheme: const IconThemeData(color: const Color(0xFF707070)),
      platform: Theme.of(context).platform,
    ),
    child: new ShrineTheme(child: child)
  );
}

// In a standalone version of this app, MaterialPageRoute<T> could be used directly.
class ShrinePageRoute<T> extends MaterialPageRoute<T> {
  ShrinePageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return buildShrine(context, super.buildPage(context, animation, secondaryAnimation));
  }
}
