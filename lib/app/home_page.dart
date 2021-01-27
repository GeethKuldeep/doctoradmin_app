import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:doctoradmin_app/app/graph1.dart';
import 'package:doctoradmin_app/app/graph2.dart';
import 'file:///C:/Users/anirudh/AndroidStudioProjects/doctoradmin_app/lib/app/graph3.dart';
import 'package:doctoradmin_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';


class HomePage extends StatefulWidget {
  HomePage({@required this.auth});
  final AuthBase auth;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  var color = const Color(0xffB5E4E9);
  GlobalKey _globalKey = GlobalKey();
  int number = 1;
  String name='';

  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _getusername() async {
    try {
      final _firebaseAuth = FirebaseAuth.instance;
      final user = await _firebaseAuth.currentUser();
      print("User Name : ${user.displayName}");
      name=user.displayName;
      print(name);
      setState(() {
        name=name;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState () {
    super.initState();
    _getusername();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                          onPressed: _signOut,
                          child: Icon(
                            Icons.logout,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 25,
                          child: Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('DR.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25)),
                            Text(name,style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),

                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Text('XX1234568IND',
                            style: TextStyle(color: Colors.teal, fontSize: 15))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Last active',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '1 day ago',
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Card(
                  //elevation: 500,
                  color: color,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              padding: const EdgeInsetsDirectional.only(
                                  end: 2.5, start: 0.075),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PopupMenuButton(
                                    itemBuilder: (_) =>
                                        <PopupMenuItem<String>>[],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text('Flexion'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.download_sharp,
                              size: 32,
                            ),
                            onPressed: () {
                               _saveScreen();
                               print('pressed');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          RepaintBoundary(
                            key:_globalKey,
                            child: SizedBox(
                              width: 5,
                            ),
                          ),
                          if (number == 1) Graph1(),
                          if (number == 2) Graph2(),
                          if (number == 3) Graph3(),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            child: Text('1D'),
                            onPressed: () {
                              setState(() {
                                number = 1;
                              });
                            },
                            splashColor: Colors.red,
                          ),
                          FlatButton(
                            child: Text('1W'),
                            onPressed: () {
                              setState(() {
                                number = 2;
                              });
                            },
                            splashColor: Colors.red,
                          ),
                          FlatButton(
                            child: Text('1M'),
                            onPressed: () {
                              setState(() {
                                number = 3;
                              });
                            },
                            splashColor: Colors.red,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.black,
                            size: 38,
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                            size: 38,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _saveScreen() async {
    RenderRepaintBoundary boundary =
  _globalKey.currentContext.findRenderObject();
    print("started");
   ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print("Ended");
    print(result);
    _toastInfo(result.toString());
  }
   _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
 }

}
