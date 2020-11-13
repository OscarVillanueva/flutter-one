import 'package:flutter/material.dart';
import 'package:login/src/models/Trending.dart';

class CardTrending extends StatefulWidget {
  final Result movie;
  CardTrending({Result movie}) : this.movie = movie;

  @override
  _CardTrendingState createState() => _CardTrendingState(movie);
}

class _CardTrendingState extends State<CardTrending> {
  _CardTrendingState(this.movie);
  final Result movie;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: FadeInImage(
          placeholder: AssetImage("assets/image.jpg"),
          image: NetworkImage(
              "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
        ),
      )
    ]);
  }
}
