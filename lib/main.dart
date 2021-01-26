
import 'package:doctoradmin_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/Splash_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var color1 = const Color(0xffFBD00D);
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context)=> Auth(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
          errorColor: color1,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Equinox2021',
        home: SplashScreen(),
      ),
    );
  }
}