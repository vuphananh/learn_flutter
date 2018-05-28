import 'package:flutter/material.dart';

class AnimNumberList extends StatelessWidget {
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
            title: new Text('Type one'),
            onTap: () {
              onAnim(0);
            },
          ),
          new ListTile(
            title: new Text('Type two'),
            onTap: () {
              onAnim(1);
            },
          )
        ],
      ),
    );
  }

  void onAnim(int i) {
    switch (i) {
      case 0:
        Navigator.of(mContext).pushNamed('/AnimNumberTypeOne');
        break;
      case 1:
        Navigator.of(mContext).pushNamed('/AnimNumberTypeTwo');
        break;
    }
  }
}
