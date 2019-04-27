import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/Http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_test/pages/in.dart';
import 'package:qr_test/pages/login.dart';
import 'package:qr_test/pages/me.dart';
import 'package:qr_test/pages/pull.dart';
import 'out.dart';
import 'package:qr_test/pages/search.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _cur_index = 0;
  List<Widget> _widgets = [
    Search(),
    InPage(),
    //LoginPage(),
    OutPage(),
    Me()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(

            child: IndexedStack(
              index: _cur_index,
              children: _widgets,
            ),

          onPanEnd: (DragEndDetails e) {
            var dx = e.velocity.pixelsPerSecond.dx;
           if(dx > 300 && _cur_index > 0){
             setState(() {
               _cur_index--;
             });
           }else if(dx < -300 && _cur_index < _widgets.length-1){
             setState(() {
               _cur_index++;
             });
           }


          }),
      drawer: Drawer(
        child: Padding(padding: EdgeInsets.all(0),
        child: ListView(
          children: <Widget>[

            ListTile(title: Text("111"),),
            ListTile(title: Text("222"),),
            ListTile(title: Text("333"),),
            ListTile(title: Text("444"),),

          ],
        ),
        )
      )
      ,
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  size: 32,
                  color:
                      _cur_index == 0 ? Color(0xFF46c01b) : Color(0xff999999)),
              title: Text(
                "查找",
                style: TextStyle(
                    color: _cur_index == 0
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              )),
          new BottomNavigationBarItem(
              icon: Icon(Icons.file_download,
                  size: 32,
                  color:
                      _cur_index == 1 ? Color(0xFF46c01b) : Color(0xff999999)),
              title: Text(
                "入库",
                style: TextStyle(
                    color: _cur_index == 1
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              )),
          new BottomNavigationBarItem(
              icon: Icon(Icons.file_upload,
                  size: 32,
                  color:
                      _cur_index == 2 ? Color(0xFF46c01b) : Color(0xff999999)),
              title: Text(
                "出库",
                style: TextStyle(
                    color: _cur_index == 2
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              )),
          new BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity,
                  size: 32,
                  color:
                      _cur_index == 3 ? Color(0xFF46c01b) : Color(0xff999999)),
              title: Text(
                "我",
                style: TextStyle(
                    color: _cur_index == 3
                        ? Color(0xFF46c01b)
                        : Color(0xff999999)),
              )),
        ],
        onTap: (i) {
          setState(() {
            _cur_index = i;
          });
        },
        currentIndex: _cur_index,
      ),
    );
  }

  Widget _curPage() {
    switch (_cur_index) {
      case 0:
        return _widgets[0];
    }
    return new Center(
      child: Text("OTHER"),
    );
  }
}
