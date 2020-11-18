import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';

class Detail extends StatelessWidget {
  const Detail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tendencias"),
          backgroundColor: Configuration.colorApp,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Text(movie["title"]),
              SizedBox(height: 30),
              Text(movie["overview"]),
            ],
          ),
        ),
      ),
    );
  }
}
