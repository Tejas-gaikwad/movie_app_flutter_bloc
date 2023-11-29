
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_list/view/movie_view.dart';

import '../../constants/server_config.dart';
import 'bloc/movies_bloc.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Hey ->> NowPlayingScreen');
    return   BlocProvider(
      create: (context) =>  MoviesBloc(ServerConfig.nowPlayingApiUrl)..add( const MoviesFetchEvent(1)),
      child : const MovieView(),
    );
  }
}


