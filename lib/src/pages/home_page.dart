import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';
import 'package:peliculas/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {

  final MovieProvider prov = MovieProvider();

  @override
  Widget build(BuildContext context) {

    prov.getPopular();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("In theaters"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: MovieSearch(),
              );
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _showSlider(),
            _showFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _showSlider() {
    return FutureBuilder(
      future: prov.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data,
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 150.0),
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
  }

  Widget _showFooter(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30.0, top: 10.0),
            child: Text(
              "Popular", 
              style: Theme.of(context).textTheme.subhead
            )
          ),
          SizedBox(height: 10.0,),
          StreamBuilder(
            stream: prov.popularStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData) {
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: prov.getPopular,
                );
              } else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      width: double.infinity,
    );
  }


  

}