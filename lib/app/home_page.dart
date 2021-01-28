import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:charts_flutter/flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DataManipulation.dart';
import 'package:doctoradmin_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:save_in_gallery/save_in_gallery.dart';
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
  final _imageSaver = ImageSaver();
  int number = 1;
  String name='';
  String id='';
  String online='';
  String time='';
  String value='';
  int i=0;
  var timelst = new List();
  String url ='';
String uid ='';
String newuid='';

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
  Future<void> _geturl() async {
    try {
      final _firebaseAuth = FirebaseAuth.instance;
      final googleSignIn = GoogleSignIn();
      final googleAccount = await googleSignIn.signIn();
      final googleAuth = await googleAccount.authentication;
      final authResult = await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ),
      );
      url = authResult.user.photoUrl;
      uid =authResult.user.uid;
      newuid = uid.substring(1,8);
      setState(() {
        url=url;
        newuid=newuid;
      });

    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState () {
    super.initState();
    _getusername();
    _geturl();
    Firestore.instance.collection('data').getDocuments().then((val){
        id = val.documents[0].data["id"];
        online = val.documents[0].data["last active"];
       time = val.documents[0].data["time"];
       value = val.documents[0].data["val"];
       print(id);
       print(online);
       print(time);
       print(value);
       var time1 = json.decode(time);
       print(time1);
       var val1 = json.decode(value);
       print(val1);
        List<String> result = online.split('-');
        print(result[2]);

      //var lastonline = json.decode(online);
        //print(lastonline);




    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: ListView(
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
                          radius: 30,
                          backgroundImage: NetworkImage(url),
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
                        Text(newuid,
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
                  elevation: 10,
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
                                        <PopupMenuItem<String>>[
                                          new PopupMenuItem<String>(
                                              child: const Text('Iam selected'), value: 'Iam not'),
                                          new PopupMenuItem<String>(
                                              child: const Text('Iam not'), value: 'Iam selected'),
                                        ],
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
                              _capturePng;
                               print('pressed');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              if (number == 1)


                                  Container(
                                    width: 325,
                                    height: 325,
                                    child: RepaintBoundary(
                                      key: _globalKey,
                                      child: LineChart(
                                        DataToGraph().getSeriesData(
                                            DataToGraph().manageData(1)),
                                        animate: true,
                                      ),
                                    ),
                                  ),

                              if (number == 2)
                               Container(
                                    width: 325,
                                    height: 325,
                                    child: RepaintBoundary(
                                      key: _globalKey,
                                      child: LineChart(
                                        DataToGraph().getSeriesData(
                                            DataToGraph().manageData(2)),
                                        animate: true,
                                      ),
                                    ),
                                  ),

                              if (number == 3)
                                Container(
                                    width: 325,
                                    height: 325,
                                    child: RepaintBoundary(
                                      key: _globalKey,
                                      child: LineChart(
                                        DataToGraph().getSeriesData(
                                            DataToGraph().manageData(3)),
                                        animate: true,
                                      ),
                                    ),
                                  ),
                              if (number == 4)
                                 Container(
                                    width: 325,
                                    height: 325,
                                    child: RepaintBoundary(
                                      key: _globalKey,
                                      child: LineChart(
                                        DataToGraph().getSeriesData(
                                            DataToGraph().manageData(4)),
                                        animate: true,
                                      ),
                                    ),
                                  ),

                            ],
                          ),
                        ),

                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 55,
                            height: 55,
                            child: FlatButton(
                              child: Text('1D'),
                              onPressed: () {
                                setState(() {
                                  number = 1;
                                });
                              },
                              splashColor: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            height: 55,
                            child: FlatButton(
                              child: Text('1W'),
                              onPressed: () {
                                setState(() {
                                  number = 2;
                                });
                              },
                              splashColor: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 55,
                            height: 55,
                            child: FlatButton(
                              child: Text('1M'),
                              onPressed: () {
                                setState(() {
                                  number = 3;
                                });
                              },
                              splashColor: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 65,
                            height: 55,
                            child: FlatButton(
                              child: Text('Max'),
                              onPressed: () {
                                setState(() {
                                  number = 4;
                                });
                              },
                              splashColor: Colors.red,
                            ),
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
  Future<void> _capturePng(GlobalKey _globalKey) async {
    try {
      RenderRepaintBoundary boundary =
      _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      setState(() {});
      List<Uint8List> bytesList = [];
      bytesList.add(byteData.buffer.asUint8List());
      print(bytesList);
      _imageSaver.saveImages(imageBytes: bytesList);
    } catch (e) {
      print(e);
    }
  }

}
