import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/database/databaseHelper.dart';
import 'package:login/src/models/User.dart';
import 'package:login/src/network/api_movies.dart';
import 'package:login/src/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _database = DatabaseHelper();
    // Future<User> _savedUser = _database.getUser("correo@correo.com");
    Future<User> _savedUser2 = _lookForUser2();

    ApiMovies apiMovies = ApiMovies();
    apiMovies.getTrending();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Peliculas"),
          backgroundColor: Configuration.colorApp,
        ),
        drawer: Drawer(
          child: FutureBuilder(
              future: _savedUser2,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                return ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Configuration.colorApp),
                      currentAccountPicture: defineAvatar(snapshot.data),
                      accountName: Text(snapshot.data != null
                          ? "${snapshot.data.name} ${snapshot.data.lastName}"
                          : "Invitado"),
                      accountEmail: Text(snapshot.data != null
                          ? snapshot.data.email
                          : "Invitado"),
                      onDetailsPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/profile");
                      },
                    ),
                    ListTile(
                      title: Text("Tendencias"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/trending");
                      },
                      leading: Icon(Icons.trending_up,
                          color: Configuration.colorItem),
                    ),
                    ListTile(
                      title: Text("Buscar"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/search");
                      },
                      leading:
                          Icon(Icons.search, color: Configuration.colorItem),
                    ),
                    ListTile(
                      title: Text("Favoritas"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/favorites");
                      },
                      leading:
                          Icon(Icons.favorite, color: Configuration.colorItem),
                    ),
                    ListTile(
                      title: Text("Salir"),
                      onTap: () {
                        selectHome();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      leading: Icon(Icons.exit_to_app,
                          color: Configuration.colorItem),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Future<void> selectHome() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("token", null);
  }

  Widget defineAvatar(data) {
    if (data == null || data.photo == null)
      return CircleAvatar(
        backgroundImage: NetworkImage(
            "https://villasmilindovillas.com/wp-content/uploads/2020/01/Profile.png"),
      );
    else {
      return ClipOval(
          child: Image.file(
        File(data.photo),
        fit: BoxFit.cover,
      ));
    }
  }

  Future<User> _lookForUser2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map userMap = jsonDecode(prefs.getString('user'));
    return User.fromJSON(userMap);
  }
}
