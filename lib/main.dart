import 'package:flutter/material.dart';

import 'package:learn_flutter_app/demo/shrine/shrine_home.dart';

void main() => runApp(
    new MaterialApp(title: 'Navigation Basics',
      home: new MyApp(),
//      routes: <String, WidgetBuilder>{
//        '/AnimHero': (BuildContext context) => new ShrineHome(),
//      }
    )
);
//void main() {
//  // Overriding https://github.com/flutter/flutter/issues/13736 for better
//  // visual effect at the cost of performance.
//  MaterialPageRoute.debugEnableFadingRoutes = true; // ignore: deprecated_member_use
//  runApp(new MyApp());
//}

class MyApp extends StatefulWidget {
  @override
  ListTestState createState() => new ListTestState();
}

class ListTestState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext mContext;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';
    mContext = context;

    return new MaterialApp(
      title: title,
      home: new ShrineHome()
//      new Scaffold(
//        key: _scaffoldKey,
//        appBar: new AppBar(
//          title: new Text(title),
//        ),
//        body: new ListView(
//          children: <Widget>[
//            new ListTile(
//              title: new Text('Hero Animations'),
//              onTap: () {
//                onAnim(0);
//              },
//            ),
//            new ListTile(
//              title: new Text('Album'),
//              onTap: () {
//                onAnim(1);
//              },
//            ),
//            new ListTile(
//              title: new Text('Phone'),
//              onTap: () {
//                onAnim(2);
//              },
//            ),
//            new ListTile(
//              title: new Text('Phone'),
//              onTap: () {
//                onAnim(3);
//              },
//            ),
//          ],
//        ),
//      ),
    );
  }

  onAnim(int i) {
    switch (i) {
      case 0:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open Hero Animations")
        ));
        Navigator.of(mContext).pushNamed('/AnimHero');
        break;
      case 1:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open snackbar 1")
        ));
        break;
      case 2:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open snackbar 2")
        ));
        break;
      case 3:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open snackbar 3")
        ));
        break;
    }
  }
}