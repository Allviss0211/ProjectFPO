import 'package:demo_token/Project/LoginPrj.dart';
import 'package:demo_token/model/GetInfo.dart';
import 'package:demo_token/model/GetToken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginSrceen extends StatelessWidget {
  String username = 'admin';
  String password = '0000';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextField _username = new TextField(
      style: TextStyle(fontSize: 30, color: Colors.black),
      autofocus: true,
      decoration: InputDecoration(labelText: "Tài khoản", border: InputBorder.none),
      onChanged: (value) {
        try {
          username = value.toString();
        } catch (exception) {
          username = '0000';
        }
      },
    );

    TextField _password = new TextField(
      style: TextStyle(fontSize: 30, color: Colors.black),
      obscureText: true,
      decoration: InputDecoration(labelText: "Mật khẩu", border: InputBorder.none),
      onChanged: (value) {
        try {
          password = value.toString();
        } catch (exception) {
          password = '0000';
        }
      },
    );

    RaisedButton _loginbtn = new RaisedButton(
        color: Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "Đăng nhập",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () async {
          //String token = await getToken();
          //GetInfo info = await getInfo(token);
          //print(token);
          if (username == 'admin' && password == '0000') {
            Dialog dialog = new Dialog(
              child: Container(
                height: 320,
                width: 300,
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Đăng nhập",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: Colors.lightBlueAccent),
                    ),
                    Container(
                        height: 320,
                        width: 300,
                        child: Login(),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)))
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            );
            showDialog(context: context, child: dialog);
          } else {
            AlertDialog dialog = new AlertDialog(
              content: Text("Sai mật khẩu hoặc tài khoản"),
            );
            showDialog(context: context, child: dialog);
          }
        });

    ListView containers = new ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Image.asset('images/Allviss_Logo.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: _username,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: <Widget>[
              _password,
              Text(
                'Hiện',
                style: TextStyle(color: Colors.lightBlue, fontSize: 20),
              )
            ],
          ),
        ),
        SizedBox(
          height: 50,
          width: 100,
          child: _loginbtn,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Đăng ký',
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20),
              ),
              Text(
                'Quên mật khẩu',
                style: TextStyle(color: Colors.lightBlueAccent, fontSize: 20),
              )
            ],
          ),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Đăng nhập"),
        ),
      ),
      body: containers,
    );
  }
}
