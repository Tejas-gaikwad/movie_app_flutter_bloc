part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {

  const MoviesEvent();
  @override
  List<Object> get props => [];
}

class MoviesFetchEvent extends MoviesEvent {
  final int pagesNo;
  const MoviesFetchEvent(this.pagesNo);
  @override
  List<Object> get props => [];
}

class DeleteMoviesFromListEvent extends MoviesEvent {
  final int index;
  const DeleteMoviesFromListEvent(this.index);

  @override
  List<Object> get props => [index];
}

class SearchMovieEvent extends MoviesEvent {
  final String query;
  const SearchMovieEvent(this.query);

  @override
  List<Object> get props => [query];
}
