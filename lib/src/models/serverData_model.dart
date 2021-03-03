import 'package:flutter/foundation.dart';
import 'package:systemAPP/src/pages/listPlayList_page.dart';

class ServerData {
  ServerData(
      {this.status,
      this.token,
      this.songs,
      this.tag,
      this.tags,
      this.rooms,
      this.playLists,
      this.playListSongs,
      this.devices,
      this.sdefault});

  String status;
  String token;
  Songs songs;
  String tag;
  Tags tags;
  Rooms rooms;
  PlayLists playLists;
  PlayListsSongs playListSongs;
  Devices devices;
  int sdefault;


  factory ServerData.fromJson(Map<String, dynamic> json) => ServerData(
      token: json["TOKEN"],
      status: json["STATUS"],
      songs: Songs.fromJsonList(json["MUSIC"]),
      tag: json["TAG"],
      tags: Tags.fromJsonList(json["TAGS"]),
      rooms: Rooms.fromJsonList(json["ROOMS"]),
      playLists: PlayLists.fromJsonList(json["PLAYLISTS"]),
      playListSongs: PlayListsSongs.fromJsonList(json["PTX"]),
      devices: Devices.fromJsonList(json["DEVICES"]),
      sdefault: (json["DEFAULT"] != null) ? json["DEFAULT"] : null);
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
  Device({this.chipId, this.deviceName, this.type, this.status});

  String chipId;
  String deviceName;
  String type;
  String status;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        chipId: json["CHIP_ID"],
        deviceName: json["NAME"],
        type: json["TYPE"],
        status: json["STATUS"],
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
  Music(
      {this.id,
      this.songName,
      this.artist,
      this.flName,
      this.status,
      this.genre,
      this.album});

  int id;
  String songName;
  String artist;
  String flName;
  String status;
  String genre;
  String album;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
      id: json["ID"],
      songName: json["SONG_NAME"],
      artist: json["ARTIST"],
      flName: json["FL_NAME"],
      status: json["STATUS"],
      genre: json["GNRE"],
      album: json["ALBUM"]);

  Map<String, dynamic> toJson() => {
        "ID": id,
        "SONG_NAME": songName,
        "ARTIST": artist,
        "FL_NAME": flName,
        "STATUS": status,
        "GNRE": genre,
        "ALBUM": album,
      };
}

class PlayListsSongs {
  List<PlayListsSong> items = new List();
  PlayListsSongs();

  PlayListsSongs.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final song = new PlayListsSong.fromJson(item);
      items.add(song);
    }
  }
}

class PlayListsSong {
  int songId;
  int id;
  PlayListsSong({this.id, this.songId});
  factory PlayListsSong.fromJson(Map<String, dynamic> json) =>
      PlayListsSong(id: json["ID"], songId: json["SONG_ID"]);
}

class PlayLists {
  List<PlayList> items = new List();

  PlayLists();

  PlayLists.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final playlist = new PlayList.fromJson(item);
      items.add(playlist);
    }
  }
}

class PlayList {
  PlayList(
      {this.id,
      this.listName,
      this.plTableName,
      this.adTableName,
      this.ads,
      this.adMinRate,
      this.tracks,
      this.adTracks,
      this.genre});

  int id;
  String listName;
  String plTableName;
  String adTableName;
  int ads;
  int adMinRate;
  int tracks;
  int adTracks;
  String genre;

  factory PlayList.fromJson(Map<String, dynamic> json) => PlayList(
        id: json["ID"],
        listName: json["LIST_NAME"],
        plTableName: json["PL_TABLE_NAME"],
        adTableName: json["AD_TABLE_NAME"],
        ads: json["ADS"],
        adMinRate: json["AD_MIN_RATE"],
        tracks: json["TRACKS"],
        adTracks: json["ADTRACKS"],
        genre: json["GNRES"] == null ? 'Unknown' : json["GNRES"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "LIST_NAME": listName,
        "PL_TABLE_NAME": plTableName,
        "AD_TABLE_NAME": adTableName,
        "ADS": ads,
        "AD_MIN_RATE": adMinRate,
        "TRACKS": tracks,
        "ADTRACKS": adTracks,
        "GNRES": genre
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
        readerName:
            json["READER_NAME"] != null ? json["READER_NAME"] : 'noName',
        speakerName:
            json["SPEAKER_NAME"] != null ? json["SPEAKER_NAME"] : 'noName',
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
        songId: json["LIST_ID"],
        tag: json["TAG"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "LIST_ID": songId,
        "TAG": tag,
      };
}
