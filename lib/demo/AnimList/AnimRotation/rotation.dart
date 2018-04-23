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
  bool _isRotation = false;
  AnimationController _animation;


  @override
  void initState() {
    _animation = new AnimationController(
      duration: Duration(milliseconds: (1000*timeDilation).toInt()),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Rotation Animation"),
      ),
      body: new Center(
        child: new RotationTransition(
          turns: _animation,
          // The green box needs to be the child of the AnimatedOpacity
          child: new Image.asset('assets/shrine/products/radio.png'),

        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          // Make sure we call setState! This will tell Flutter to rebuild the
          // UI with our changes!
          setState(() {
            if (_isRotation) {
              _animation.repeat();
            } else {
              _animation.stop();
            }
            _isRotation = !_isRotation;
          });
        },
        tooltip: 'Toggle Opacity',
        child: new Icon(Icons.flip),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}