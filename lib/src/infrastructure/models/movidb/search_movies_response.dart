import 'package:cinemapedia/src/infrastructure/models/movidb/moviedb_movie.dart';


class SearchMoviesResponse {
    final int page;
    final List<MovieDbMovie> results;
    final int totalPages;
    final int totalResults;

    SearchMoviesResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory SearchMoviesResponse.fromJson(Map<String, dynamic> json) => SearchMoviesResponse(
        page: json["page"],
        results: List<MovieDbMovie>.from(json["results"].map((x) => MovieDbMovie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}