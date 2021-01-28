import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {


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
  String newusername='';
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
      print("User Name1 : ${name}");
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
      final user = await _firebaseAuth.currentUser();
      url = user.photoUrl;
      uid = user.uid;
      newuid = uid.substring(1,8);
      print(url);
      print(uid);
      setState(() {
        url=url;
        newuid=newuid;
      });

    } catch (e) {
      print(e.toString());
    }
  }
  Future<void> _getcurrentuser() async {
    try {
      final _firebaseAuth = FirebaseAuth.instance;
      final user = await _firebaseAuth.currentUser();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState () {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getusername();
   _geturl();
    Firestore.instance.collection('users').getDocuments().then((val){
      print(val.documents.length);
      newusername = val.documents[0].data['username'];
    });
    print("User Name 3 : ${newusername}");

  }
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed)
      await Firestore.instance.collection('last online').document(newuid).setData({
        'updated': 15 ,
      });
    else
      await Firestore.instance.collection('last online').document(newuid).setData({
        'updated': 20 ,
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
                  padding: EdgeInsets.only(top: 15.0),
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
                        if(url.isNotEmpty)
                          CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30,
                          backgroundImage: NetworkImage(url),
                        ),
                        if(url == null)
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 30,
                            child: Icon(
                             Icons.person_rounded,
                              size: 45,
                              color: Colors.white,
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
                              if(name!=null)
                                Text(name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 25)),
                              if(name==null)
                                Text('Test Rat',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),


                              /*Conditional.single(
                              conditionBuilder: (BuildContext context) => name!=null ,
                              widgetBuilder: (BuildContext context) => Text(name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 25)),
                              fallbackBuilder: (BuildContext context) =>Text(newusername,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
                            ),*/

                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        if(newuid!=null)
                          Text(newuid,
                            style: TextStyle(color: Colors.teal, fontSize: 15)),
                        if(newuid == null)
                          Text('XX12345678IND',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (number == 1)


                                  Container(
                                    width: 325,
                                    height: 325,
                                    child: RepaintBoundary(
                                      key: _globalKey,
                                      child: charts.LineChart(
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
                                      child: charts.LineChart(
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
                                      child: charts.LineChart(
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
                                      child: charts.LineChart(
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
                          FlatButton(
                            onPressed:(){},
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                              size: 38,
                            ),

                          ),
                          SizedBox(
                            width: 35,
                          ),
                          FlatButton(
                            onPressed: (){

                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 38,
                            ),
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
