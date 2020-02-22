
class Movies {

  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList( List<dynamic> json ) {

    if(json == null) {
      return;
    }

    for( var item in json) {
      final movie = Movie.fromJsonMap(item);
      items.add(movie);
    }

  }

}

class Movie {

  String uniqueId;
  
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap( Map<String, dynamic> json) {

    popularity          =   json['popularity'] / 1;
    voteCount           =   json['vote_count'];
    video               =   json['video'];
    posterPath          =   json['poster_path'];
    id                  =   json['id'];
    adult               =   json['adult'];
    backdropPath        =   json['backdrop_path'];
    originalLanguage    =   json['original_language'];
    originalTitle       =   json['original_title'];
    genreIds            =   json['genre_ids'].cast<int>();
    title               =   json['title'];
    voteAverage         =   json['vote_average'] / 1;
    overview            =   json['overview'];
    releaseDate         =   json['release_date'];

  }

  getPosterImg() {
    if(posterPath == null) {
      return 'https://via.placeholder.com/200x300?text=No+Data';
    }
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  getBgImg() {
    if(backdropPath == null) {
      return 'https://www.archgard.com/assets/upload_fallbacks/image_not_found-54bf2d65c203b1e48fea1951497d4f689907afe3037d02a02dcde5775746765c.png';
    }
    return 'https://image.tmdb.org/t/p/w500$backdropPath';
  }

}

