/// ListTile

import 'package:flutter/material.dart';

class TileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Center(
            child: Text('ExpansionTile App'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: new ListView.builder(

            itemBuilder: (BuildContext context, int index) {
              return new StuffInTiles(list[index]);
              return new StuffInTiles(list[index]);
            },
//          itemCount: listOfTiles.length,
            itemCount: list.length,
          ),
        ),
      ),
    );
  }
}

class StuffInTiles extends StatelessWidget {
//  final MyTile myTile;
  final Classes myClass;

//  StuffInTiles(this.myTile);
  StuffInTiles(this.myClass);

  @override
  Widget build(BuildContext context) {
    return _buildTiles(myClass);
//    return _buildTiles(myTile);
  }

//  Widget _buildTiles(MyTile t) {
  Widget _buildTiles(Classes t) {
    if (t.children.isEmpty)
      return new ListTile(

        dense: true,
        enabled: true,
        isThreeLine: false,
        onLongPress: () => print("long press"),
        onTap: () => print("tap"),
        leading: new Text(t.date, style: TextStyle(fontSize: 16)),
        selected: true,
        trailing: Text(t.hw),

//          title: new Text(t.date)
      );

    return new ExpansionTile(
      backgroundColor: Colors.greenAccent[100],
      key: new PageStorageKey<int>(3),
      title: new Text(t.date),
      subtitle: Text(t.time),
      children: t.children.map(_buildTiles).toList(),
    );

//    return new Widget();
  }
}
Widget test(){
  return ButtonBar();
}

class Classes {
  String date;
  String time;
  String hw;
  List<Classes> children;

  Classes(this.date, this.time, this.hw, [ this.children = const <Classes>[]]);
}

List<Classes> list = <Classes>[
  new Classes("الاحد", "03/11/2019", "", <Classes>[
    new Classes("اللغة العربية", "الحصة الأولى", "واحب"),
    new Classes("اللغة الانجليزية", "الحصة الثانية", ""),
    new Classes("العلوم الحياتية ", "الحصة الأولى", ""),
    new Classes("التربية الدينية", "الحصة الأولى", "امتحان"),
  ]),
  new Classes("الأثنين", "03/11/2019", "", <Classes>[
    new Classes("اللغة العربية", "الحصة الأولى", "واحب"),
    new Classes("اللغة الانجليزية", "الحصة الثانية", ""),
    new Classes("العلوم الحياتية ", "الحصة الأولى", ""),
    new Classes("التربية الدينية", "الحصة الأولى", "امتحان"),
  ]),new Classes("الأثنين", "03/11/2019", "", <Classes>[
    new Classes("اللغة العربية", "الحصة الأولى", "واحب"),
    new Classes("اللغة الانجليزية", "الحصة الثانية", ""),
    new Classes("العلوم الحياتية ", "الحصة الأولى", ""),
    new Classes("التربية الدينية", "الحصة الأولى", "امتحان"),
  ]),new Classes("الأثنين", "03/11/2019", "", <Classes>[
    new Classes("اللغة العربية", "الحصة الأولى", "واحب"),
    new Classes("اللغة الانجليزية", "الحصة الثانية", ""),
    new Classes("العلوم الحياتية ", "الحصة الأولى", ""),
    new Classes("التربية الدينية", "الحصة الأولى", "امتحان"),
  ])
];

