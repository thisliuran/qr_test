import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:qr_test/Http/http.dart';
import 'package:qr_test/pages/index.dart';
import 'package:qr_test/pages/loading.dart';
import 'package:qr_test/pages/login.dart';
import 'package:qr_test/pages/scan_input.dart';

void main() {
  dio.options.baseUrl = 'http://150.138.91.12:10007/api';
  dio.options.headers['token'] = "eyJpY29uX2lkIjoxLCJuYW1lIjoi5YiY5YaJIiwicGhvbmUiOjE4OTA2Mzc0Mjg3LCJyb2xlX2lkIjoxLCJ1c2VyX2lkIjoxfQ==:KiTnpJI377-9Bl5ccemkvDMhMzU=:X--_vQZ75aaMYuWlt-aUvuiznOiCju-_vQ==";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Index(),
      theme:  ThemeData.light(),
      routes: {
        "/login":(context){return new LoginPage();},
        "/index":(context){return new Index();},
      },
    );
  }
}


class scanqr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: sacnBody(),

    );
  }
}

class sacnBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyScanState();
  }
}

class _MyScanState extends State<sacnBody> {
  String barcode = "";
  TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text('QR Code'),
      ),
      body: new Center(
        child: ScanInput(controller:textEditingController),
//        child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
//              child: RaisedButton(
//                  color: Colors.orange,
//                  textColor: Colors.white,
//                  splashColor: Colors.blueGrey,
//                  onPressed: scan,
//                  child: const Text('START CAMERA SCAN')
//
//              ),
//            ),
//            Padding (
//              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//              child: Text(barcode, textAlign: TextAlign.center,),
//            )
//          ],
//        ),
      ),
    );
  }


  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
         this.barcode = barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          return this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          return this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }


}
final ThemeData mDefaultTheme = new ThemeData(
  primaryColor: Color(0xff303030),
  scaffoldBackgroundColor: Color(0xFFebebeb),
  cardColor: Color(0xff393a3f),
);