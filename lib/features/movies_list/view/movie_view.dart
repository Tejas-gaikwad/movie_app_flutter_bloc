
import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_list/bloc/movies_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_list/view/singel_movie_details_page.dart';

import '../widgets/movie_card.dart';

class MovieView extends StatelessWidget {
  const MovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MoviesBloc, MoviesState>(
      builder: (BuildContext context, MoviesState state) {
        if(state is MoviesLoadingState){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
       else if(state is MoviesLoadedState) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.2,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                  return MovieCard(
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
              ),

            ],
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
        // if (state is ProductAddToCartErrorState) {
        //   addToCartDialog(context, state.message);
        // }
      },

    );
  }
}