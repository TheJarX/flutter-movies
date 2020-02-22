import 'package:flutter/material.dart';

import 'package:peliculas/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;

  final Function nextPage;

  BoxDecoration _cardDecoration = BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.10), 
                      offset: Offset(0.0, 7.0),
                      spreadRadius: 0.5,
                      blurRadius: 7.0
                    ),
                  ],
                ); 

  MovieHorizontal({@required this.movies, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.28
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if( _pageController.position.pixels >= 
          _pageController.position.maxScrollExtent - 200) {
            nextPage();
      }
    }) ;

    return Container(
      height: _screenSize.height * 0.25,  
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards(context),
        itemCount: movies.length,
        itemBuilder: (context, i) =>  _card(context, movies[i]),
      ),
    );
  }
  // ! TODO: Optimize this widget
  Widget _card(BuildContext context, Movie movie) {

    movie.uniqueId = '${movie.id}-poster';

    final card = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: Container(
                decoration: _cardDecoration,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    fadeInCurve: Curves.easeIn,
                    fadeOutCurve: Curves.easeInOut,
                    fadeInDuration: Duration(milliseconds: 600),
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              movie.title, 
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );

      return GestureDetector(
        child: card,
        onTap: (){
          Navigator.pushNamed(
            context, 'details',
            arguments: movie
          );
        },
      );
  }

// TODO: Remove this method
  List<Widget> _cards(BuildContext context) {
    return movies.map( (movie) {
      return _card(context, movie);
    }).toList();
  }
}