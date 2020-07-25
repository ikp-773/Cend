import 'dart:math' show Random, pi;
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import '../user.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        getPrefsAndPushHome();
      }
    });
    animationController.forward();
  }

  void getPrefsAndPushHome() async {
    var pref = await Prefs.getPrefs();
    getP<User>().nickName = pref.getString(Prefs.nickName) ??
        "User_" + Random().nextInt(1000).toString();
    Navigator.of(context).pushReplacementNamed(Router.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CircularRevealAnimation(
        animation: animation,
        centerAlignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            gradient: SweepGradient(
              startAngle: 0,
              endAngle: 2 * pi,
              transform: GradientRotation(-pi / 5),
              colors: <Color>[
                Colors.black,
                Colors.black,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/splashScreen/cendLogo.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
