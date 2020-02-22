class Cast {

  List<Actor> actors = new List();

  Cast.fromJsonList(List<dynamic> json) {

    if(json == null) return;

    json.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actors.add(actor);
    });

  }

}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJsonMap( Map<String, dynamic> json ) {
    this.castId = json['cast_id'];
    this.character = json['character'];
    this.creditId = json['credit_id'];
    this.gender = json['gender'];
    this.id = json['id'];
    this.name = json['name'];
    this.order = json['order'];
    this.profilePath = json['profile_path'];
  }

   getPhoto() {
    if(profilePath == null) {
      return 'https://www.kindpng.com/picc/m/22-223863_no-avatar-png-circle-transparent-png.png';
    }
    return 'https://image.tmdb.org/t/p/w500$profilePath';
  }

}
