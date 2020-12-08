import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/models/Trending.dart';
import 'package:login/src/network/api_movies.dart';
import 'package:login/src/views/cardTrending.dart';

class Trending extends StatefulWidget {
  Trending({Key key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  ApiMovies apiMovies;

  @override
  void initState() {
    super.initState();
    apiMovies = ApiMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tendencias"),
        backgroundColor: Configuration.colorApp,
      ),
      body: FutureBuilder(
        future: apiMovies.getTrending(),
        builder: (BuildContext context, AsyncSnapshot<List<Result>> snap) {
          return drawList(snap);
        },
      ),
    );
  }

  Widget drawList(snap) {
    if (snap.hasError) {
      return Center(
        child: Text("Hubo un error"),
      );
    } else if (snap.connectionState == ConnectionState.done) {
      return _listTrending(snap.data);
    } else
      return Center(child: CircularProgressIndicator());
  }

  Widget _listTrending(List<Result> data) {
    return ListView.builder(
        itemBuilder: (context, index) {
          Result movie = data[index];
          return CardTrending(
            movie: movie,
            lookInDatabase: true,
          );
        },
        itemCount: data.length);
  }
}
