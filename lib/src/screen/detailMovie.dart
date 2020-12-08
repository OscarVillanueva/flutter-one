import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/database/databaseHelper.dart';
import 'package:login/src/models/Trending.dart';
import 'package:login/src/views/movieDetail.dart';

class Detail extends StatefulWidget {
  final Result movie;
  final bool lookInDatabase;
  Detail({Result movie, bool lookInDatabase})
      : this.movie = movie,
        this.lookInDatabase = lookInDatabase;

  @override
  _DetailState createState() =>
      _DetailState(movie: movie, lookInDatabase: lookInDatabase);
}

class _DetailState extends State<Detail> {
  _DetailState({this.movie, this.lookInDatabase});
  final Result movie;
  final bool lookInDatabase;
  IconData icon = Icons.favorite_outline;
  DatabaseHelper _database;

  @override
  void initState() {
    super.initState();

    _database = DatabaseHelper();

    if (lookInDatabase) isFavorite();
  }

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

  changeMoviePreference() async {
    movie.favorite = !movie.favorite;

    if (movie.favorite)
      await _database.insert(movie.toFullJSON(), "tbl_favorites");
    else
      await _database.delete(movie.id, "tbl_favorites");

    setState(() {
      icon = movie.favorite ? Icons.favorite : Icons.favorite_outline;
    });
  }

  isFavorite() async {
    Result result = await _database.getMovie(movie.id);

    if (result != null)
      setState(() {
        movie.favorite = result.favorite;
        icon = movie.favorite ? Icons.favorite : Icons.favorite_outline;
      });
  }
}
