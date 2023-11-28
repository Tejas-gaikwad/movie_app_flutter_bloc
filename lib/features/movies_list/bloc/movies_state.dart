part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];

}

final class MoviesInitialState extends MoviesState {}

final class MoviesLoadingState extends MoviesState{

}

final class MoviesLoadedState extends MoviesState{
  final List<MoviesModel> movies;

  const MoviesLoadedState({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class DeleteMoviesState extends MoviesState{
  final bool isDeleted ;
  const DeleteMoviesState({required this.isDeleted});

  @override
  List<Object> get props => [isDeleted];
}

final class MoviesErrorState extends MoviesState {
  final String message;

  const MoviesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class SearchListState extends MoviesState {
  final String query;
  const SearchListState({required this.query});
  @override
  List<Object> get props => [query];
}