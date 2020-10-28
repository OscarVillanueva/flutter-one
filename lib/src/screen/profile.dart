import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

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
                  child: Image.network(
                    "https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png",
                    width: 200,
                    height: 200,
                  ),
                  onTap: () {
                    debugPrint("Clic en imagen");
                  },
                ),
                Text("Nombre"),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: "Ingresa tu nombre completo",
                      contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 30),
                Text("Email"),
                SizedBox(height: 10),
                TextFormField(
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
                    onPressed: () {
                      debugPrint("Actualizar");
                    })
              ])),
        ),
      ),
    );
  }
}
