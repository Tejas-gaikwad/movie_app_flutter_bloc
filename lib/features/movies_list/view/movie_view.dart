
import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_list/bloc/movies_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_list/view/singel_movie_details_page.dart';

import '../widgets/movie_card.dart';

class MovieView extends StatefulWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
     _focusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        BlocConsumer<MoviesBloc, MoviesState>(
          builder: (BuildContext context, MoviesState state) {
            if(state is MoviesLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }  else if(state is MoviesLoadedState) {
              return   Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                height: MediaQuery.of(context).size.height / 1.2,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(
                      onDismissed: (direction) {
                         context.read<MoviesBloc>().add(DeleteMoviesFromListEvent(index));
                       },
                      onDeleteTap: () {
                        context.read<MoviesBloc>().add( DeleteMoviesFromListEvent(index));
                      },
                      onTap:   () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return SingelMovieDetailsPage(movieData: state.movies[index],);
                        },));
                      },
                      imageLink: state.movies[index].movieImageLink,
                      movieName: state.movies[index].movieName,
                      movieDescription: state.movies[index].movieDescription,
                    );
                  },),
              );
            } else if (state is MoviesErrorState) {
              return const Center(
                child: Text('Error loading products'),
              );
            } else {
              return Container();
            }
          },
          listener: (BuildContext context, MoviesState state) {
            if (state is DeleteMoviesState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Movie deleted successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
