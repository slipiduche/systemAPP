class Songs {

  List<Song> items = new List();

  Songs();

  Songs.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final pelicula = new Song.fromJson(item);
      items.add( pelicula );
    }

  }

}
class Song {
    Song({
        this.id,
        this.songName,
        this.artist,
        this.flName,
        this.status,
    });

    int id;
    String songName;
    String artist;
    String flName;
    String status;

    factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["ID"],
        songName: json["SONG_NAME"],
        artist: json["ARTIST"],
        flName: json["FL_NAME"],
        status: json["STATUS"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "SONG_NAME": songName,
        "ARTIST": artist,
        "FL_NAME": flName,
        "STATUS": status,
    };
}
