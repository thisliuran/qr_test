import 'package:flutter/material.dart';

class SpareItem extends StatelessWidget {
  final Map item;
  SpareItem(this.item);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                    child: Container(
                  color: Colors.white,
                  height: 400,
                  width: 200,
                  child: Text(item['name']),
                ));
              });
          // Scaffold.of(context).(SnackBar(content: Text(item['name'])));
        },
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
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
                child: Icon(Icons.developer_board,
                    size: 36.0,
                    color: item['statusName'] == "坏"
                        ? Color(0xFFf00009)
                        : Color(0xff0ff009)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text.rich(TextSpan(children: [
                      TextSpan(
                        text: item['name'] + " ",
                        style:
                            TextStyle(fontSize: 16.0, color: Color(0xFF353535)),
                      ),
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
                      "${item['house_name']} ${item['row']}行${item['col']}列${item['floor']}第${item['num']}个",
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xFd8aaa8f)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      item['factory_name'],
                      style:
                          TextStyle(fontSize: 14.0, color: Color(0xFFa9a9a9)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
