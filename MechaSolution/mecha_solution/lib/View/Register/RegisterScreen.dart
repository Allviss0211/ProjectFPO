import 'dart:ui';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  List<String> sex = ["Nam", "Nữ"];
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool test = true;
  int nam = 1;
  int nu = 2;
  int group = 1;
  final format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    TextField hoten = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration:
          InputDecoration(labelText: "Họ và tên", border: OutlineInputBorder()),
    );

    TextField sdt = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration:
          InputDecoration(labelText: "SĐT", border: OutlineInputBorder()),
    );

    TextField maxacthuc = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "Mã xác thực", border: OutlineInputBorder()),
    );

    TextField email = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration:
          InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),
    );
    TextField matkhau = new TextField(
      obscureText: true,
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration:
          InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder()),
    );

    TextField rematkhau = new TextField(
      obscureText: true,
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "Nhập lại mật khẩu", border: OutlineInputBorder()),
    );

    Radio radioNam = new Radio(
        value: nam,
        groupValue: group,
        onChanged: (value) {
          setState(() {
            group = value;
          });
        });
    Radio radioNu = new Radio(
        value: nu,
        groupValue: group,
        onChanged: (value) {
          setState(() {
            group = value;
          });
        });

    DateTimeField datetime = new DateTimeField(
        format: format,
        decoration: InputDecoration(
            labelText: "Ngày sinh", border: OutlineInputBorder()),
        style: TextStyle(fontSize: 14),
        onShowPicker: (context, value) {
          return showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2500));
        });

    RaisedButton _btnReg = new RaisedButton(
        color: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "Đăng ký",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: null);

    RaisedButton _btnXacThuc = new RaisedButton(
        color: Colors.orange,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(
          "Mã xác thực",
          style: TextStyle(fontSize: 13, color: Colors.white),
        ),
        onPressed: null);
    ListView dangky = new ListView(shrinkWrap: true, children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: hoten,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: sdt,
        ),
      ),
      Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(height: 43, width: 403, child: maxacthuc),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 43,
              width: 120,
              child: _btnXacThuc,
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: email,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: matkhau,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: rematkhau,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: datetime,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            Text("Giới tính"),
            radioNam,
            Text("Nam"),
            radioNu,
            Text("Nữ"),
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Container(
            height: 48,
            width: 343,
            child: _btnReg,
          ))
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Đăng ký"),
          ),
        ),
        body: Center(child: dangky));
  }
}
