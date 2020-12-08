// Generated by https://quicktype.io

class Trending {
  int page;
  int totalResults;
  int totalPages;
  List<Result> results;

  Trending({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });
}

class Result {
  String posterPath;
  int id;
  String backdropPath;
  String title;
  bool adult;
  double voteAverage;
  String overview;
  String releaseDate;
  bool favorite = false;

  Result({
    this.posterPath,
    this.id,
    this.backdropPath,
    this.title,
    this.voteAverage,
    this.overview,
    this.adult,
    this.releaseDate,
  });

  factory Result.fromJSON(Map<String, dynamic> movie) {
    return Result(
        posterPath: movie["poster_path"],
        id: movie["id"],
        backdropPath: movie["backdrop_path"],
        title: movie["title"],
        adult: movie["adult"],
        voteAverage: movie["vote_average"] is int
            ? (movie["vote_average"] as int).toDouble()
            : movie["vote_average"],
        overview: movie["overview"],
        releaseDate: movie["release_date"]);
  }

  factory Result.fromJSONWithFavorite(Map<String, dynamic> movie) {
    Result result = Result(
        posterPath: movie["posterPath"],
        id: movie["id"],
        backdropPath: movie["backdropPath"],
        title: movie["title"],
        adult: movie["adult"] == 1 ? true : false,
        voteAverage: movie["voteAverage"] is int
            ? (movie["voteAverage"] as int).toDouble()
            : movie["voteAverage"],
        overview: movie["overview"],
        releaseDate: movie["releaseDate"]);
    result.favorite = movie["favorite"] == 1 ? true : false;
    return result;
  }

  Map<String, dynamic> toFullJSON() {
    return {
      "posterPath": posterPath,
      "id": id,
      "backdropPath": backdropPath,
      "title": title,
      "voteAverage": voteAverage,
      "releaseDate": releaseDate,
      "adult": adult ? 1 : 0,
      "overview": overview,
      "favorite": favorite ? 1 : 0
    };
  }
}
