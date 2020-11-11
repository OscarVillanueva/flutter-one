import 'dart:convert';

import "package:http/http.dart" show Client;
import 'package:login/src/enviroment/config.dart';
import 'package:login/src/models/Trending.dart';

class ApiMovies {
  final String URL_TRENDING =
      "https://api.themoviedb.org/3/movie/popular?api_key=${Keys.env["API_KEY"]}&language=en-US&page=1";
  Client http = Client();

  Future<List<Result>> getTrending() async {
    final response = await http.get(URL_TRENDING);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["results"] as List;
      List<Result> movies =
          data.map((movie) => Result.fromJSON(movie)).toList();
    } else
      return null;
  }
}
