import 'package:movie_app/data/models/movies_model.dart';
import 'package:movie_app/data/repo/movies_repository.dart';
import 'package:movie_app/service/api/api_service_impl.dart';


class MoviesRepoImpl implements  MoviesRepo {

  @override
  Future<List<MoviesModel>> getMovies(int pageNo) async {

    final _apiService = ApiServiceImpl();

    try {
      const String url = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";

      final response = await _apiService.get(path: url, pageNo: pageNo);

      if (response.statusCode == 200) {
        final List<MoviesModel> movies = (response.data['results'] as List)
            .map((movie) => MoviesModel.fromJson(movie))
            .toList();

        return movies;
      }

      return [];
    } catch (e) {
      throw e.toString();
    }
  }
}