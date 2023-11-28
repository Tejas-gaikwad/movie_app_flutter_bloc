import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_list/bloc/movies_bloc.dart';
import 'package:movie_app/features/movies_list/view/movie_view.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Hey ->> MoviesScreen');
    return BlocProvider(
        create: (context) =>  MoviesBloc()..add( MoviesFetchEvent(1)),

      child: const MovieView(),
    );
  }
}
