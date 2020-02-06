import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mecha_solution/Model/User.dart';
import 'package:mecha_solution/Repo/OauthRepo.dart';
import 'package:mecha_solution/View/SignIn/SignInModel.dart';
import 'package:mecha_solution/data/DecodeRepoImpl.dart';
import 'package:mecha_solution/data/OauthRepoImlp.dart';
import 'package:mecha_solution/data/remote/DataFromOauth.dart';
import 'package:scoped_model/scoped_model.dart';
import '../Register/RegisterScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool remembers = false;
  User user;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  } // đổi field text

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextFormField _email = new TextFormField(
      style: TextStyle(
        fontSize: 14,
        color: Colors.lightBlueAccent,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _emailFocus,_passwordFocus);
      },
      decoration:
          InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),
      onChanged: (value) {
        setState(() {
          try{
             user.data.username = value.toString();
          }
          catch(exception)
          {
             user.data.username = '';
          }
          //lấy giá trị textfield
        });
      },
    );

    TextField _pass = new TextField(
      style: TextStyle(
        fontSize: 14,
        color: Colors.lightBlueAccent,
      ),
      focusNode: _passwordFocus,
      decoration:
          InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder()),
      obscureText: true,
      onChanged: (value){
        try{
          user.data.password = value.toString();
        }
        catch(exception)
        {
          user.data.password = '';
        }
      },
    );

    RaisedButton _btnLogin = new RaisedButton(
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "Đăng nhập",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () async {
          String email = await DecodeRepoImpl.GetInstance().getEmail();
          String username = await DecodeRepoImpl.GetInstance().getUserName();
        });

    SignInButton _btnFB = new SignInButton(
      Buttons.Facebook,
      text: "Facebook",
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      onPressed: () {},
      padding: EdgeInsets.only(left: 25),
    );

    SignInButton _btnGmail = new SignInButton(
      Buttons.Google,
      text: "Google",
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      onPressed: () {},
      padding: EdgeInsets.only(left: 30),
    );

    Checkbox remember = new Checkbox(
        value: remembers,
        onChanged: (bool value) {
          setState(() {
            remembers = value;
            print(remembers);
          });
        });
    ListView list = new ListView(shrinkWrap: true, children: <Widget>[
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
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontFamily: 'SemiBold'),
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
                fontFamily: 'SemiBold'),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Container(
          height: 48,
          width: 343,
          child: _btnLogin,
          //color: Colors.lightBlueAccent,
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
            Text("Chưa có tài khoản?",
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 13,
                    fontFamily: 'SemiBold')),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
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
