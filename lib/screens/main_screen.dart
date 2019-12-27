import 'dart:ui';

/// ListTile

import 'package:flutter/material.dart';

class TileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(

        appBar: new AppBar(
          backgroundColor: Colors.greenAccent[200],
          title: new Center(
            child: Text('الجدول الأسبوعي للطالب'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),

          child: new ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return new StuffInTiles(list[index]);
            },
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
Color wajeb(String hw){
  if (hw.contains("واحب")) {
    return Colors.amber[100];
  }if (hw.contains("امتحان")) {
    return Colors.red[100];
  }if (hw.contains("مشروع")) {
    return Colors.blue[100];
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
          child: Column(
            children: <Widget>[
              _buildTiles(myClass)
            ],
          ),
        ),
    );
//    return _buildTiles(myTile);
  }

//  Widget _buildTiles(MyTile t) {
  Widget _buildTiles(Classes t) {
    if (t.children.isEmpty)
      return Card(
        color: wajeb(t.hw),
//        children: <Widget>[
          child: ListTile(
        dense: true,
        enabled: true,
        isThreeLine: false,
        onLongPress: () => print("long press"),
        onTap: () => print("tap"),
        leading: new Text(t.date, style: TextStyle(fontSize: 16)),
        selected: true,
        trailing: Text(t.hw),
//          title: new Text(t.date)
      ));

    return Card(
      elevation: 2,
      color: Colors.greenAccent[200],
      child: ExpansionTile(
        backgroundColor: Colors.greenAccent[100],
        key: new PageStorageKey<int>(3),
        title: new Text(t.date),
        subtitle: Text(t.time),
        children: t.children.map(_buildTiles).toList(),
      ),
    );
  }
}

Widget test() {
  return ButtonBar();
}

class Classes {
  String date;
  String time;
  String hw;
  List<Classes> children;

  Classes(this.date, this.time, this.hw, [this.children = const <Classes>[]]);
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
  ]),
  new Classes("الثلاثاء", "04/11/2019", "", <Classes>[
    new Classes("اللغة العربية", "الحصة الأولى", ""),
    new Classes("اللغة الانجليزية", "الحصة الثانية", "مشروع"),
    new Classes("العلوم الحياتية ", "الحصة الأولى", ""),
    new Classes("التربية الدينية", "الحصة الأولى", ""),
  ]),
  new Classes("الأربعاء", "05/11/2019", "", <Classes>[
    new Classes("اللغة العربية", "الحصة الأولى", "واحب"),
    new Classes("اللغة الانجليزية", "الحصة الثانية", "مشروع"),
    new Classes("العلوم الحياتية ", "الحصة الأولى", ""),
    new Classes("التربية الدينية", "الحصة الأولى", ""),
  ])
];
