import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, our Widget takes in a title, and creates a _MyHomePageState.
class Slide extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// The State class is responsible for two things: holding some data we can
// update and building the UI using that data.
class _MyHomePageState extends State<Slide> with SingleTickerProviderStateMixin{
  // Whether the green box should be visible or invisible

  // Whether the green box should be visible or invisible
  Animation<Offset> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = new Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Slide Animation"),
      ),
      body: new Center(
          child: new SlideTransition(
            position: animation,
            child: new Image.asset('assets/shrine/products/radio.png'),
          )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          // Make sure we call setState! This will tell Flutter to rebuild the
          // UI with our changes!
          setState(() {
              controller.reset();
              controller.forward();
          });
        },
        tooltip: 'Toggle Opacity',
        child: new Icon(Icons.flip),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}