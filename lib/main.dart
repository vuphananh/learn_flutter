
import 'package:flutter/material.dart';

import 'package:learn_flutter_app/demo/shrine_demo.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() => runApp(
    new MaterialApp(title: 'Navigation Basics',
      home: new MyApp(),
      routes: <String, WidgetBuilder>{
        '/AnimHero': (BuildContext context) =>  new ShrineDemo(),
      }
    )
);

class MyApp extends StatefulWidget {
  @override
  ListTestState createState() => new ListTestState();
}

class ListTestState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    final title = 'Basic List';
    mContext = context;

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text('Open list'),
              onTap: () {
                onAnim(0);
              },
            ),
            new ListTile(
              title: new Text('Open slow motion'),
              onTap: () {
                onAnim(1);
              },
            ),
            new ListTile(
              title: new Text('Phone'),
              onTap: () {
                onAnim(2);
              },
            ),
            new ListTile(
              title: new Text('Phone'),
              onTap: () {
                onAnim(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isOpenSlowMotion = false;
  onAnim(int i) {
    switch (i) {
      case 0:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open Animation")
        ));
        Navigator.of(mContext).pushNamed('/AnimHero');
        break;
      case 1:
        String text = "";
        double duration = 0.0;
        if (isOpenSlowMotion) {
          duration = 1.0;
          text = "Off slowmotion";
        } else {
          duration = 10.0;
          text = "Open slowmotion 10.0";
        }
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text(text)
        ));
        setState(() {
            timeDilation = duration;
        });
        isOpenSlowMotion = !isOpenSlowMotion;
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