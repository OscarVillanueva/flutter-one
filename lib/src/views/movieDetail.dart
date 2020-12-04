import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/models/Cast.dart';
import 'package:login/src/models/MovieExtra.dart';
import 'package:login/src/models/Trending.dart';
import 'package:login/src/models/Video.dart';
import 'package:login/src/network/api_cast.dart';
import 'package:login/src/network/api_videos.dart';
import 'package:login/src/views/character.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieDetail extends StatelessWidget {
  final Result movie;
  ApiVideo apiVideo;
  ApiCast apiCast;
  MovieDetail({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: FutureBuilder(
        future: prepareDetails(),
        builder: (BuildContext context, AsyncSnapshot<MovieExtra> snapshot) {
          return ListView(children: <Widget>[
            preparePlayer(
                key: snapshot.data != null ? snapshot.data.video.key : ""),
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
                  SizedBox(height: 30),
                  generateTextField(
                      text: "Rating",
                      color: Colors.white,
                      size: 20,
                      align: TextAlign.justify,
                      weight: FontWeight.normal),
                  SizedBox(height: 30),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: generateRating(movie.voteAverage),
                      size: 40.0,
                      isReadOnly: true,
                      color: Configuration.colorApp,
                      borderColor: Configuration.colorApp,
                      spacing: 0.0),
                  SizedBox(height: 30),
                  generateTextField(
                      text: "Fecha de lanzamiento: ${movie.releaseDate}",
                      color: Colors.white,
                      size: 20,
                      align: TextAlign.start,
                      weight: FontWeight.normal),
                  SizedBox(height: 30),
                  generateTextField(
                      text: "Cast",
                      color: Colors.white,
                      size: 20,
                      align: TextAlign.center,
                      weight: FontWeight.normal),
                  SizedBox(height: 30),
                  drawList(snapshot.data),
                  SizedBox(height: 30),
                  generateTextField(
                      text: movie.adult
                          ? "No apta para niños"
                          : "Apta para todo público",
                      color: Colors.white,
                      size: 20,
                      align: TextAlign.start,
                      weight: FontWeight.bold),
                  SizedBox(height: 30),
                ],
              ),
            )
          ]);
        },
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

  Future<Video> getTrailer() async {
    apiVideo = ApiVideo(movie: movie.id);

    Video video = await apiVideo.trailer();

    return video;
  }

  Future<List<CastElement>> getCast() async {
    apiCast = ApiCast(movie: movie.id);

    List<CastElement> cast = await apiCast.cast();

    return cast;
  }

  Future<MovieExtra> prepareDetails() async {
    Video video = await getTrailer();
    List<CastElement> cast = await getCast();

    return MovieExtra(video: video, cast: cast);
  }

  Widget preparePlayer({String key}) {
    if (key != "")
      return YoutubePlayer(
          controller: generateController(key: key),
          showVideoProgressIndicator: true);
    else
      return FadeInImage(
        placeholder: AssetImage("assets/image.jpg"),
        image: NetworkImage(
            "https://image.tmdb.org/t/p/w500/${movie.backdropPath}"),
      );
  }

  YoutubePlayerController generateController({String key}) {
    return YoutubePlayerController(
      initialVideoId: key,
      flags: YoutubePlayerFlags(
          autoPlay: false, mute: false, enableCaption: false),
    );
  }

  double generateRating(double rating) {
    return rating * 5 / 10;
  }

  Widget drawList(MovieExtra snap) {
    if (snap != null) {
      return _listCast(snap.cast);
    } else
      return CircularProgressIndicator();
  }

  Widget _listCast(List<CastElement> data) {
    return Container(
      height: 260.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            CastElement character = data[index];
            return Character(character: character);
          },
          itemCount: data.length),
    );
  }
}
