import 'package:counter/redeem.dart';
import 'package:counter/tap.dart';
import 'package:flutter/material.dart';
import 'backdrop.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      home: BuiltBackDrop(),
    );
  }
}

class BuiltBackDrop extends StatefulWidget {
  @override
  BuiltBackDropState createState() => BuiltBackDropState();
}

class BuiltBackDropState extends State<BuiltBackDrop> {
  bool backdrop;
  final tapScreenKey = GlobalKey<TapScreenState>();
  final redeemKey = GlobalKey<RedeemState>();

  @override
  void initState() {
    super.initState();
    backdrop = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy < -5) {
          setState(() {
            backdrop = true;
          });
        }
      },
      child: backdrop ? _buildBackdrop() : _initialScreen(),
    );
  }

  Widget _initialScreen() {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 5.0,
        ),
        elevation: 0,
        backgroundColor: Color(0xFFFFFED0),
        title: Text(
          'Tap Yuta for points!',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: TapScreen(
        tapKey: tapScreenKey,
        redeemKey: redeemKey,
      ),
    );
  }

  Widget _buildBackdrop() {
    return Backdrop(
      backPanel: TapScreen(
        tapKey: tapScreenKey,
        redeemKey: redeemKey,
      ),
      backTitle: Text(
        'Tap Yuta for points!',
        style: Theme.of(context).textTheme.headline6,
      ),
      frontTitle: Text(
        'Redeem!',
        style: Theme.of(context).textTheme.headline6,
      ),
      frontPanel: Redeem(
        tapKey: tapScreenKey,
        redeemKey: redeemKey,
      ),
    );
  }
}
