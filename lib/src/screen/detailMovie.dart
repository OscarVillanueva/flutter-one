import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/models/Trending.dart';
import 'package:login/src/views/movieDetail.dart';

class Detail extends StatefulWidget {
  final Result movie;
  Detail({Result movie}) : this.movie = movie;

  @override
  _DetailState createState() => _DetailState(movie: movie);
}

class _DetailState extends State<Detail> {
  _DetailState({this.movie});
  final Result movie;
  IconData icon = Icons.favorite_outline;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          backgroundColor: Configuration.colorApp,
          actions: <Widget>[
            MaterialButton(
                child: Icon(icon, color: Colors.red[300]),
                onPressed: () => changeMoviePreference())
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
                  fit: BoxFit.cover)),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 22),
              child: MovieDetail(movie: movie),
            ),
          ),
        ),
      ),
    );
  }

  changeMoviePreference() {
    movie.favorite = !movie.favorite;

    setState(() {
      icon = movie.favorite ? Icons.favorite : Icons.favorite_outline;
    });
  }
}
