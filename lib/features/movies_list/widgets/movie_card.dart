import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/singel_movie_details_page.dart';

class MovieCard extends StatelessWidget {
  final String imageLink;
  final String movieName;
  final String movieDescription;
  final Function()? onTap;
  const MovieCard({
    Key? key,
    required this.imageLink,
    required this.movieName,
    required this.movieDescription,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Image.network('https://media.istockphoto.com/id/911590226/vector/movie-time-vector-illustration-cinema-poster-concept-on-red-round-background-composition-with.jpg?s=612x612&w=0&k=20&c=QMpr4AHrBgHuOCnv2N6mPUQEOr5Mo8lE7TyWaZ4r9oo=', fit: BoxFit.cover,)),
                ),
                const SizedBox(width: 12),
                 Expanded(
                   flex: 4,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(movieName, style: const TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 20
                       ),),
                       const SizedBox(height: 15),
                       Text(movieDescription,
                         maxLines: 3,
                         style: const TextStyle(

                           fontSize: 16
                       ),),
                    ],
                ),
                 )
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
