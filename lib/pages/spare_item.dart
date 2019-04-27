import 'package:flutter/material.dart';

class SpareItem extends StatelessWidget {
  final Map item;
  SpareItem(this.item);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
//          showDialog(
//              context: context,
//              builder: (context) {
//                return Center(
//                    child: Container(
//                  color: Colors.white,
//                  height: 400,
//                  width: 200,
//                  child: Text(item['name']),
//                ));
//              });
          // Scaffold.of(context).(SnackBar(content: Text(item['name'])));
        },
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(width: 0.5, color: Color(0xFFd9d9d9))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 0, right: 13.0),
//                child: Icon(Icons.developer_board,
//                    size: 36.0,
//                    color: item['statusName'] == "坏"
//                        ? Color(0xFFf00009)
//                        : Color(0xff0ff009)),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  border: new Border.all(width: 2.0, color: Colors.black12),
                  color: Colors.white30,
                  borderRadius: new BorderRadius.all(Radius.circular(10))

                ),

                child: Center(child:Icon(Icons.developer_board,
                size: 24,
                color: item['status'] == 0
                       ? Color(0xFFf00009)
                        : Color(0xff0ff009)
              ),),)
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: "${item['name']}",
                        style:
                            TextStyle(fontSize: 16.0, color: Color(0xFF353535)),
                      ),TextSpan(text: " "),
                      TextSpan(
                        text: item['sub_name'],
                        style:
                            TextStyle(fontSize: 14.0, color: Color(0xFFa9a9a9)),
                      )
                    ])),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                    ),
                    Text(
                      "${item['house_name']} ${item['row']}行 ${item['col']}列 ${item['floor']}层 第${item['num']}个",
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xFd8aaa8f)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      item['factory']!=null?item['factory']:"",
                      style:
                          TextStyle(fontSize: 15.0, color:Colors.blueGrey
                        //  Color(0xFFa9a9a9)
                          ),
                    ),
                    Text(
                      item['net_type']!=null?item['net_type']:"",
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontSize: 15.0, color:Colors.blueGrey
                        //  Color(0xFFa9a9a9)
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ));
  }
}


