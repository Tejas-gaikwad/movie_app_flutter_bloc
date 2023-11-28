import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/movies_model.dart';
import '../../../data/repo/movies_repo_impl.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState>{

  MoviesBloc() : super(MoviesInitialState())  {

    final moviesRepo = MoviesRepoImpl();

    on<MoviesFetchEvent>((event, emit ) async {

      emit(MoviesLoadingState());

      try{
        final movieList = await moviesRepo.getMovies(event.pagesNo);

        emit(MoviesLoadedState(movies: movieList));
      }catch(error) {
        emit(MoviesErrorState(message: error.toString()));
      }
    });
  }



}