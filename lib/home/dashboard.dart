import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/colors.dart';
import '../features/movies_list/bloc/movies_bloc.dart';
import '../features/movies_list/now_playing_screen.dart';
import '../features/movies_list/top_rated_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with SingleTickerProviderStateMixin {
  // late FocusNode _focusNode;
  // late TextEditingController _textEditingController;
  // late AnimationController _animationController;
  // late Animation<double> _animation;

  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode = FocusNode();
  //   _textEditingController = TextEditingController();
  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 300),
  //   );
  //   _animation = Tween<double>(begin: 0.0, end: -30.0).animate(_animationController);
  //
  //   _focusNode.addListener(() {
  //     if (_focusNode.hasFocus) {
  //       _animationController.forward();
  //     } else {
  //       _animationController.reverse();
  //     }
  //     setState(() {
  //
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   _textEditingController.dispose();
  //   _animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2, // Number of tabs
          child: Scaffold(
          backgroundColor: primaryColor,
            body: Stack(
            children: [
                TabBarView(
                children: [
                  BlocProvider(
                    create: (context) =>  MoviesBloc("https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")..add( const MoviesFetchEvent(1)),
                    child : NowPlayingScreen(),
                  ),

                  TopRatedScreen(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: primaryColor,
                  child:  TabBar(
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey.withOpacity(0.7),
                    tabs: const [
                      Tab( text: 'Now playing', icon: Icon(Icons.movie_creation_outlined)),
                      Tab(text: 'Top rated', icon: Icon(Icons.star_border)),
                    ],
                  ),
                ),
              ),
            ],
        ),
      ),
     ),
    ),
   );
  }


}
