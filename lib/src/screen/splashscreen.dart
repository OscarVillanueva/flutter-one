import 'package:flutter/material.dart';
import 'package:login/src/screen/login.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: new Login(),
      title: Text("Bienvenido"),
      image: new Image.network(
          'https://flutter.io/images/catalog-widget-placeholder.png'),
      gradientBackground: LinearGradient(
          colors: [Colors.purple[100], Colors.blue],
          begin: Alignment.center,
          end: Alignment.bottomCenter),
      loaderColor: Colors.red,
    );
  }
}
