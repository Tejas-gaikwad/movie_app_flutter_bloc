
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_list/bloc/movies_bloc.dart';
import 'package:movie_app/features/movies_list/view/movie_view.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({Key? key}) : super(key: key);

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Hey ->> NowPlayingScreen');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              print('value ->>>   ${value}');
              context.read<MoviesBloc>().add(SearchMovieEvent(value));
            },
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Search movies...',
              suffixIcon: const Icon(Icons.search),
              enabled: true,
              fillColor: Colors.green,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        const MovieView(),
      ],
    );
  }


}

