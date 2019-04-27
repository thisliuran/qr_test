import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ScanButton extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value) call_back;

  const ScanButton({Key key, this.controller, this.call_back}) : super(key: key);
  @override
  _ScanButtonState createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.center_focus_strong,color: Colors.lightBlue,),
      onPressed: scan,
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.widget.controller.text = barcode;
        if (this.widget.call_back != null) this.widget.call_back(barcode);
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
