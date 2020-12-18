class ServerData {
  ServerData({this.status, this.token, this.songs, this.tag, this.tags});

  String status;
  String token;
  Songs songs;
  String tag;
  Tags tags;

  factory ServerData.fromJson(Map<String, dynamic> json) => ServerData(
      token: json["TOKEN"],
      status: json["STATUS"],
      songs: Songs.fromJsonList(json["MUSIC"]),
      tag: json["TAG"],
      tags: Tags.fromJsonList(json["TAGS"]));
}

class Songs {
  List<Music> items = new List();

  Songs();

  Songs.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final song = new Music.fromJson(item);
      items.add(song);
    }
  }
}

class Music {
  Music({
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

  factory Music.fromJson(Map<String, dynamic> json) => Music(
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

class Room {
  Room({
    this.id,
    this.roomName,
    this.readerId,
    this.speakerId,
  });

  int id;
  String roomName;
  String readerId;
  String speakerId;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["ID"],
        roomName: json["ROOM_NAME"],
        readerId: json["READER_ID"],
        speakerId: json["SPEAKER_ID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ROOM_NAME": roomName,
        "READER_ID": readerId,
        "SPEAKER_ID": speakerId,
      };
}

class Tags {
  List<Tag> items = new List();

  Tags();

  Tags.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final tag = new Tag.fromJson(item);
      items.add(tag);
    }
  }
}

class Tag {
  Tag({
    this.id,
    this.songId,
    this.tag,
  });

  int id;
  int songId;
  String tag;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["ID"],
        songId: json["SONG_ID"],
        tag: json["TAG"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "SONG_ID": songId,
        "TAG": tag,
      };
}
