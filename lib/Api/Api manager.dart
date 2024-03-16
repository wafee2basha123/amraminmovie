import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/movieModel.dart';
import 'ApiConstats.dart'; // Ensure ApiConstants.dart is correctly defined

class Api {
  final upComingApiUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApiUrl = "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
  final topRatedApiUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";
  final searchApiUrl = "https://api.themoviedb.org/3/search/movie?api_key=$apiKey";
  final genreApiUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey";
  final discoverApiUrl = "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey";

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(upComingApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse(popularApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final movieDetailsUrl = "https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey";

    final response = await http.get(Uri.parse(movieDetailsUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Movie.fromMap(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    final similarMoviesUrl = "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$apiKey";

    final response = await http.get(Uri.parse(similarMoviesUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to load similar movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse("$searchApiUrl&query=$query"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<List<Movie>> getMoviesByGenre(int genreId) async {
    final response = await http.get(Uri.parse("$discoverApiUrl&with_genres=$genreId"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];

      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception('Failed to fetch movies by genre');
    }
  }

  Future<List<Map<String, dynamic>>> getGenres() async {
    final response = await http.get(Uri.parse(genreApiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['genres'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to fetch genres');
    }
  }
}
