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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0.0, 5.0), blurRadius: 1.0)
      ]),
      child: ClipRRect(
        child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 1,
            child: FadeInImage(
              placeholder: AssetImage("assets/image.jpg"),
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
            ),
          ),
          Opacity(
            opacity: 0.6,
            child: Container(
              padding: EdgeInsets.all(10),
              height: 55,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      movie.title.substring(
                          0, movie.title.length > 30 ? 20 : movie.title.length),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      )),
                  FlatButton(
                      child: Icon(Icons.chevron_right, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, "/detail", arguments: {
                          "title": movie.title,
                          "overview": movie.overview,
                        });
                      })
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
