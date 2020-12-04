import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/src/models/Cast.dart';

class Character extends StatelessWidget {
  final CastElement character;
  Character({this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          profileImage(),
          SizedBox(height: 15),
          generateTextField(
              text: character.name,
              color: Colors.white,
              size: 18,
              align: TextAlign.justify,
              weight: FontWeight.normal),
          SizedBox(height: 15),
          generateTextField(
              text: "Personaje: ${character.character}",
              color: Colors.white,
              size: 18,
              align: TextAlign.justify,
              weight: FontWeight.normal),
        ],
      ),
    );
  }

  Text generateTextField(
      {String text,
      Color color,
      double size,
      TextAlign align,
      FontWeight weight}) {
    return Text(text,
        textAlign: align,
        style: TextStyle(fontWeight: weight, fontSize: size, color: color));
  }

  Widget profileImage() {
    String profilePath =
        "https://image.tmdb.org/t/p/w92${character.profilePath}";

    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          placeholder: AssetImage("assets/profile.png"),
          image: character.profilePath != null
              ? NetworkImage(profilePath)
              : AssetImage("assets/profile.png"),
        ));
  }
}
