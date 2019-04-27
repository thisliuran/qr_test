import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/Http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../style/theme.dart'  as theme;

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            //设置渐变的背景
            decoration: new BoxDecoration(
              gradient: theme.Theme.primaryGradient,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _login();
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    print('token:$token');
    dio.options.headers['token'] = token;
    //await prefs.setInt('counter', counter);

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
