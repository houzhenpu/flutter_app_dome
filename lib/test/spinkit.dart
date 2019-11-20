import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinkit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new SpinKitRotatingPlain(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitRotatingCircle(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitDoubleBounce(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitRing(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitWave(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitWanderingCubes(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitFadingCube(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitFadingFour(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitPulse(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitChasingDots(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitHourGlass(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          new SpinKitSpinningCircle(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitCircle(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitChasingDots(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitRipple(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitPumpingHeart(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitPouringHourglass(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitFoldingCube(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitFadingGrid(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitFadingCircle(
            color: Colors.blueAccent,
            size: 30.0,
          ),
          SpinKitDualRing(
            color: Colors.blueAccent,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
