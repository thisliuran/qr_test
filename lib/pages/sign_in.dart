import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_test/Http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../style/theme.dart' as theme;

/**
 *注册界面
 */
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  /**
   * 利用FocusNode和FocusScopeNode来控制焦点
   * 可以通过FocusNode.of(context)来获取widget树中默认的FocusScopeNode
   */
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusScopeNode focusScopeNode = new FocusScopeNode();

  String _phone;
  String _pass;

  GlobalKey<FormState> _SignInFormKey = new GlobalKey();

  bool isShowPassWord = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 23),
      child: new Stack(
        alignment: Alignment.center,
//        /**
//         * 注意这里要设置溢出如何处理，设置为visible的话，可以看到孩子，
//         * 设置为clip的话，若溢出会进行裁剪
//         */
        overflow: Overflow.visible,
        children: <Widget>[
          new Column(
            children: <Widget>[
              //创建表单
              buildSignInTextForm(),
                            Padding(padding: EdgeInsets.only(top: 60),
                child: new Row(
//                          mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(height: 1,
                      width: 100,
                      decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [ Colors.white10,
                              Colors.white,
                              ])
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: new Text("Or", style: new TextStyle(
                          fontSize: 16, color: Colors.white),),),
                    new Container(height: 1,
                      width: 100,
                      decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [ Colors.white,
                              Colors.white10,
                              ])
                      ),
                    ),
                  ],
                ),),


              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: new Text("忘记密码?",
                  style: new TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.underline),),
              ),

              /**
               * Or所在的一行
               */
//              Padding(padding: EdgeInsets.only(top: 10),
//                child: new Row(
////                          mainAxisSize: MainAxisSize.max,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    new Container(height: 1,
//                      width: 100,
//                      decoration: BoxDecoration(
//                          gradient: new LinearGradient(
//                              colors: [ Colors.white10,
//                              Colors.white,
//                              ])
//                      ),
//                    ),
//                    new Padding(
//                      padding: EdgeInsets.only(left: 15, right: 15),
//                      child: new Text("Or", style: new TextStyle(
//                          fontSize: 16, color: Colors.white),),),
//                    new Container(height: 1,
//                      width: 100,
//                      decoration: BoxDecoration(
//                          gradient: new LinearGradient(
//                              colors: [ Colors.white,
//                              Colors.white10,
//                              ])
//                      ),
//                    ),
//                  ],
//                ),),

              /**
               * 显示第三方登录的按钮
               */
              new SizedBox(
                height: 10,
              ),
//              new Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  new Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
//                    child: new IconButton(icon: Icon(
//                      FontAwesomeIcons.facebookF, color: Color(0xFF0084ff),),
//                        onPressed: null),
//                  ),
//                  new SizedBox(width: 40,),
//                  new Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
//                    child: new IconButton(icon: Icon(
//                      FontAwesomeIcons.google, color: Color(0xFF0084ff),),
//                        onPressed: null),
//                  ),
//                ],
//              )
            ],
          ),
          new Positioned(
            child: buildSignInButton(),
            top: 185,
          )
        ],
      ),
    );
  }

  /**
   * 点击控制密码是否显示
   */
  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  /**
   * 创建登录界面的TextForm
   */
  Widget buildSignInTextForm() {
    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      width: 300,
      height: 190,
      /**
       * Flutter提供了一个Form widget，它可以对输入框进行分组，
       * 然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
       */
      child: new Form(
        key: _SignInFormKey,
        //开启自动检验输入内容，最好还是自己手动检验，不然每次修改子孩子的TextFormField的时候，其他TextFormField也会被检验，感觉不是很好
//        autovalidate: true,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                  //关联焦点
                  focusNode: emailFocusNode,
                  onEditingComplete: () {
                    if (focusScopeNode == null) {
                      focusScopeNode = FocusScope.of(context);
                    }
                    focusScopeNode.requestFocus(passwordFocusNode);
                  },

                  decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      hintText: "手机号码",
                      border: InputBorder.none
                  ,
                  ),

                  keyboardType: TextInputType.number,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                    if (value==""||value==null||value.length!=11) {
                      return "手机号码不正确";
                    }
                  },
                  onSaved: (value) {
                    _phone = value;
                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: new TextFormField(
                  focusNode: passwordFocusNode,
                  keyboardType: TextInputType.url,
                  decoration: new InputDecoration(

                      icon: new Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: "密码",
                      border: InputBorder.none,

                      suffixIcon: new IconButton(
                          icon: new Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          onPressed: showPassWord)),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassWord,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "密码错误！";
                    }
                  },
                  onSaved: (value) {
                    _pass = value;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * 创建登录界面的按钮
   */
  Widget buildSignInButton() {
    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: theme.Theme.primaryGradient,
        ),
        child: new Text(
          "LOGIN",
          style: new TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        /**利用key来获取widget的状态FormState
              可以用过FormState对Form的子孙FromField进行统一的操作
           */
        if (_SignInFormKey.currentState.validate()) {
          //如果输入都检验通过，则进行登录操作

          //调用所有自孩子的save回调，保存表单内容
          _SignInFormKey.currentState.save();
          var data = {"phone": _phone, "pass": _pass};
          FormData formData = new FormData.from(data);
          print(data);

          dio.post("/login", data: formData).then((v)  {
            String result = v.data['result'];
            print(result);
            if (result == "success") {
              dio.options.headers['token'] = v.data['token'];
              SharedPreferences.getInstance().then((sp){
                sp.setString("token", v.data['token']);
              });
              Navigator.pushReplacementNamed(context, "/index");
            } else {
              Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text(v.data['phone'] != null
                      ? v.data['phone']
                      : "" + v.data['pass'] != null ? v.data['pass'] : "")));
            }
          });
        }

//          debugDumpApp();
      },
    );
  }
}
