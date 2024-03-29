import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:get_mac/get_mac.dart';
import 'package:provider/provider.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/models/mqtt_models.dart';
import 'package:systemAPP/src/provider/mqttClientWrapper.dart';
import 'package:rxdart/rxdart.dart';

import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/provider/upload_provider.dart';

class ServerDataBloc {
  dispose() {
    _serverTagsController?.close();
    _serverTagController?.close();
    _serverDataController?.close();
    _cargandoController?.close();
    _tagController?.close();
    _songController?.close();
    _tokenController?.close();
    _defaultController?.close();
  }

  String token;
  static final ServerDataBloc _singleton = new ServerDataBloc._internal();

  factory ServerDataBloc() {
    return _singleton;
  }
  FlutterRadioPlayer songPlayer = new FlutterRadioPlayer();

  ServerDataBloc._internal() {
    apId = apIdMain;
    initRadioService();
  }
  Future<void> serverConnection() async {
    print('server......$apId');
    await serverConnect(
        'SERVER/$apId/AUTHORIZE', 'SERVER/$apId/RESPONSE', 'SERVER/INFO');
  }

  Future<void> initRadioService() async {
    await serverConnection();
    try {
      await songPlayer.init("System App", "Server",
          "http://$serverUri:8080/audio/0/default.mp3", "false");
      songPlayer.setUrl("http://$serverUri:8080/audio/0/default.mp3", "false");
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  String apId;

  String _prevTag = '';
  List<int> _ptxIds = [];
  List<int> _songIds = [];
  final _serverTagsController = new BehaviorSubject<List<Tag>>();
  final _serverTagController = new BehaviorSubject<Tag>();
  final _serverDataController = new BehaviorSubject<List<Music>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _tagController = new BehaviorSubject<String>();
  final _songController = new BehaviorSubject<Music>();
  final _tokenController = new BehaviorSubject<String>();
  final _defaultController = new BehaviorSubject<PlayList>();
  final _playListController = new BehaviorSubject<PlayList>();
  final _defaultSelController = new BehaviorSubject<PlayList>();
  final _serverRoomsController = new BehaviorSubject<List<Room>>();
  final _serverPlayListsController = new BehaviorSubject<List<PlayList>>();
  final _serverPlayListsSongController =
      new BehaviorSubject<List<PlayListsSong>>();
  final _serverDevicesController = new BehaviorSubject<List<Device>>();
  final _speakerController = new BehaviorSubject<Device>();
  final _readerController = new BehaviorSubject<Device>();
  final _roomController = new BehaviorSubject<Room>();
  final _itemSelected = new BehaviorSubject<int>();
  final _ptxIdController = new BehaviorSubject<int>();
  final _ptxIdRemoveController = new BehaviorSubject<int>();
  final _itemsSelected = new BehaviorSubject<List<int>>();

  MQTTClientWrapper serverDataProvider;
  ServerData response;
  Stream<int> get itemSelected => _itemSelected.stream;
  Stream<int> get ptxId => _ptxIdController.stream;
  Stream<int> get ptxIdRemove => _ptxIdRemoveController.stream;
  Stream<List<int>> get itemsSelected => _itemsSelected.stream;
  Stream<List<Music>> get serverDataStream => _serverDataController.stream;
  Stream<List<Tag>> get serverTagsStream => _serverTagsController.stream;
  Stream<Tag> get serverTagStream => _serverTagController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
  Stream<String> get tagStream => _tagController.stream;
  Stream<Music> get songStream => _songController.stream;
  Stream<String> get tokenStream => _tokenController.stream;
  Stream<PlayList> get defaultStream => _defaultController.stream;
  Stream<PlayList> get playListStream => _playListController.stream;
  Stream<PlayList> get defaultSelStream => _defaultSelController.stream;
  Stream<List<Room>> get serverRoomsStream => _serverRoomsController.stream;
  Stream<List<PlayList>> get serverPlayListsStream =>
      _serverPlayListsController.stream;
  Stream<List<PlayListsSong>> get serverPlayListsSongStream =>
      _serverPlayListsSongController.stream;
  Stream<List<Device>> get serverDevicesStream =>
      _serverDevicesController.stream;
  Stream<Device> get speakerStream => _speakerController.stream;
  Stream<Device> get readerStream => _readerController.stream;
  Stream<Room> get roomStream => _roomController.stream;
  final timer = Stream.periodic(Duration(seconds: 7), (int count) => count)
      .asBroadcastStream();
  //String get tokenS => token;
  Future<void> serverConnect(
      String _topicIn, String _topicIn2, String _topicIn3) async {
    serverDataProvider = MQTTClientWrapper(() async {
      if (_topicIn != 'NoSelecccionado') {
        await serverDataProvider.subscribeToTopic(_topicIn);
        await serverDataProvider.subscribeToTopic(_topicIn2);
        await serverDataProvider.subscribeToTopic(_topicIn3);
        if (serverDataProvider.subscriptionState ==
            MqttSubscriptionState.SUBSCRIBED)
          serverDataProvider.publishData(
              '$credentials"ID":"$apId"}', 'APP/CREDENTIALS');
      }
    }, (ServerData data, String topic, String dataType) async {
      if (data.tag != null) {
        print('newTag');
        if (data.tag == _prevTag) {
          return;
        } else {
          _prevTag = data.tag;
          deleteData();
          _tagController.add(data.tag);
          return;
        }
      }
      if ((data.token != null) && (data.token != '')) {
        print('respondio server/authorize');
        print(data);
        print(data.token);
        token = data.token;
        _tokenController.add(token);
        //print('request songs');
        // requestSongs();
        // await Future.delayed(Duration(seconds: 1));
        // requestTags();
        // await Future.delayed(Duration(seconds: 1));
        return;
      } else if (data.devices.items.length > 0) {
        print('devices');
        print(data.devices.items.length);
        print(data.devices.items);

        //print(_roomController.value.speakerId);
        if (_cargandoController.value) {
          data.devices.items.forEach((element) {
            if (_roomController.hasValue) {
              print('finding');
              if (element.chipId == _roomController.value.speakerId) {
                _speakerController.add(element);
              }
              if (element.chipId == _roomController.value.readerId) {
                _readerController.add(element);
              }
            }
          });
          _cargandoController.add(false);
        }
        _serverDevicesController.add(data.devices.items);
        return;
      } else if (data.songs.items.length > 0) {
        print('songs');
        print(data.songs.items.length);
        print(data.songs.items);

        _serverDataController.add(data.songs.items);
        return;
      } else if (data.tags.items.length > 0) {
        print('tags');
        print(data.tags.items.length);
        print(data.tags.items);
        _serverTagsController.add(data.tags.items);
        bool _tagExist = false;
        data.tags.items.forEach((element) {
          if (element.tag == _tagController.stream.value) {
            _tagExist = true;
            print('tag existe');
            final _songId = element.songId;
            _serverTagController.add(element);
            if (_serverPlayListsController.stream.hasValue) {
              print('hay playlists');
              _serverPlayListsController.stream.value.forEach((element) {
                print('$_songId--${element.id}');
                if (_songId == element.id) {
                  print('playlist binded with this tag');

                  _playListController.add(element);
                }
              });
            } else {
              requestPlayLists();
              return;
            }
          }
        });
        if (!_tagExist) {
          _serverTagController.add(null);
        }
        return;
      } else if (data.status == 'INVALID' || data.status == 'LOGIN') {
        login();
        await Future.delayed(Duration(seconds: 2));

        return;
      } else if (data.status == 'SUCCESS') {
        print('success');
        if (dataType == 'SUCCESS') {
          response = data;
          return;
        }
        if (dataType == "PLAYLISTS") {
          response = data;
          bool noDefault = true;
          if (data.playLists.items.length >= 0) {
            print(data.playLists.items.length);
            print(data.playLists.items);
            _serverPlayListsController.add(data.playLists.items);
            print('default:');
            print(data.sdefault);
            print(':default');

            data.playLists.items.forEach((element) {
              if (element.id == data.sdefault) {
                _defaultController.add(element);
                noDefault = false;
              }
            });
            if (noDefault) {
              _defaultController.add(PlayList(listName: 'Default'));
            }
            return;
          }
          if (noDefault) {
            _defaultController.add(PlayList(listName: 'Default'));
          }
          return;
        }
        if (dataType == 'SUCCESS') {
          response = data;
          return;
        }
        if (dataType == "PTX") {
          response = data;
          if (data.playListSongs.items.length >= 0) {
            print(data.playListSongs.items.length);
            print(data.playListSongs.items);
            _serverPlayListsSongController.add(data.playListSongs.items);

            return;
          }
          return;
        }
        if (dataType == "ROOMS") {
          response = data;
          if (data.rooms.items.length >= 0) {
            print(data.rooms.items.length);
            print(data.rooms.items);
            _serverRoomsController.add(data.rooms.items);

            return;
          }
          return;
        }
      } else if (data.status == 'FAILURE') {
        print('failure here');

        response = data;
        return;
      } else if (data.status == 'EMPTY') {
        print('EMPTY here');
        if (dataType == 'DEVICES') {
          _serverDevicesController.add([]);
          print('DEVICES');
        }
        if (dataType == 'ROOMS') {
          _serverRoomsController.add([]);
          print('ROOMS');
        }
        if (dataType == 'MUSIC') {
          _serverDataController.add([]);
          print('MUSIC');
        }
        if (dataType == 'TAGS') {
          _serverTagController.add(null);
          print('TAGS');
        }
        if (dataType == 'PLAYLISTS') {
          _serverPlayListsController.add([]);

          _defaultController.add(PlayList(listName: 'Default'));

          print('PLAYLISTS');
        }
        if (dataType == 'PTX') {
          _serverPlayListsSongController.add([]);
          print('PTX');
        }

        return;
      }
    });
    await serverDataProvider.prepareMqttClient();
  }

  void deletePrevtag() {
    _prevTag = '';
  }

  Future<int> uploadSong(audioPath, name, artist, genre) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));

