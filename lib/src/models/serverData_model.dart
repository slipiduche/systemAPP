class ServerData {
    ServerData({
        this.rooms,
        this.music,
        this.tags,
    });

    List<Room> rooms;
    List<Music> music;
    List<Tag> tags;

    factory ServerData.fromJson(Map<String, dynamic> json) => ServerData(
        rooms: List<Room>.from(json["ROOMS"].map((x) => Room.fromJson(x))),
        music: List<Music>.from(json["MUSIC"].map((x) => Music.fromJson(x))),
        tags: List<Tag>.from(json["TAGS"].map((x) => Tag.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ROOMS": List<dynamic>.from(rooms.map((x) => x.toJson())),
        "MUSIC": List<dynamic>.from(music.map((x) => x.toJson())),
        "TAGS": List<dynamic>.from(tags.map((x) => x.toJson())),
    };
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