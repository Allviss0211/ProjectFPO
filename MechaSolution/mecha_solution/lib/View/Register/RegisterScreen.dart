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
  var _formKey = GlobalKey<FormState>();

  double _height = 43;
  bool _validFullname = false;
  bool _validPassword = false;
  bool _validEmail = false;
  bool _validRepassword = false;
  bool _validVerificationcode = false;
  bool _validPhone = false;
  bool _validBirthday = false;

  bool _validFullnameCheck = true;
  bool _validPasswordCheck = true;
  bool _validEmailCheck = true;
  bool _validRepasswordCheck = true;
  bool _validVerificationcodeCheck = true;
  bool _validPhoneCheck = true;
  bool _validBirthdayCheck = true;

  bool look = true;
  int nam = 1;
  int nu = 2;
  int group = 1;
  final format = DateFormat("dd-MM-yyyy");

  SignUpBody userSignUp = new SignUpBody();

  @override
  Widget build(BuildContext context) {
    TextFormField fullname = new TextFormField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "Họ và tên",
          border: OutlineInputBorder(),
          errorText: _validFullname ? "Chưa nhập tên người dùng" : null),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            setState(() {
              _validFullname = true;
            });
          } else {
            setState(() {
              _validFullname = false;
              _validFullnameCheck = false;
            });
          }
          userSignUp.fullname = value.toString();
        });
      },
    );

    TextField phone = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "SĐT",
          border: OutlineInputBorder(),
          errorText: _validPhone ? "Chưa nhập số điện thoại" : null),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            setState(() {
              _validPhone = true;
            });
          } else {
            setState(() {
              _validPhone = false;
              _validPhoneCheck = false;
            });
          }
          userSignUp.phone = value.toString();
        });
      },
    );

    TextField verificationcode = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
        labelText: "Mã xác thực",
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            setState(() {
              _validVerificationcode = true;
            });
          } else {
            setState(() {
              _validVerificationcode = false;
              _validVerificationcodeCheck = false;
            });
          }
          userSignUp.work = value.toString();
        });
      },
    );

    TextField email = new TextField(
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "E-mail",
          border: OutlineInputBorder(),
          errorText: _validEmail ? "Chưa nhập địa chỉ Email" : null),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            setState(() {
              _validEmail = true;
            });
          } else {
            setState(() {
              _validEmail = false;
              _validEmailCheck = false;
            });
          }
          userSignUp.email = value.toString();
        });
      },
    );

    TextField password = new TextField(
      obscureText: look ? true : false,
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "Mật khẩu",
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () { setState(() => look = !look); },
          ),
          errorText: _validPassword ? "Chưa nhập mật khẩu" : null),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            setState(() {
              _validPassword = true;
            });
          } else {
            setState(() {
              _validPassword = false;
              _validPasswordCheck = false;
            });
          }
          // đặt trong setState để cập nhật liên tục
          var content = new Utf8Encoder().convert(
              value); // https://stackoverflow.com/questions/47870642/dart-md5-from-string
          userSignUp.password =
              crypto.md5.convert(content).toString(); // convert to MD5
        });
      },
    );

    TextField repassword = new TextField(
      obscureText: true,
      style: TextStyle(color: Colors.lightBlueAccent, fontSize: 14),
      decoration: InputDecoration(
          labelText: "Nhập lại mật khẩu",
          border: OutlineInputBorder(),
          errorText:
              _validRepassword ? "Nhập lại mật khẩu không chính xác" : null),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            setState(() {
              _validRepassword = true;
            });
          } else {
            _validRepassword = false;
            _validRepasswordCheck = false;
          }
          // đặt trong setState để cập nhật liên tục
          var content = new Utf8Encoder().convert(
              value); // https://stackoverflow.com/questions/47870642/dart-md5-from-string
          userSignUp.repassword =
              crypto.md5.convert(content).toString(); // convert to MD5
          if (userSignUp.repassword != userSignUp.password) {
            setState(() {
              _validRepassword = true;
            });
          } else {
            setState(() {
              _validRepassword = false;
            });
          }
        });
      },
    );

    Radio radioNam = new Radio(
        value: nam,
        groupValue: group,
        onChanged: (value) {
          setState(() {
            userSignUp.gender = value;
            group = value;
          });
        });
    Radio radioNu = new Radio(
        value: nu,
        groupValue: group,
        onChanged: (value) {
          setState(() {
            userSignUp.gender = value;
            group = value;
          });
        });

    DateTimeField birthday = new DateTimeField(
        format: format,
        decoration: InputDecoration(
            labelText: "Ngày sinh",
            border: OutlineInputBorder(),
            errorText: _validBirthday ? "Chưa nhập ngày sinh" : null),
        style: TextStyle(fontSize: 14),
        onChanged: (value) {
          if (value == null) {
            setState(() {
              _validBirthday = true;
            });
          } else if (value != null) {
            setState(() {
              _validBirthday = false;
              _validBirthdayCheck = false;
            });
          }
        },
        onShowPicker: (context, value) {
          if (value == null) {
            setState(() {
              _validBirthday = true;
            });
          }
          return showDatePicker(
            context: context,
            initialDate: value ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2500),
          );
        });

    RaisedButton _btnRegister = new RaisedButton(
        color: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "Đăng ký",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () async {
          setState(() {
            if (_validVerificationcode) {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text("Warning",style: TextStyle(color: Colors.red,),),
                        content: Text("Chưa nhập mã xác thực",),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.pop(context, 'OK'),
                          )
                        ],
                      ));
            } else
              if(_validBirthdayCheck || _validRepasswordCheck || _validPasswordCheck || _validEmailCheck || _validPhoneCheck || _validFullnameCheck)
            {
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Warning",style: TextStyle(color: Colors.red,),),
                    content: Text("Vui lòng nhập đủ thông tin",),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.pop(context, 'OK'),
                      )
                    ],
                  ));
            } else
              {
              }
          });
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
            height: _validPhone ? 66 : 43, width: 343, child: fullname),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: _validPhone ? 66 : 43,
          width: 343,
          child: phone,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 43,
          width: 343,
          child: Row(
            children: <Widget>[
              Container(
                width: 273,
                child: verificationcode,
              ),
              Container(height: 43, width: 120, child: _btnVerification)
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: _validEmail ? 66 : 43,
          width: 343,
          child: email,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: _validPassword ? 66 : 43,
          width: 343,
          child: password,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: _validRepassword ? 66 : 43,
          width: 343,
          child: repassword,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: _validBirthday ? 66 : 43,
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
            child: _btnRegister,
          ))
    ]);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Đăng ký"),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Center(child: dangky),
          ),
        ));
  }
}
