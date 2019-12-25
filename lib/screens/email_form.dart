import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EmailForm extends StatefulWidget {
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  Future<File> file;

  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selected;
  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
  }

  @override
  void initState(){
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selected= _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List company){
    List<DropdownMenuItem<Company>> items= List();
    for(Company c in company){
      items.add(
        DropdownMenuItem(
          value: c,
          child: Text(c.name),
        )
      );
    }
    return items;
  }


  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          print(snapshot.data.toString());
          return Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Image.file(
                snapshot.data,
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              ),
            ],
          );
        } else if (null != snapshot.error) {
          return const Text('Error');
        } else {
          return const Text('No Image Selected');
        }
      },
    );
  }
  void onChangeDropdownItem(Company newSelected){
  setState(() {
    _selected = newSelected;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ارسال رسالة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              DropdownButton(
                isExpanded: true,
                value: _selected,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
              TextField(
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                    labelText: "انا ولي امر الطالب ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      labelText: "الى المعلم",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      labelText: "الموضوع",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  textDirection: TextDirection.rtl,
                  maxLines: 10,
                  decoration: InputDecoration(
                      labelText: "نص الرسالة",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: OutlineButton(
                  onPressed: chooseImage,
                  child: Text("اختار الملف"),
                ),
              ),
              showImage(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: OutlineButton(
                  onPressed: null,
                  child: Text("ارسال"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Company{
  int id;
  String name;

  Company(this.id,this.name);

  static List<Company> getCompanies(){
    return <Company>[
      Company(1,"Nidal"),
      Company(2,"manna"),
      Company(3,"stef")
    ];
  }

}
