import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/Http/http.dart';
import 'package:qr_test/pages/scan_button.dart';
import 'package:qr_test/pages/spare_item.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List _list = [];
  TextEditingController _controller = new TextEditingController();
  FocusNode _focusNode = new FocusNode();
  FocusScopeNode _focusScopeNode;



  @override
  void initState() {
     _search("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 60, right: 20),
            child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context,i){
                  return SpareItem(_list[i]);
                }),
          )
          ,
          Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 40,

                // maxWidth: 200
              ),
              child: TextField(

                controller: _controller,
                focusNode: _focusNode,
//              autofocus: true,
                style: TextStyle(

                  color: Colors.black,
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                    hintText: "搜索，多个条件请用空格分开",
                    suffix: ScanButton(
                      controller: _controller,
                      call_back: (value){
                        _search(_controller.text);
                      },
                    )
                ),
                onEditingComplete: (){
                  _focusNode.unfocus();


                  _search(_controller.text);
                },
              ),
            ),
          )
        ],
      ),
    ));
  }


  _search(String key_word) async {
    print("-------");
    Response res =
        await dio.get("/search", queryParameters: {"key_word": key_word});
    setState(() {
      _list =  res.data.map((x)=>x).toList();

    });
  }


}

