import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ScanInput extends StatefulWidget {
  final TextEditingController controller;

  const ScanInput({Key key, this.controller}) : super(key: key);

  @override
  _ScanInputState createState() => _ScanInputState();
}

class _ScanInputState extends State<ScanInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 18),
        child: TextField(
          controller: this.widget.controller,
          decoration: InputDecoration(
              labelText: "请输入",
              suffixIcon: ScanButton(
                controller: this.widget.controller,
              )),
        ));
  }
}

class ScanButton extends StatefulWidget {
  final TextEditingController controller;

  const ScanButton({Key key, this.controller}) : super(key: key);
  @override
  _ScanButtonState createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.crop_free),
      onPressed: scan,
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.widget.controller.text = barcode;
      });
    } on PlatformException catch (e) {
//      if (e.code == BarcodeScanner.CameraAccessDenied) {
//        setState(() {
//          this.widget.controller.text= 'The user did not grant the camera permission!';
//        });
//      } else {
//        setState(() {
//          this.widget.controller.text = 'Unknown error: $e';
//        });
//      }
    } on FormatException {
//      setState(() => this.widget.controller.text = 'null (User returned using the "back"-button before scanning anything. Result)');
//    } catch (e) {
//      setState(() => this.widget.controller.text = 'Unknown error: $e');
//    }
    }
  }
}