      if (token != '' && token != null) {
        final resp = await UploadProvider()
            .upload(audioPath, name, artist, genre, token);
        if (resp == 2) requestSongs();
        return resp;
      }
      return 0;
    } else {
      final resp =
          await UploadProvider().upload(audioPath, name, artist, genre, token);
      if (resp == 2) requestSongs();
      return resp;
    }
  }

  Future<bool> updateSong(song) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));

      if (token != '' && token != null) {
        final postData =
            '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.songName}","FIELD2":"${song.artist}","FIELD3":"${song.genre}","FIELD4":"${song.flName}","FIELD5":${song.id}}';
        final resp = serverDataProvider.publishData(postData, 'APP/UPDATE');
        await Future.delayed(Duration(seconds: 1));

        return resp;
      }
    } else {
      final postData =
          '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.songName}","FIELD2":"${song.artist}","FIELD3":"${song.genre}","FIELD4":"${song.flName}","FIELD5":${song.id}}';
      final resp = serverDataProvider.publishData(postData, 'APP/UPDATE');
      await Future.delayed(Duration(seconds: 1));

      return resp;
    }
    return false;
  }

  Future<bool> login() async {
    if (serverDataProvider.subscriptionState ==
        MqttSubscriptionState.SUBSCRIBED) {
      final resp = serverDataProvider.publishData(
          '$credentials"AP_ID":"$apId"}', 'APP/CREDENTIALS');
      await Future.delayed(Duration(seconds: 1));
      return resp;
    } else {
      final resp = false;
      return resp;
    }

    // _productosController.sink.add( productos );
  }

  void requestSongs() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }

    serverDataProvider.publishData(
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"MUSIC"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void requestTags() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }

    serverDataProvider.publishData(
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"TAGS"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void requestRooms() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }

    serverDataProvider.publishData(
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"ROOMS"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void bindSong(Music song) {
    _songController.add(song);
  }

  void bindDefault(PlayList playList) {
    _defaultSelController.add(playList);
  }

  void bindPlayList(PlayList playList) {
    _playListController.add(playList);
  }

  void bindSpeaker(Device speaker) {
    _speakerController.add(speaker);
  }

  void bindReader(Device reader) {
    _readerController.add(reader);
  }

  void roomToModify(Room room) {
    _roomController.add(room);
  }

  void loadingEdit() {
    _cargandoController.add(true);
  }

  void bindLoading() {
    _cargandoController.add(false);
  }

  Future<bool> deleteSong(Music song) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"MUSIC","FIELD1":${song.id}}';
    final resp = serverDataProvider.publishData(postData, 'APP/DELETE');
    //await Future.delayed(Duration(seconds: 1));
    return resp;
  }

  Future<bool> addTag(String tag, String songId) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
      if (token != '' && token != null) {
        final postData =
            '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"TAGS","FIELD1":"$tag","FIELD2":$songId,"FIELD3":false}';
        final resp = serverDataProvider.publishData(postData, 'APP/POST');
        await Future.delayed(Duration(seconds: 1));
        if (response.status != null) {
          if (response.status == 'SUCCESS') {
            return resp;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }
    } else {
      final postData =
          '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"TAGS","FIELD1":"$tag","FIELD2":$songId,"FIELD3":false}';
      final resp = serverDataProvider.publishData(postData, 'APP/POST');
      await Future.delayed(Duration(seconds: 1));
      if (response.status != null) {
        if (response.status == 'SUCCESS') {
          return resp;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  Future<bool> editTag(String songId, String tagId) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"TAGS","FIELD1":$songId,"FIELD2":false,"FIELD3":$tagId}';
    final resp = serverDataProvider.publishData(postData, 'APP/UPDATE');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> changeDefault(String songId) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData = '{"AP_ID":"$apId","TOKEN":"$token","ID":$songId}';
    final resp = serverDataProvider.publishData(postData, 'APP/DEFAULT');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  deleteTag(String tagId) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"TAGS","FIELD1":$tagId}';
    final resp = serverDataProvider.publishData(postData, 'APP/DELETE');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void deleteData() {
    _serverTagController.add(null);
    _serverTagsController.add(null);
    _songController.add(null);
    _tagController.add(null);
    _serverDataController.add(null);
    _speakerController.add(null);
    _readerController.add(null);
    _roomController.add(null);
    _defaultController.add(null);
    _playListController.add(null);
    _defaultSelController.add(null);
    _serverDevicesController.add(null);
    _serverPlayListsSongController.add(null);
  }

  void deleteRoomDevices() {
    _serverDevicesController.add(null);
    _speakerController.add(null);
    _readerController.add(null);
  }

  void deleteRoomSpeaker() {
    _serverDevicesController.add(null);
    _speakerController.add(null);
  }

  void deleteRoomReader() {
    _serverDevicesController.add(null);
    _readerController.add(null);
  }

  void requestDevices() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData = '{"AP_ID":"$apId","REQUEST":"INFO"}';
    final resp = serverDataProvider.publishData(postData, 'APP/INFO');
    await Future.delayed(Duration(seconds: 5));
    // if (response.status != null) {
    //   if (response.status == 'SUCCESS') {
    //     return resp;
    //   } else {
    //     return false;
    //   }
    // } else {
    //   return false;
    // }
  }

  Future<bool> addRoom(String roomName, String speakerId, String readerId,
      String speakerName, String readerName) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"ROOMS","FIELD1":"$roomName","FIELD2":"$readerId","FIELD3":"$speakerId","FIELD4":"$readerName","FIELD5":"$speakerName"}';
    final resp = serverDataProvider.publishData(postData, 'APP/POST');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> editRoom(String roomName, String speakerId, String readerId,
      String speakerName, String readerName, String roomId) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"ROOMS","FIELD1":"$roomName","FIELD2":"$readerId","FIELD3":"$speakerId","FIELD4":"$readerName","FIELD5":"$speakerName","FIELD6":"$roomId"}';
    final resp = serverDataProvider.publishData(postData, 'APP/UPDATE');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> deleteRoom(Room room) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"ROOMS","FIELD1":${room.id}}';
    final resp = serverDataProvider.publishData(postData, 'APP/DELETE');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void requestPlayLists() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }

    serverDataProvider.publishData(
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"PLAYLISTS"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void requestPlayListsSong(PlayList playList) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }

    serverDataProvider.publishData(
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"${playList.plTableName}"}',
        'APP/GET');
    //_cargandoController.sink.add(false);
  }

  Future<bool> createPlayList(String listName) async {
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"PLAYLISTS","FIELD1":"$listName","FIELD2":"FALSE","FIELD3":null,"FIELD4":null,"FIELD5":null}';
    final resp = serverDataProvider.publishData(postData, 'APP/POST');
    await Future.delayed(Duration(seconds: 2));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> renamePlayList(String newname, PlayList playList) async {
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"PLAYLISTS","FIELD1":"$newname","FIELD2":"FALSE","FIELD3":${playList.id}}';
    final resp = serverDataProvider.publishData(postData, 'APP/UPDATE');
    await Future.delayed(Duration(seconds: 2));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> deletePlayList(PlayList playList) async {
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"PLAYLISTS","FIELD1":${playList.id}}';
    final resp = serverDataProvider.publishData(postData, 'APP/DELETE');
    await Future.delayed(Duration(seconds: 2));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addSongToPlayList(PlayList playList, List<int> songIds) async {
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"${playList.plTableName}","FIELD1":$songIds}';
    final resp = serverDataProvider.publishData(postData, 'APP/POST');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> addSongsToPlayList(PlayList playList) async {
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"${playList.plTableName}","FIELD1":$_songIds}';
    final resp = serverDataProvider.publishData(postData, 'APP/POST');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> deleteSongFromPlayList(PlayList playList) async {
    final postData =
        '{"AP_ID":"$apId","TOKEN":"$token","TARGET":"${playList.plTableName}","FIELD1":$_ptxIds}';
    final resp = serverDataProvider.publishData(postData, 'APP/DELETE');
    await Future.delayed(Duration(seconds: 1));
    if (response.status != null) {
      if (response.status == 'SUCCESS') {
        return resp;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void itemAdd(int item) {
    _itemSelected.add(item);
  }

  void itemDelete() {
    _itemSelected.add(null);
  }

  void itemsAdd(List<int> items) {
    _itemsSelected.add(items);
  }

  List<int> getPtxIds() {
    return _ptxIds;
  }

  List<int> getSongIds() {
    return _songIds;
  }

  void addPtxIds(List<int> ptxIds) {
    _ptxIds = ptxIds;
    print(_ptxIds);
  }

  void removeAllPtxs() {
    _ptxIds = [];
    print('lista de ptx vacía');
    print(_ptxIds);
  }

  void ptxIdAdd(int ptxId) {
    // _ptxIdController.add(ptxId);
    _ptxIds.add(ptxId);
    print('ptx add: $_ptxIds');
  }

  void removePtxId(int ptxId) {
    _ptxIds.remove(ptxId);
    print('ptx delete: $_ptxIds');
  }

  void addSongsIds(List<int> songIds) {
    _songIds = songIds;
    print('songs add: $_songIds');
  }

  void removeAllSongs() {
    _songIds = [];
    print('lista de songs vacía');
    print(_songIds);
  }

  void songIdAdd(int songId) {
    // _ptxIdController.add(ptxId);
    _songIds.add(songId);
    print('songs add: $_songIds');
  }

  void removeSongId(int songId) {
    _songIds.remove(songId);
    print('songs remove: $_songIds');
  }
}
