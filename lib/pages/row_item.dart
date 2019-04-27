import 'package:flutter/material.dart';
class RowItem extends StatelessWidget {
  final String title;
  final Widget child;

  const RowItem({Key key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black12,
      //height: 60,
      margin: EdgeInsets.only(top: 5, left: 10, right: 20),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 60,
            child: Center(
              child: Text(
                "$title：",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              ),
            ),
          ),
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}
