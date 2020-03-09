import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mecha_solution/Model/SignupFolder/SignUp.dart';
import 'package:mecha_solution/View/Home/HomeModel.dart';
import 'package:mecha_solution/View/Home/HomePage.dart';
import 'package:mecha_solution/View/SignIn/SignInModel.dart';
import 'package:mecha_solution/data/remote/OauthFromAPI.dart';
import 'package:scoped_model/scoped_model.dart';
import '../Register/RegisterScreen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return ScopedModel<SignInModel>(
      model: SignInModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Đăng nhập"),
          ),
        ),
        body: ScopedModelDescendant<SignInModel>(builder: (context,child,model){
          return Center(child: LoginScreen(model: model),);
        },),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  SignInModel model;
  LoginScreen({Key key, this.model}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static bool remembers = false;
  static SignUp user;
  static final _emailFocus = FocusNode();
  static final _passwordFocus = FocusNode();

  final signInModel = SignInModel();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  
  static _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  } // đổi field text

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener((){
      signInModel.emailSink.add(emailController.text);
    });

    passController.addListener((){
      signInModel.passSink.add(passController.text);
    });
  }
  
  @override
  Widget build(BuildContext context) {

    RaisedButton _btnLogin = new RaisedButton(
        color: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          "Đăng nhập",
          style: TextStyle(fontSize: 16, color: Colors.white,),
        ),
        onPressed: () {
//          FutureBuilder(
//            future: OauthAPI().fecthOauthModel(username, password),
//            builder: (context, snapshot){
//              if(snapshot.hasError)
//                print(snapshot.error);
//              print(snapshot.data);
//              return snapshot.hasData ? Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => HomePage())) : Center(child: CircularProgressIndicator());
//            },
//          );
//
////          String token = await OauthRepoImlp.getInstance().getToken();
////          print(token);
////          Navigator.push(context,
////              MaterialPageRoute(builder: (context) => HomePage(token: token,)));

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

    return ListView(shrinkWrap: true, children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Container(
          child: StreamBuilder<String>(
            stream: signInModel.emailStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: emailController,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.lightBlueAccent,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _emailFocus, _passwordFocus);
                },
                decoration:
                InputDecoration(labelText: "E-mail", border: OutlineInputBorder(),
                errorText: snapshot.data),
              );
            }
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Container(
          height: 48,
          width: 343,
          child: StreamBuilder<String>(
            stream: signInModel.passStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: passController,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.lightBlueAccent,
                ),
                focusNode: _passwordFocus,
                decoration:
                InputDecoration(labelText: "Mật khẩu", border: OutlineInputBorder(),
                errorText: snapshot.data),
                obscureText: true,
              );
            }
          ),
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
  }
}
