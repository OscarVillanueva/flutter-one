import 'package:flutter/material.dart';
import 'package:login/src/screen/dashboard.dart';
import 'package:login/src/screen/favorites.dart';
import 'package:login/src/screen/login.dart';
import 'package:login/src/screen/profile.dart';
import 'package:login/src/screen/search.dart';
import 'package:login/src/screen/trending.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Widget first = Container();

  @override
  void initState() {
    super.initState();

    selectHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login": (BuildContext context) => Login(),
        "/trending": (BuildContext context) => Trending(),
        "/search": (BuildContext context) => Search(),
        "/favorites": (BuildContext context) => Favorites(),
        "/profile": (BuildContext context) => Profile(),
        "/dashboard": (BuildContext context) => Dashboard()
      },
      home: first,
    );
  }

  Future<void> selectHome() async {
    final SharedPreferences prefs = await _prefs;

    final token = prefs.getString("token");

    setState(() {
      first = token != null ? Dashboard() : Login();
    });
  }
}
