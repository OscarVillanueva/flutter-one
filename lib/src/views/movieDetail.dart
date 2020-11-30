import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/models/Trending.dart';
import 'package:login/src/models/Video.dart';
import 'package:login/src/network/api_videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetail extends StatelessWidget {
  final Result movie;
  ApiVideo apiVideo;
  MovieDetail({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.6),
      child: FutureBuilder(
        future: getTrailer(),
        builder: (BuildContext context, AsyncSnapshot<Video> snapshot) {
          return ListView(children: <Widget>[
            preparePlayer(key: snapshot.data != null ? snapshot.data.key : ""),
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
}
