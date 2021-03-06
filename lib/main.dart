
import 'package:flutter/material.dart';

import 'package:learn_flutter_app/demo/AnimViewProducts/shrine/shrine_demo.dart';
import 'package:learn_flutter_app/demo/AnimList/anim_list.dart';
import 'package:learn_flutter_app/demo/AnimList/AnimFadeIn/fade_in.dart';
import 'package:learn_flutter_app/demo/AnimList/AnimFadeOut/fade_out.dart';
import 'package:learn_flutter_app/demo/AnimList/AnimStaggered/staggered.dart';
import 'package:learn_flutter_app/demo/AnimList/AnimRotation/rotation.dart';
import 'package:learn_flutter_app/demo/AnimList/AnimZoomIn/zoom_in.dart';
import 'package:learn_flutter_app/demo/AnimList/AnimZoomOut/zoom_out.dart';
import 'package:learn_flutter_app/demo/AnimList/AnimSlide/slide.dart';

import 'package:learn_flutter_app/demo/AnimForNumber/AnimTypeOne/type_one.dart';
import 'package:learn_flutter_app/demo/AnimForNumber/AnimTypeTwo/type_two.dart';
import 'package:learn_flutter_app/demo/AnimForNumber/anim_list.dart';

import 'package:learn_flutter_app/demo/AnimTransition/anim_transition_list.dart';

import 'package:flutter/scheduler.dart' show timeDilation;


class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.isInitialRoute)
      return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    switch (settings.name) {
      case '/AnimTransitionFadeIn':
        return new FadeTransition(opacity: animation, child: child);
      case '/AnimTransitionRotation':
        return new RotationTransition(turns: animation, child: child);
      case '/AnimTransitionSlide':
        Animation<Offset> animPos = new Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);
        return new SlideTransition(position: animPos, child: child);
    }
  }
}

void main() => runApp(
    new MaterialApp(
        title: 'Navigation Basics',
        home: new MyApp(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/AnimTransitionFadeIn':return new MyCustomRoute(
              builder: (_) => new FadeIn(),
              settings: settings,
            );
            case '/AnimTransitionRotation': return new MyCustomRoute(
              builder: (_) => new Rotation(),
              settings: settings,
            );
            case '/AnimTransitionSlide': return new MyCustomRoute(
              builder: (_) => new Slide(),
              settings: settings,
            );
          }
        },
        routes: <String, WidgetBuilder>{
          '/AnimViewProducts': (BuildContext context) => new ShrineDemo(),

          '/AnimList': (BuildContext context) =>  new AnimList(),

          '/AnimStaggered': (BuildContext context) =>  new Staggered(),
          '/AnimFadeIn': (BuildContext context) =>  new FadeIn(),
          '/AnimFadeOut': (BuildContext context) =>  new FadeOut(),
          '/AnimRotation': (BuildContext context) =>  new Rotation(),
          '/AnimZoomIn': (BuildContext context) =>  new ZoomIn(),
          '/AnimZoomOut': (BuildContext context) =>  new ZoomOut(),
          '/AnimSlide': (BuildContext context) =>  new Slide(),

          '/AnimNumberList': (BuildContext context) =>  new AnimNumberList(),
          '/AnimNumberTypeOne': (BuildContext context) =>  new NumberAnimTypeOne(),
          '/AnimNumberTypeTwo': (BuildContext context) =>  new NumberAnimTypeTwo(),

          '/AnimTransition': (BuildContext context) => new AnimTransitionList(),
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
                onTap(0);
              },
            ),
            new ListTile(
              title: new Text('Open slow motion'),
              onTap: () {
                onTap(1);
              },
            ),
            new ListTile(
              title: new Text('Open animations'),
              onTap: () {
                onTap(2);
              },
            ),
            new ListTile(
              title: new Text('Open animations with transition'),
              onTap: () {
                onTap(3);
              },
            ),
            new ListTile(
              title: new Text('Open animations for number'),
              onTap: () {
                onTap(4);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool isOpenSlowMotion = false;
  onTap(int i) {
    switch (i) {
      case 0:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open AnimViewProducts")
        ));
        Navigator.of(mContext).pushNamed('/AnimViewProducts');
        break;
      case 1:
        String text = "";
        double duration = 0.0;
        if (isOpenSlowMotion) {
          duration = 1.0;
          text = "Off slowmotion";
        } else {
          duration = 5.0;
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
            content: new Text("Open Anim List")
        ));
        Navigator.of(mContext).pushNamed('/AnimList');
        break;
      case 3:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open Animations transition")
        ));
        Navigator.of(mContext).pushNamed('/AnimTransition');
        break;
      case 4:
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
            content: new Text("Open Animations for number")
        ));
        Navigator.of(mContext).pushNamed('/AnimNumberList');
        break;
    }
  }
}