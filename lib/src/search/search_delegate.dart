import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class MovieSearch extends SearchDelegate{

  String selection = '';
  MovieProvider movieProvider = new MovieProvider();

  final movies = [
    'Iron man',
    'Batman',
    'Aquaman',
    'Shazam',
    'Green Lantern',
    'Dr.Strange',
    'Star Lord',
  ];

  final fewestMovies = [
    'Spiderman',
    'Captain america'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if( query.isEmpty ) {
      return Container();
    } else {

      return FutureBuilder(
        future: movieProvider.findMovie(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if(snapshot.hasData) {

            final movies = snapshot.data;

            return ListView(
              children: movies.map( (movie) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.star_border, size: 17.0,),
                      Text(movie.voteAverage.toString())
                    ],
                  ),
                  onTap: () {
                    close(context, null);
                    movie.uniqueId = '';
                    Navigator.pushNamed(context, 'details', arguments: movie);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
      );

    }
   
  }



}