import 'dart:convert';
import 'dart:ui';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mecha_solution/Model/SignUp.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:mecha_solution/Model/SignUpBody.dart';

class Register extends StatefulWidget {
  List<String> sex = ["Nam", "Nữ"];
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _validUsername = false;
  int nam = 1;
  int nu = 2;
  int group = 1;
  final format = DateFormat("dd-MM-yyyy");

  SignUpBody userSignUp = new SignUpBody();

  @override
  Widget build(BuildContext context) {
    TextField fullname = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(labelText: "Họ và tên", border: OutlineInputBorder(),errorText: _validUsername ? "Chưa nhập tên người dùng" : null),
      onChanged: (value) {
        setState(() {
          value.isEmpty ? _validUsername = true : _validUsername = false;
          userSignUp.fullname = value.toString();
          print(value);
        });
      },
    );

    TextField phone = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration:
          InputDecoration(labelText: "SĐT", border: OutlineInputBorder()),
      onChanged: (value) {
        setState(() {
          userSignUp.phone = value.toString();
        });
      },
    );

    TextField verificationcode = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "Mã xác thực", border: OutlineInputBorder()),
      onChanged: (value) {
        setState(() {
          userSignUp.avatar = value.toString();
        });
      },
    );

    TextField email = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration:
          InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),
      onChanged: (value) {
        setState(() {
          userSignUp.email = value.toString();
        });
      },
    );
    TextField password = new TextField(
      obscureText: true,
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration:
          InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder(), suffixIcon: Icon(Icons.remove_red_eye)),
      onChanged: (value) {
        setState(() {
          // đặt trong setState để cập nhật liên tục
          var content = new Utf8Encoder().convert(
              value); // https://stackoverflow.com/questions/47870642/dart-md5-from-string
          userSignUp.password =
              crypto.md5.convert(content).toString(); // convert to MD5
          print(userSignUp.password);
        });
      },
    );

    TextField repassword = new TextField(
      obscureText: true,
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "Nhập lại mật khẩu", border: OutlineInputBorder()),
      onChanged: (value) {
        setState(() {
          // đặt trong setState để cập nhật liên tục
          var content = new Utf8Encoder().convert(
              value); // https://stackoverflow.com/questions/47870642/dart-md5-from-string
          userSignUp.repassword =
              crypto.md5.convert(content).toString(); // convert to MD5
          if (userSignUp.repassword != userSignUp.password) {}
        });
      },
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

    DateTimeField birthday = new DateTimeField(
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
        onPressed: () async {
          print(userSignUp.password); // bug nhận về null
        });

    RaisedButton _btnVerification = new RaisedButton(
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
          child: fullname,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: phone,
        ),
      ),
      Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(height: 43, width: 403, child: verificationcode),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              height: 43,
              width: 120,
              child: _btnVerification,
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
          child: password,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: repassword,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: birthday,
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
