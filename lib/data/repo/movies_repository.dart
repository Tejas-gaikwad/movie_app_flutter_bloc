import 'package:movie_app/data/models/movies_model.dart';

abstract class MoviesRepo {
  Future<List<MoviesModel>> getMovies(String apiUrl, int pageNo);
}