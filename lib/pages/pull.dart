import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_test/Http/http.dart';
import 'package:qr_test/pages/scan_button.dart';
import '../style/theme.dart' as theme;

class PullPage extends StatefulWidget {
  @override
  _PullPageState createState() => _PullPageState();
}

class _PullPageState extends State<PullPage> {
  bool is_hide = true;
  TextEditingController cell_id_controller = new TextEditingController();
  FocusNode cell_id_focusNode = new FocusNode();
  GlobalKey _net_type_key = GlobalKey();
  GlobalKey _factory_id_key = GlobalKey();

  TextEditingController spare_id_controller = new TextEditingController();
  TextEditingController spare_name_controller = new TextEditingController();
  TextEditingController spare_sub_name_controller = new TextEditingController();
  TextEditingController net_type_controller = new TextEditingController();
  TextEditingController factory_controller = new TextEditingController();
  String _cell_id_err = null;
  String _spare_id_err = null;
  String _spare_name_err = null;

  String _spare_sub_name_err = null;
  String _net_type_err = null;
  String _factory_err = null;

  get_cell(cell_id) async {
    Response response =
        await dio.get("/get_cell", queryParameters: {"cell_id": cell_id});
    print(response.data);
    setState(() {
      is_hide = "false" == response.data['result'];
      _cell_id_err = is_hide ? "没有这个存储单元" : null;
    });
  }

