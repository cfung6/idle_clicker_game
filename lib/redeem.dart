import 'package:counter/tap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Redeem extends StatefulWidget {
  final GlobalKey tapKey;
  final GlobalKey redeemKey;

  Redeem({this.tapKey, this.redeemKey}) : super(key: redeemKey);

  @override
  RedeemState createState() => RedeemState();
}

class RedeemState extends State<Redeem> {
  TapScreenState tapScreenState;
  bool isSnackBarShowing = false;

  @override
  void initState() {
    super.initState();
    tapScreenState = widget.tapKey.currentState;
  }

  @override
  void didUpdateWidget(Redeem old) {
    super.didUpdateWidget(old);
    tapScreenState = widget.tapKey.currentState;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              'Score: ${tapScreenState.score}',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        _buildOption('Placeholder', 50),
        _buildOption('Placeholder', 100),
        _buildOption('Placeholder', 500),
      ],
    );
  }

  Widget _buildOption(String name, int price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: RaisedButton(
              onPressed: () {
                _decrementScore(price);
              },
              child: Text(
                'Price: $price',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _decrementScore(int decrement) {
    setState(() {
      if (tapScreenState.score < decrement && !isSnackBarShowing) {
        isSnackBarShowing = true;
        Scaffold.of(context)
            .showSnackBar(SnackBar(
              content: Text(
                'Not enough Yuta points!',
              ),
              duration: Duration(seconds: 1),
            ))
            .closed
            .then((_) {
              //So SnackBar doesn't show up multiple times
          isSnackBarShowing = false;
        });
      } else if (tapScreenState.score >= decrement) {
        tapScreenState.decreaseScore(decrement);
      }
    });
  }
}
