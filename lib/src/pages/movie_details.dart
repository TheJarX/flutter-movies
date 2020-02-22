import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class MovieDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return  Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _createAppbar(context, movie),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.0,),
                _posterTitle(context, movie),
                _description(context, movie),
                _description(context, movie),
                _description(context, movie),
                _description(context, movie),
                _description(context, movie),
                _description(context, movie),
                _description(context, movie),
                _casting(movie)
              ]),
            ),
          ],
        )
      );
  }

  Widget _createAppbar(BuildContext context, Movie movie) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        tooltip: 'Go back',
        onPressed: () => Navigator.pop(context),
      ),
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'),
          image: NetworkImage(movie.getBgImg()),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(
                      movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subhead,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Overview:',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
          SizedBox(height: 20.0,),
          Text(
            movie.overview,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _casting(Movie movie) {
    final movieProv = new MovieProvider();

    return FutureBuilder(
      future: movieProv.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if( snapshot.hasData) {
          return _actorsPage(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _actorsPage(List<Actor> actors) {

     return SizedBox(
       height: 200.0,
       child: PageView.builder(
         pageSnapping: false,
         itemCount: actors.length,
         controller: PageController(
           initialPage: 1,
           viewportFraction: 0.35,
         ),
         itemBuilder: (context, i) => _actorCard(actors[i])
      ),
     ) ;

  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              width: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}