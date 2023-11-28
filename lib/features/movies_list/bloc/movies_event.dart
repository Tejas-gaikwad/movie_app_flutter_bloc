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
