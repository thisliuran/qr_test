import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/Http/http.dart';
import 'package:qr_test/pages/row_item.dart';
import 'package:qr_test/pages/scan_button.dart';
import 'package:qr_test/pages/spare_item.dart';

class OutPage extends StatefulWidget {
  @override
  _OutPageState createState() => _OutPageState();
}

class _OutPageState extends State<OutPage> {
  
  TextEditingController spare_id_controller = new TextEditingController();
  String _spare_id_err = null;
  bool is_hide = true;
  Map spare = new Map();
  //FocusScopeNode focusScopeNode = new FocusScopeNode();

  get_one(spare_id) async{
    FocusScope.of(context).detach();
    Response r = await dio.get("/get_one",queryParameters: {"spare_id":spare_id});
    print(r.data);
    if(r != null && r.data !=null && r.data != ""&& r.data['cell_id']!=null&&r.data['cell_id']!=""){
      setState(() {
        is_hide = false;
        spare = r.data;
        _spare_id_err = null;
      });
    }else {
      setState(() {
        _spare_id_err = "该备件还未入库";
        is_hide = true;
      });

    }
  }


  out(){
    FormData formData = FormData.from({"spare_id":spare_id_controller.text});
   dio.post("/push",data: formData).then((v){
     print(v.data);
     if(v!=null&& v.data !=null && v.data !="" && v.data['result']== "success"){
       Scaffold.of(context).showSnackBar(SnackBar(content: Text("出库成功！")));
setState(() {
  is_hide = true;
  spare = new Map();
  spare_id_controller.text="";
  _spare_id_err = null;
});
     }
     else
       Scaffold.of(context).showSnackBar(SnackBar(content: Text("出库失败！")));

   });




  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Offstage(
            offstage: is_hide,
            child: SpareItem(spare
            ),
          ),
          RowItem(
            title: "编码",
//                          padding: const EdgeInsets.only(
//                              left: 10, right: 20, top: 3, bottom: 0),
            child: new TextFormField(
              controller: spare_id_controller,
              decoration: new InputDecoration(
                  suffixIcon: ScanButton(
                    controller: spare_id_controller,
                    call_back:  (v){
                      get_one(v);
                    },
                  ),
//                                icon: new Icon(
//                                  Icons.developer_board,
//                                  color: Colors.black,
//                                ),
                  helperText: "备件ID，扫描设备条码获取",
                  errorText: _spare_id_err),
              onEditingComplete: (){
                get_one(spare_id_controller.text);
              },
              style: new TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 15.0, vertical:20.0),
            child: RaisedButton(

                color: Colors.teal,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                child: Center(
                  child: const Text(
                    '立即出库',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                onPressed: is_hide?null:(){
                  out();
                }
            ),

          )
        ],
      )),
    );
  }
}