  List<String> net_types = ["SDH", "IPRAN", "DWDM", "IP", "接入网", "无线"];
  List<String> factories = ["华为", "中兴", "烽火", "阿朗", "瑞康", "其他"];
  int _num = 65530;
  int _input_value = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: new SingleChildScrollView(
              //padding: EdgeInsets.only(left: 0,right: 5,bottom: 5,top: 5),
              child: Container(
        //height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        child: Form(
          child: Column(
            children: <Widget>[
              new Container(
                height: 10,
                // color: Colors.grey[400],
                child: Center(),
              ),
              Offstage(
                offstage: false,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 20, top: 20, bottom: 0),
                  child: new TextField(
                    controller: cell_id_controller,
                    focusNode: cell_id_focusNode,
                    onEditingComplete: () {
                      get_cell(cell_id_controller.text);
                      cell_id_focusNode.unfocus();
                    },
                    onChanged: (v) {
                      if (!is_hide)
                        setState(() {
                          is_hide = true;
                        });
                    },
                    decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.business,
                        color: Colors.black,
                      ),
                      helperText: "存储单元ID，扫描货架二维码获取",
                      errorText: _cell_id_err,
                      suffixIcon: ScanButton(
                        controller: cell_id_controller,
                        call_back: (v) {
                          get_cell(v);
                        },
                      ),
                    ),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 20, top: 3, bottom: 0),
                  child: new TextFormField(
                    controller: spare_id_controller,
                    decoration: new InputDecoration(
                        suffixIcon: ScanButton(
                          controller: spare_id_controller,
                        ),
                        icon: new Icon(
                          Icons.developer_board,
                          color: Colors.black,
                        ),
                        helperText: "备件ID，扫描设备条码获取",
                        errorText: _spare_id_err),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 20, top: 3, bottom: 0),
                  child: new TextFormField(
                    controller: spare_name_controller,
                    decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.title,
                          color: Colors.black,
                        ),
                        helperText: "备件名称,例如：SL16",
                        errorText: _spare_name_err),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 20, top: 3, bottom: 0),
                  child: new TextFormField(
                    controller: spare_sub_name_controller,
                    decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.subject,
                          color: Colors.black,
                        ),
                        helperText: "备件描述,按需填写，例如：192.10",
                        errorText: _spare_sub_name_err),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 20, top: 3, bottom: 0),
                  child: new TextField(
                    enableInteractiveSelection: false,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    key: _net_type_key,
                    enabled: true,
                    controller: net_type_controller,
                    decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            RenderBox box =
                                _net_type_key.currentContext.findRenderObject();
                            Offset offset = box.localToGlobal(Offset.zero);
                            showMenu(
                              context: context,
                              position:
                                  RelativeRect.fromLTRB(1000, offset.dy, 25, 0),
                              items: net_types.map((item) {
                                return new PopupMenuItem(
                                    child: ListTile(
                                  title: Text(item),
                                  onTap: () {
                                    setState(() {
                                      net_type_controller.text = item;
                                    });
                                  },
                                ));
                              }).toList(),
                            );
                          },
                        ),
                        icon: new Icon(
                          Icons.developer_board,
                          color: Colors.black,
                        ),
                        helperText: "备件归属，请选择",
                        errorText: _net_type_err),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 20, top: 3, bottom: 0),
                  child: new TextField(
                    enableInteractiveSelection: false,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    key: _factory_id_key,
                    enabled: true,
                    controller: factory_controller,
                    decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            RenderBox box = _factory_id_key.currentContext
                                .findRenderObject();
                            Offset offset = box.localToGlobal(Offset.zero);
                            showMenu(
                              context: context,
                              position:
                                  RelativeRect.fromLTRB(1000, offset.dy, 25, 0),
                              items: factories.map((item) {
                                return new PopupMenuItem(
                                    child: ListTile(
                                  title: Text(item),
                                  onTap: () {
                                    setState(() {
                                      factory_controller.text = item;
                                    });
                                  },
                                ));
                              }).toList(),
                            );
                          },
                        ),
                        icon: new Icon(
                          Icons.developer_board,
                          color: Colors.black,
                        ),
                        helperText: "备件厂家，请选择",
                        errorText: _factory_err),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 20, top: 3, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Radio(
                        groupValue: _num,
                        value: 1,
                        onChanged: (v) {
                          setState(() {
                            _num = v;
                          });
                        },
                      ),
                      Text("最前"),
                      Radio(
                        groupValue: _num,
                        value: _input_value,
                        onChanged: (v) {
                          if (_input_value > 1 && _input_value < 1000) {
                            setState(() {
                              _num = v;
                            });
                          }
                        },
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("第"),
                            SizedBox(
                              width: 30,
                              height: 18,
                              child: Center(
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0.0),
                                    // border: InputBorder.none
                                  ),
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  onChanged: (v) {
                                    setState(() {
                                      _input_value =
                                          v != "" ? int.parse(v) : -1;
                                      if (_input_value > 0) {
                                        _num = _input_value;
                                      } else
                                        _num = 65530;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Text("个")
                          ],
                        ),
                      ),
                      Radio(
                        groupValue: _num,
                        value: 65530,
                        onChanged: (v) {
                          setState(() {
                            _num = v;
                          });
                        },
                      ),
                      Text("最后"),
                    ],
                  ),
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: new Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  height: 1,
                  //width: 250,
                  color: Colors.grey[400],
                ),
              ),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: RaisedButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    child: Center(
                      child: const Text(
                        '立即入库',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    onPressed: () {
                      var data = {
                        "cell_id": cell_id_controller.text,
                        "spare_id": spare_id_controller.text,
                        "name": spare_name_controller.text,
                        "sub_name": spare_sub_name_controller.text,
                        "net_type": net_type_controller.text,
                        "factory": factory_controller.text,
                        "num": _num
                      };
                      print(data);
                      setState(() {
                        _cell_id_err = null;
                        _spare_id_err = null;
                        _spare_name_err = null;
                        _spare_sub_name_err = null;
                        _net_type_err = null;
                        _factory_err = null;
                      });

                      dio
                          .post("/pull", data: new FormData.from(data))
                          .then((r) {
                        if (r.data['result'] == 'success') {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text("入库成功！")));
                          spare_id_controller.text = "";
                          spare_name_controller.text = "";
                          spare_sub_name_controller.text = "";
                          net_type_controller.text = "";
                          factory_controller.text = "";

                          setState(() {
                            _cell_id_err = null;
                            _spare_id_err = null;
                            _spare_name_err = null;
                            _spare_sub_name_err = null;
                            _net_type_err = null;
                            _factory_err = null;
                          });
                        } else {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text(r.data.toString())));
                         setState(() {
                           _cell_id_err = r.data['cell_id'];
                           _spare_id_err = r.data['spare_id'];
                           _spare_name_err = r.data['name'];
                           _spare_sub_name_err = r.data['sub_name'];
                           _net_type_err = r.data['net_type'];
                           _factory_err = r.data['factory'];
                         });
                        }
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 0,),
              Offstage(
                offstage: is_hide,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
                  child: OutlineButton(
                    color: Colors.red,
                    textColor: Colors.black54,
                    splashColor: Colors.blueGrey,
                    child: Center(
                      child: const Text(
                        '表单重置',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    onPressed: () {

                      setState(() {
                        _cell_id_err = null;
                        _spare_id_err = null;
                        _spare_name_err = null;
                        _spare_sub_name_err = null;
                        _net_type_err = null;
                        _factory_err = null;
                        spare_id_controller.text = "";
                        spare_name_controller.text = "";
                        spare_sub_name_controller.text = "";
                        net_type_controller.text = "";
                        factory_controller.text = "";
                      });
                    },
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10, top: 20),
                // color: Colors.grey[400],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "  入库操作说明：",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "1.扫描存储单元二维码，输入存储单元ID。",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "2.扫描待入库备件条形码，输入备件ID。",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "3.填写或修改备件相关属性。",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "4.选择入库位置，建议在存储单元最后(前)。",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
