import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../features/movies_list/movies_list_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: -30.0).animate(_animationController);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      setState(() {

      });
    });
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2, // Number of tabs
          child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: primaryColor,
          title:
          searchWidget(),

        ),
        body:   Stack(
          children: [
            const TabBarView(
              children: [
                MoviesScreen(),

                Center(
                  child: Text('Content for Tab 2'),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: primaryColor,
                child:  TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black.withOpacity(0.7),
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

  Widget searchWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child:  TextField(
        focusNode: _focusNode,
        controller: _textEditingController,
        decoration: const InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          // labelText: 'Type something...',
          contentPadding: EdgeInsets.only(left: 16.0),

        ),
      ),
    );
  }
}
