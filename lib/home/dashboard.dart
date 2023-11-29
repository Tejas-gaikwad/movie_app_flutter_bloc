import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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

  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const NowPlayingScreen(),
    const TopRatedScreen(),
  ];

  @override
  void initState() {

    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1.0,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedItemColor: Colors.grey,
        backgroundColor: primaryColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
  
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Now playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Top rated',
          ),
        ],
      ),
      body: SafeArea(

          child: _tabs[_currentIndex]),




   );
  }


}
