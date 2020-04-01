import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapScreen extends StatefulWidget {
  final GlobalKey tapKey;
  final GlobalKey redeemKey;

  TapScreen({this.tapKey, this.redeemKey}) : super(key: tapKey);

  @override
  TapScreenState createState() => TapScreenState();
}

class TapScreenState extends State<TapScreen> {
  int score;
  Image down = Image.asset("assets/images/down.png");
  Image up = Image.asset("assets/images/up.png");
  Image current;

  @override
  void initState() {
    super.initState();
    current = down;
    score = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFED0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: 16.0,
              ),
              child: Text(
                'Score: $score',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: GestureDetector(
                onTap: _switchPicture,
                child: current,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(
                'Swipe up!',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          )
        ],
      ),
    );
  }

  void decreaseScore(int decrement) {
    setState(() {
      score -= decrement;
    });
  }

  void _switchPicture() {
    setState(() {
      score += 10;

      if (current == down) {
        current = up;
      } else {
        current = down;
      }
    });

    if (widget.redeemKey.currentState != null) {
      widget.redeemKey.currentState.setState(() {});
    }
  }
}
