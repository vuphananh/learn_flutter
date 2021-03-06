import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, our Widget takes in a title, and creates a _MyHomePageState.
class Rotation extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// The State class is responsible for two things: holding some data we can
// update and building the UI using that data.
class _MyHomePageState extends State<Rotation> with SingleTickerProviderStateMixin{
  // Whether the green box should be visible or invisible
  bool _isRotation = true;
  Animation<double> animation;
  AnimationController controller;


  @override
  void initState() {
    controller = new AnimationController(
      duration: Duration(milliseconds: (1000*timeDilation).toInt()),
      vsync: this,
    );
//    ..repeat()
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controller.stop();
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Rotation Animation"),
      ),
      body: new Center(
        child: new RotationTransition(
          turns: controller,
          // The green box needs to be the child of the AnimatedOpacity
          child: new Image.asset('assets/shrine/products/radio.png'),

        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          // Make sure we call setState! This will tell Flutter to rebuild the
          // UI with our changes!
          setState(() {
//            if (_isRotation) {
              controller.reset();
              controller.forward();
//            } else {
//              controller.stop();
//            }
//            if (_isRotation) {
//              controller.repeat();
//            } else {
//              controller.stop();
//            }
//            _isRotation = !_isRotation;
          });
        },
        tooltip: 'Toggle Opacity',
        child: new Icon(Icons.flip),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}