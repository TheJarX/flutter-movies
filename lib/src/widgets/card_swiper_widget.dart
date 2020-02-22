import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      
      child: Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.6,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int idx) {
          movies[idx].uniqueId = '${movies[idx].id}-card';
          return Hero(
            tag: movies[idx].uniqueId,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              // borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details', arguments: movies[idx]),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    movies[idx].getPosterImg(),
                  ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                ),
              ),
            ),
          );
        },  
        itemCount: movies.length,
      ),
    );
  }
}