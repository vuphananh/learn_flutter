import 'package:flutter/material.dart';

class AnimTransitionList extends StatelessWidget {
  BuildContext mContext;

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Animation List"),
        backgroundColor: new Color(0xFF26C6DA),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('Fade In Animation'),
            onTap: () {
              onAnim(0);
            },
          ),
          new ListTile(
            title: new Text('Rotation Animation'),
            onTap: () {
              onAnim(1);
            },
          ),
          new ListTile(
            title: new Text('Slide Animation'),
            onTap: () {
              onAnim(2);
            },
          ),
        ],
      ),
    );
  }

  void onAnim(int i) {
    switch (i) {
      case 0:
        Navigator.of(mContext).pushNamed('/AnimTransitionFadeIn');
        break;
      case 1:
        Navigator.of(mContext).pushNamed('/AnimTransitionRotation');
        break;
      case 2:
        Navigator.of(mContext).pushNamed('/AnimTransitionSlide');
        break;
    }
  }
}