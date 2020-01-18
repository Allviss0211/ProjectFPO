import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mecha_solution/Repo/OauthRepo.dart';
import 'RegisterScreen.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool remembers = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextField _email = new TextField(
      style: TextStyle(
        fontSize: 14,
        color: Colors.lightBlueAccent,
      ),
      decoration:
      InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),
      onChanged: (value){
        setState(() {
          //lấy giá trị textfield
        });
      },
    );
    TextField _pass = new TextField(
      style: TextStyle(
        fontSize: 14,
        color: Colors.lightBlueAccent,
      ),
      decoration:
      InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder()),
      obscureText: true,
    );
    RaisedButton _btnLogin = new RaisedButton(
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "Đăng nhập",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () {
          // thao tác đăng nhập
        });

    SignInButton _btnFB = new SignInButton(
      Buttons.Facebook,
      text: "Facebook",
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      onPressed: () {},
    );

    SignInButton _btnGmail = new SignInButton(
      Buttons.Google,
      text: "Google",
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      onPressed: () {},
    );

    Checkbox remember = new Checkbox(
        value: remembers,
        onChanged: (bool value) {
          setState(() {
            remembers = value;
            print(remembers);
          });
        });
    ListView list = new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Container(
              height: 48,
              width: 343,
              child: _email,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Container(
              height: 48,
              width: 343,
              child: _pass,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    remember,
                    Text(
                      "Lưu mật khẩu",
                      style: TextStyle(fontSize: 13, color: Colors.black,fontFamily: 'SemiBold'),
                    )
                  ],
                ),
              ),
              Text(
                'Quên mật khẩu',
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SemiBold'
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Container(
              height: 48,
              width: 343,
              child: _btnLogin,
              color: Colors.lightBlueAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 48,
                  width: 180,
                  child: _btnFB,
                ),
                SizedBox(
                  height: 48,
                  width: 180,
                  child: _btnGmail,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(48, 0, 25, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Chưa có tài khoản?", style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 13,
                    fontFamily: 'SemiBold')),
                FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ]);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Đăng nhập"),
        ),
      ),
      body: Center(child: list),
    );
  }
}
