import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:doctoradmin_app/app/graph1.dart';
import 'package:doctoradmin_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screenshot/screenshot.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class HomePage extends StatefulWidget {
  HomePage({@required this.auth});
  final AuthBase auth;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  File _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  //int _selectedIndex = 0;
  ///List<Widget> pages = <Widget>[
   /// Graph(),
   // Graph(),
   // Graph(),

 /// ];

  ///void navigate(index) async {
   /// setState(() {
    ///  _selectedIndex = index;
    ///});
  //}

  GlobalKey _globalKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.indigo,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                  Expanded(
                  flex:2,
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircleAvatar(
                              radius: 50,
                              child: Icon(
                                Icons.person_rounded,
                                size: 75,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('DR.T.Geethkuldeep',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                              SizedBox(height: 10,),
                              Text('XX1234568IND',style: TextStyle(color: Colors.grey,fontSize: 15))
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Last active'),
                              SizedBox(width: 5,),
                              Text('1 day ago',style: TextStyle(color: Colors.indigo),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                Expanded(
                  flex:3,
                  child: Card(

                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 25,),
                            Row(
                              children: [

                              RepaintBoundary(
                                  key: _globalKey,
                                  child: Graph()
                              )

                              ],
                            ),
                          ],
                        ),
                        FloatingActionButton(
                          child: Icon(
                            Icons.download_sharp
                          ),
                          onPressed: (){
                            _saveScreen();
                          },
                        )
                      ],
                    ),
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                      children: [
                        SizedBox(width: 120,),
                        Row(

                          children: [

                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 35,
                                ),

                            SizedBox(width: 35,),
                            Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 35,
                                ),

                          ],
                        ),
                        SizedBox(width: 10,),

                        FlatButton(
                            child: Row(
                              children: [
                                Text('Back',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                                Row(

                                  children: [
                                    Icon(
                                      Icons.subdirectory_arrow_left_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    )

                                  ],
                                )
                              ],
                            ),
                            onPressed: _signOut,
                          ),
                      ],
                    ),
                 ),

              ],
            )
          ],
        ),
      ),
      //bottomNavigationBar: BottomNavigationBar(
       /// type: BottomNavigationBarType.shifting,
        ///items: <BottomNavigationBarItem>[
        ///  BottomNavigationBarItem(
         //   icon: Icon(
         //     Icons.linear_scale
          //  ),
         //   label: '1D',
         //     backgroundColor: Colors.black
         // ),
        // BottomNavigationBarItem(
          ///  icon: Icon(
         ///       Icons.linear_scale
        ///    ),
        ///    label:
      //        '1W',
       ///       backgroundColor: Colors.black
      ///    ),
      ///    BottomNavigationBarItem(
     ///       icon: Icon(
    ///            Icons.linear_scale
      ///      ),
      ///      label:
     ///         '1M',
     ///       backgroundColor: Colors.black
     ///       ),
    ///    ],
     ///   currentIndex: _selectedIndex,
      //  onTap: navigate,
     // ),
    );
  }


  _saveScreen() async {
    RenderRepaintBoundary boundary =
    _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    print(result);
    _toastInfo(result.toString());
  }
  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }


}

