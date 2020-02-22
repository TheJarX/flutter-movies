import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/models/actor_model.dart';

class MovieProvider {

  String _apiKey = '9f986268a239771c590c57a3b3b6f4b1';
  String _url = 'api.themoviedb.org';
  String _lang = 'es-ES';
  int _currentPopular = 0;
  bool _loading = false;

  List<Movie> _popular = [];

  final _popularStreamCtrl = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>)get popularSink => _popularStreamCtrl.sink.add;

  Stream<List<Movie>>get popularStream => _popularStreamCtrl.stream;


  void disposeStreams() {
    _popularStreamCtrl?.close();
  }

  Future<List<Movie>> processResponse(Uri url) async{
    final res = await http.get(url);
    return new Movies.fromJsonList(json.decode(res.body)['results']).items;
  }


  Future<List<Movie>> getInTheaters() async{

    final url = Uri.https(_url, '3/movie/now_playing',<String, String>{
      'api_key'   : _apiKey,
      'language'  : _lang
    });
    return await processResponse(url);
  }

  Future<List<Movie>> getPopular() async{

    if( _loading ) return [];

    _loading = true;
    _currentPopular++;

    final url = Uri.https(_url, '3/movie/popular',<String, String>{
      'api_key'   : _apiKey,
      'language'  : _lang,
      'page'      : _currentPopular.toString()
    });

    final res =  await processResponse(url);

    _popular.addAll(res);

    popularSink(_popular);

    _loading = false;

    return res;

  }

  Future<List<Actor>> getCast(String movieId) async{
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key'   : _apiKey,
      'language'  : _lang,
    });

    final res = await http.get(url);
    final decodedData = json.decode(res.body);

    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;

  }

   Future<List<Movie>> findMovie(String query) async{

    final url = Uri.https(_url, '3/search/movie',<String, String>{
      'api_key'   : _apiKey,
      'language'  : _lang,
      'query'     : query
    });
    return await processResponse(url);
  }
}