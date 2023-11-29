
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

  bool showCancelButton = false;

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        showCancelButton = true;
      }else{
        showCancelButton = false;
      }
      setState(() {});
    });
    return  BlocConsumer<MoviesBloc, MoviesState>(
      builder: (BuildContext context, MoviesState state) {
        if(state is MoviesLoadingState){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }  else if(state is MoviesLoadedState) {
          return   SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 22,color: Colors.grey,),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                onSubmitted: (value) {
                                  context.read<MoviesBloc>().add(SearchMovieEvent(_textEditingController.text));
                                },
                                focusNode: _focusNode,
                                controller: _textEditingController,
                                onChanged: (value) {
                                  context.read<MoviesBloc>().add(SearchMovieEvent(_textEditingController.text));
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _textEditingController.clear();
                                context.read<MoviesBloc>().add(const SearchMovieEvent(""));
                                FocusScope.of(context).unfocus();
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child:   const Icon(Icons.close, size: 22,color: Colors.grey,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    showCancelButton ? InkWell(
                        onTap: () {
                          _textEditingController.clear();
                          context.read<MoviesBloc>().add(const SearchMovieEvent(""));
                          FocusScope.of(context).unfocus();
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Cancel', style: TextStyle(color: Colors.grey),),
                        )) : const SizedBox()
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: MediaQuery.of(context).size.height / 1.25,
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<MoviesBloc>().add( const MoviesFetchEvent(1));
                    },
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
                  ),
                ),
              ],
            ),
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
    );
  }
}
