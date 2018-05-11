import 'package:flutter/material.dart';

class AnimList extends StatelessWidget {
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
            title: new Text('Staggered Animation'),
            onTap: () {
              onAnim(0);
            },
          ),
          new ListTile(
            title: new Text('Fade In Animation'),
            onTap: () {
              onAnim(1);
            },
          ),
          new ListTile(
            title: new Text('Fade Out Animation'),
            onTap: () {
              onAnim(2);
            },
          ),
          new ListTile(
            title: new Text('Rotation Animation'),
            onTap: () {
              onAnim(3);
            },
          ),
          new ListTile(
            title: new Text('ZoomIn Animation'),
            onTap: () {
              onAnim(4);
            },
          ),
          new ListTile(
            title: new Text('ZoomOut Animation'),
            onTap: () {
              onAnim(5);
            },
          ),
          new ListTile(
            title: new Text('Slide Animation'),
            onTap: () {
              onAnim(6);
            },
          )
        ],
      ),
    );
  }

  void onAnim(int i) {
    switch (i) {
      case 0:
        Navigator.of(mContext).pushNamed('/AnimStaggered');
        break;
      case 1:
        Navigator.of(mContext).pushNamed('/AnimFadeIn');
        break;
      case 2:
        Navigator.of(mContext).pushNamed('/AnimFadeOut');
        break;
      case 3:
        Navigator.of(mContext).pushNamed('/AnimRotation');
        break;
      case 4:
        Navigator.of(mContext).pushNamed('/AnimZoomIn');
        break;
      case 5:
        Navigator.of(mContext).pushNamed('/AnimZoomOut');
        break;
      case 6:
        Navigator.of(mContext).pushNamed('/AnimSlide');
        break;
    }
  }
}
