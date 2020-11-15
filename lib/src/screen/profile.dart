import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/database/databaseHelper.dart';
import 'package:login/src/models/User.dart';
import 'package:login/src/screen/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imagePath;
  DatabaseHelper _database;
  User user;
  final picker = ImagePicker();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController txtControllerName = TextEditingController();
  TextEditingController txtControllerLastName = TextEditingController();
  TextEditingController txtControllerPhone = TextEditingController();
  TextEditingController txtControllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _database = DatabaseHelper();
    // lookForUser();
    _lookForUser2();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Perfil"),
          backgroundColor: Configuration.colorApp,
        ),
        body: Center(
          child: Container(
              padding: EdgeInsets.all(30),
              child: ListView(children: <Widget>[
                InkWell(
                  child: getImage(),
                  onTap: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.gallery);
                    setState(() {
                      imagePath = pickedFile.path;
                    });
                  },
                ),
                SizedBox(height: 30),
                Text("Nombre"),
                SizedBox(height: 10),
                TextFormField(
                  controller: txtControllerName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: "Ingresa tu nombre",
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 30),
                Text("Apellido"),
                SizedBox(height: 10),
                TextFormField(
                  controller: txtControllerLastName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: "Ingresa tu apellido",
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 30),
                Text("Email"),
                SizedBox(height: 10),
                TextFormField(
                  controller: txtControllerEmail,
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Ingresa tu email",
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 30),
                Text("Teléfono"),
                SizedBox(height: 10),
                TextFormField(
                  controller: txtControllerPhone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Ingresa tu número teléfonico",
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 30),
                RaisedButton(
                    child: Text(
                      "Actualizar",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Configuration.colorApp,
                    onPressed: () async {
                      // Guardar en la base de datos
                      User user = User(
                          "username",
                          "password",
                          txtControllerName.text,
                          txtControllerLastName.text,
                          txtControllerPhone.text,
                          txtControllerEmail.text,
                          imagePath,
                          1);

                      // Guadamos en sharedpreferences
                      await saveUser(user);

                      // Insertamos en la base de datos
                      _database.insert(user.toFullJSON(), "tbl_profile");

                      // Regresamos al usuario al dashboard
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Dashboard()),
                          ModalRoute.withName("/login"));
                    })
              ])),
        ),
      ),
    );
  }

  Widget getImage() {
    return imagePath == null
        ? Image.network(
            "https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png",
            width: 200,
            height: 200,
          )
        : Image.file(File(imagePath));
  }

  void lookForUser() async {
    User bridge = await _database.getUser("correo@correo.com");
    if (bridge != null) {
      setValues(bridge);
      setState(() {
        user = bridge;
        imagePath = bridge.photo;
      });
    }
  }

  void setValues(user) async {
    if (user != null) {
      txtControllerName.text = user.name;
      txtControllerLastName.text = user.lastName;
      txtControllerPhone.text = user.phone;
      txtControllerEmail.text = user.email;
    }
  }

  void _lookForUser2() async {
    final SharedPreferences prefs = await _prefs;

    Map userMap = jsonDecode(prefs.getString('user'));
    User bridge = User.fromJSON(userMap);

    setValues(bridge);

    setState(() {
      user = bridge;
      imagePath = bridge.photo == "" ? null : bridge.photo;
    });
  }

  void saveUser(User user) async {
    final SharedPreferences prefs = await _prefs;

    String userStringified = jsonEncode(user.toFullJSON());

    await prefs.setString("user", userStringified);
  }
}
