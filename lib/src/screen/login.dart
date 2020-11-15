import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/src/models/User.dart';
import 'package:login/src/network/api_login.dart';
import 'package:login/src/screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  bool isRemember = true;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool> _rememberme(String token, User user) async {
    final SharedPreferences prefs = await _prefs;
    bool result = true;

    String userStringified = jsonEncode(user.toFullJSON());

    await prefs.setString("user", userStringified);

    if (isRemember) result = await prefs.setString("token", token);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    ApiLogin httpLogin = ApiLogin();
    TextEditingController txtControllerEmail = TextEditingController();
    TextEditingController txtControllerPassword = TextEditingController();

    final txtEmail = TextFormField(
      controller: txtControllerEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Ingresa tu email",
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );

    final txtPassword = TextFormField(
      controller: txtControllerPassword,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Ingresa tu contraseña",
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );

    final logo = Image.network(
      "http://itcelaya.edu.mx/jornadabioquimica/wp-content/uploads/2019/07/LOGO-ITC-843x1024.png",
      width: 200,
      height: 200,
    );

    final check = CheckboxListTile(
      title: Text("Mantener sesión iniciada"),
      value: isRemember,
      onChanged: (value) {
        setState(() {
          isRemember = value;
        });
      },
    );

    final loginButton = RaisedButton(
        child: Text(
          "Ingresar",
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.lightBlue,
        onPressed: () async {
          User user = User.fromLogin(
              txtControllerEmail.text, txtControllerPassword.text);

          setState(() {
            isLoading = true;
          });

          final token = await httpLogin.validateUser(user);

          setState(() {
            isLoading = false;
          });

          final result = await _rememberme(token, user);

          if (result)
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          else
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("Error al iniciar sesión"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  );
                });
        });

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/image.jpg"),
                  fit: BoxFit.fitHeight)),
        ),
        Card(
            color: Colors.white70,
            margin: EdgeInsets.all(30.0),
            elevation: 8.0,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  txtEmail,
                  SizedBox(height: 10),
                  txtPassword,
                  SizedBox(height: 10),
                  check,
                  SizedBox(height: 10),
                  loginButton
                ],
              ),
            )),
        Positioned(child: logo, top: 100),
        Positioned(
          child: isLoading ? CircularProgressIndicator() : Container(),
          top: 330,
        )
      ],
    );
  }
}
