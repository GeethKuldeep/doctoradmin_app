import 'dart:async';

import 'package:doctoradmin_app/services/auth.dart';
import 'package:flutter/material.dart';

import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var color = const Color(0xffB5E4E9);
  var color1 = const Color(0xff51D5E3);
  var color2 = const Color(0xff03B0C7);
  var color3 = const Color(0xff1C6397);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LandingPage(auth: Auth()))));
    print('timer done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: color),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 11,
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              color1),
                        ),
                        width: 205,
                        height: 205,
                      ),
                      SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 8,
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              color2),
                        ),
                        width: 210,
                        height: 210,
                      ),
                      SizedBox(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                             color3),
                        ),
                        width: 215,
                        height: 215,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 100.0,
                        child: Image.asset('images/image 83.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
