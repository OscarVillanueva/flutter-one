import 'package:flutter/material.dart';
import 'package:login/src/assets/configuration.dart';
import 'package:login/src/database/databaseHelper.dart';
import 'package:login/src/models/Trending.dart';
import 'package:login/src/network/api_movies.dart';
import 'package:login/src/views/cardTrending.dart';

class Favorites extends StatefulWidget {
  Favorites({Key key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  ApiMovies apiMovies;
  DatabaseHelper _database;

  @override
  void initState() {
    super.initState();
    apiMovies = ApiMovies();
    _database = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        backgroundColor: Configuration.colorApp,
      ),
      body: FutureBuilder(
        future: favoritesMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<Result>> snap) {
          return drawList(snap);
        },
      ),
    );
  }

  Widget drawList(snap) {
    if (snap.data == null)
      return Center(child: Text("No has seleccionado a favoritos"));

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
            lookInDatabase: false,
          );
        },
        itemCount: data.length);
  }

  Future<List<Result>> favoritesMovies() async {
    List<Result> result = await _database.getMovies();

    return result;
  }
}
