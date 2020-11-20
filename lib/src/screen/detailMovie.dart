import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/models/Trending.dart';
import 'package:login/src/views/movieDetail.dart';

class Detail extends StatelessWidget {
  final Result movie;
  Detail({this.movie});

  @override
  Widget build(BuildContext context) {
    // final movie =
    //     ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
          backgroundColor: Configuration.colorApp,
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
}
