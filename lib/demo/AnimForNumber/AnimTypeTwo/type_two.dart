import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:io';

// The StatefulWidget's job is to take in some data and create a State class.
// In this case, our Widget takes in a title, and creates a _MyHomePageState.
class NumberAnimTypeTwo extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

// The State class is responsible for two things: holding some data we can
// update and building the UI using that data.
class _MyHomePageState extends State<NumberAnimTypeTwo> with SingleTickerProviderStateMixin {
  // Whether the green box should be visible or invisible

  Animation<double> animation;
  AnimationController controller;

  var fontSize = 60.0;

  var startNumber = 10;
  var endNumber = 80;
  var currentNumber = 0;

  var timeDelay = 30;

  Timer timer;

  @override
  void initState() {
    super.initState();

    initAnim();

    runTimer();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Number Animation Type One"),
      ),
      body: new Center(
        child: new Text(
          currentNumber.toString(),
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: animation.value),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          runTimer();
        },
        tooltip: 'Toggle Opacity',
        child: new Icon(Icons.flip),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void runTimer() {
    currentNumber = startNumber;
    timer = new Timer.periodic(new Duration(milliseconds: timeDelay), (Timer timer) async {
      this.setState(() {
        currentNumber = currentNumber + 1;
        if (currentNumber >= endNumber) {
          timer.cancel();
          controller.reset();
          controller.fling();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    timer.cancel();
  }

  void initAnim() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = new Tween(begin: fontSize + 30, end: fontSize).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.fling();
  }
}