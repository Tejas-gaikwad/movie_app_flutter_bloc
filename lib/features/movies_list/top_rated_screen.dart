import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_list/bloc/movies_bloc.dart';
import 'package:movie_app/features/movies_list/view/movie_view.dart';

import '../../constants/server_config.dart';

class TopRatedScreen extends StatelessWidget {
  const TopRatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Hey ->> TopRatedScreen');
    return BlocProvider(
      create: (context) =>  MoviesBloc(ServerConfig.topRatedApiUrl)..add( const MoviesFetchEvent(1)),
      child: const MovieView(),
    );
  }
}
