import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/physics.dart';
import '../../../data/models/movies_model.dart';
import '../../../data/repo/movies_repo_impl.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState>{
final String apiUrl;
  MoviesBloc(this.apiUrl) : super(MoviesInitialState())  {

    List<MoviesModel> _movies = [];

    final moviesRepo = MoviesRepoImpl();

    on<MoviesFetchEvent>((event, emit ) async {

      emit(MoviesLoadingState());

      try{
        _movies = await moviesRepo.getMovies(apiUrl, event.pagesNo);
        emit(MoviesLoadedState(movies: _movies));
      }catch(error) {
        emit(MoviesErrorState(message: error.toString()));
      }
    });

    on<DeleteMoviesFromListEvent>((event, emit ) async {
      emit(MoviesLoadingState());
      try{
        _movies.removeAt(event.index);
        emit(const DeleteMoviesState(isDeleted: true));
        emit(MoviesLoadedState(movies: _movies));
      }catch(error) {
        emit(MoviesErrorState(message: error.toString()));
      }
    });

    on<SearchMovieEvent>((event, emit) async {
      emit(MoviesLoadingState());
      try{

        print('event.query ->>>  ${event.query}');
        List<MoviesModel> searchedMovies = _movies.where((movie) =>
          movie.movieName.toLowerCase().contains(event.query.toLowerCase())
       ).toList();

        print('searchedMovies  -<>>>   ${searchedMovies}');

        emit(MoviesLoadedState(movies: searchedMovies));

      } catch(error) {
        throw error.toString();
      }
    });
  }



}