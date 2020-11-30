import 'dart:convert';

import "package:http/http.dart" show Client;
import 'package:login/src/enviroment/config.dart';
import 'package:login/src/models/User.dart';
import 'package:login/src/models/Video.dart';

class ApiVideo {
  String url_head = "https://api.themoviedb.org/3/movie/";
  int movie;
  String url_tail = "/videos?api_key=${Keys.env["API_KEY"]}&language=en-US";
  Client http = Client();

  ApiVideo({this.movie});

  Future<Video> trailer() async {
    final url = "$url_head$movie$url_tail";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["results"] as List;
      List<Video> movies = data.map((movie) => Video.fromJSON(movie)).toList();
      return movies.last;
    } else
      return null;
  }
}
