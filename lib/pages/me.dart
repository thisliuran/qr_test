import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:qr_test/Http/http.dart';
import 'package:qr_test/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Future initState() {
    super.initState();
    dio.get("/me").then((v) {
      setState(() {
        _cur_user = v.data;
      });
    });
  }

  var _cur_user = new Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  " ${_cur_user['name']}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                accountEmail: Text(
                  " ${_cur_user['phone']}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/user.jpeg'),
                ),
                decoration: BoxDecoration(
                    // 设置背景图片
                    image: DecorationImage(
                        // 控制图片填充效果
                        fit: BoxFit.fill,
                        // 指定图片地址
                        image: AssetImage('assets/user_bg.jpg'))),
              ),
               SizedBox(height: 200,),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  color: Colors.white,
                  height: 40,
                  child: Center(
                    child: Text(
                      "切换账号",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return new Scaffold(
                      appBar: AppBar(
                        backgroundColor: const Color(0xFFfbab66),
                        iconTheme: IconThemeData(color: Colors.white),
                        bottomOpacity: 100,
                        
                      ),
                      body: LoginPage(),
                    );
                  }));
                },
              ),    GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  color: Colors.white,
                  height: 40,
                  child: Center(
                    child: Text(
                      "修改密码",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  color: Colors.white,
                  height: 40,
                  child: Center(
                    child: Text(
                      "退出登录",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                onTap: (){
                  dio.options.headers['token'] = "";
                  SharedPreferences.getInstance().then((sp){
                    sp.setString("token", "");
                  });
                  Navigator.pushReplacementNamed(context, "/login");
                },
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}
