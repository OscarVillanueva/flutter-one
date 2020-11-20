import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/src/models/Trending.dart';

class MovieDetail extends StatelessWidget {
  final Result movie;
  MovieDetail({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: ListView(children: <Widget>[
        FadeInImage(
          placeholder: AssetImage("assets/image.jpg"),
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              generateTextField(
                  text: movie.title,
                  color: Colors.white,
                  size: 28,
                  align: TextAlign.center,
                  weight: FontWeight.bold),
              SizedBox(height: 30),
              generateTextField(
                  text: movie.overview,
                  color: Colors.white,
                  size: 18,
                  align: TextAlign.justify,
                  weight: FontWeight.normal),
            ],
          ),
        )
      ]),
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
}
