import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/Http/http.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("LOADING,正在连接服务器"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _login();
  }

  void _login() async {
    Response response = await dio.get("/login");
    print("StatusCode:${response.statusCode}");
    if (response.statusCode == 404 || response.statusCode == 500) {
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text("服务器无法连接")));
    }
      print(response.data['result'].toString());
    if (response.data['result'] != "success") {
      Navigator.of(context).pushReplacementNamed("/login");
    } else {
      Navigator.of(context).pushReplacementNamed("/index");
    }
  }
}
