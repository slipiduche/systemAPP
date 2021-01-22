class ServerData {
  ServerData(
      {this.status,
      this.token,
      this.songs,
      this.tag,
      this.tags,
      this.rooms,
      this.devices,this.sdefault});

  String status;
  String token;
  Songs songs;
  String tag;
  Tags tags;
  Rooms rooms;
  Devices devices;
  int sdefault;

  factory ServerData.fromJson(Map<String, dynamic> json) => ServerData(
    
      token: json["TOKEN"],
      status: json["STATUS"],
      songs: Songs.fromJsonList(json["MUSIC"]),
      tag: json["TAG"],
      tags: Tags.fromJsonList(json["TAGS"]),
      rooms: Rooms.fromJsonList(json["ROOMS"]),
      devices: Devices.fromJsonList(json["DEVICES"]),
      sdefault:(json["DEFAULT"]!=null)?int.parse(json["DEFAULT"]):null);
}

class Devices {
  List<Device> items = new List();

  Devices();

  Devices.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final device = new Device.fromJson(item);
      items.add(device);
    }
  }
}

class Device {
  Device({
    this.chipId,
    this.deviceName,
    this.type,
    this.status
  });

  String chipId;
  String deviceName;
  String type;
  String status;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        chipId: json["CHIP_ID"],
        deviceName: json["NAME"],
        type: json["TYPE"],
        status:json["STATUS"],
      );

  Map<String, dynamic> toJson() => {
        "CHIP_ID": chipId,
        "NAME": deviceName,
        "TYPE": type,
      };
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

class Rooms {
  List<Room> items = new List();

  Rooms();

  Rooms.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final room = new Room.fromJson(item);
      items.add(room);
    }
  }
}

class Room {
  Room({
    this.id,
    this.roomName,
    this.readerId,
    this.speakerId,
    this.speakerName,
    this.readerName,
  });

  int id;
  String roomName;
  String readerId;
  String speakerId;
  String readerName;
  String speakerName;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["ID"],
        roomName: json["ROOM_NAME"],
        readerId: json["READER_ID"],
        speakerId: json["SPEAKER_ID"],
        readerName: json["READER_NAME"]!=null?json["READER_NAME"]:'noName',
        speakerName: json["SPEAKER_NAME"]!=null?json["SPEAKER_NAME"]:'noName',
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "ROOM_NAME": roomName,
        "READER_ID": readerId,
        "SPEAKER_ID": speakerId,
        "READER_NAME": readerName,
        "SPEAKER_NAME": speakerName,
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
