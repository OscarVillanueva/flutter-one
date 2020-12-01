import 'dart:convert';

import "package:http/http.dart" show Client;
import 'package:login/src/enviroment/config.dart';
import 'package:login/src/models/Cast.dart';
import 'package:login/src/models/Video.dart';

class ApiCast {
  String url_head = "https://api.themoviedb.org/3/movie/";
  int movie;
  String url_tail = "/credits?api_key=${Keys.env["API_KEY"]}&language=en-US";
  Client http = Client();

  ApiCast({this.movie});

  Future<List<CastElement>> cast() async {
    final url = "$url_head$movie$url_tail";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["cast"] as List;
      List<CastElement> cast =
          data.map((movie) => CastElement.fromJSON(movie)).toList();
      return cast;
    } else
      return null;
  }
}
