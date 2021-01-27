import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
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
    serverConnect('SERVER/AUTHORIZE', 'SERVER/RESPONSE', 'SERVER/INFO');
    initRadioService();
  }
  Future<void> initRadioService() async {
    try {
      await songPlayer.init("Flutter Radio Example", "Live",
          "http://$serverUri:8080/audio/0/default.mp3", "false");
      songPlayer.setUrl("http://$serverUri:8080/audio/0/default.mp3", "false");
    } on PlatformException {
      print("Exception occurred while trying to register the services.");
    }
  }

  final _serverTagsController = new BehaviorSubject<List<Tag>>();
  final _serverTagController = new BehaviorSubject<Tag>();
  final _serverDataController = new BehaviorSubject<List<Music>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _tagController = new BehaviorSubject<String>();
  final _songController = new BehaviorSubject<Music>();
  final _tokenController = new BehaviorSubject<String>();
  final _defaultController = new BehaviorSubject<Music>();
  final _serverRoomsController = new BehaviorSubject<List<Room>>();
  final _serverDevicesController = new BehaviorSubject<List<Device>>();
  final _speakerController = new BehaviorSubject<Device>();
  final _readerController = new BehaviorSubject<Device>();
  final _roomController = new BehaviorSubject<Room>();

  MQTTClientWrapper serverDataProvider;
  ServerData response;

  Stream<List<Music>> get serverDataStream => _serverDataController.stream;
  Stream<List<Tag>> get serverTagsStream => _serverTagsController.stream;
  Stream<Tag> get serverTagStream => _serverTagController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
  Stream<String> get tagStream => _tagController.stream;
  Stream<Music> get songStream => _songController.stream;
  Stream<String> get tokenStream => _tokenController.stream;
  Stream<Music> get defaultStream => _defaultController.stream;
  Stream<List<Room>> get serverRoomsStream => _serverRoomsController.stream;
  Stream<List<Device>> get serverDevicesStream =>
      _serverDevicesController.stream;
  Stream<Device> get speakerStream => _speakerController.stream;
  Stream<Device> get readerStream => _readerController.stream;
  Stream<Room> get roomStream => _roomController.stream;
  final timer = Stream.periodic(Duration(seconds: 7), (int count) => count)
      .asBroadcastStream();
  //String get tokenS => token;
  void serverConnect(
      String _topicIn, String _topicIn2, String _topicIn3) async {
    serverDataProvider = MQTTClientWrapper(() async {
      if (_topicIn != 'NoSelecccionado') {
        await serverDataProvider.subscribeToTopic(_topicIn);
        await serverDataProvider.subscribeToTopic(_topicIn2);
        await serverDataProvider.subscribeToTopic(_topicIn3);
        if (serverDataProvider.subscriptionState ==
            MqttSubscriptionState.SUBSCRIBED)
          serverDataProvider.publishData(credentials, 'APP/CREDENTIALS');
      }
    }, (ServerData data, String topic, String dataType) async {
      if (data.tag != null) {
        print('newTag');
        deleteData();
        _tagController.add(data.tag);
        return;
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
        print('default:');
        print(data.sdefault);
        print(':default');
        data.songs.items.forEach((element) {
          if (element.id == data.sdefault) {
            _defaultController.add(element);
          }
        });

        _serverDataController.add(data.songs.items);
        return;
      } else if (data.tags.items.length > 0) {
        print('tags');
        print(data.tags.items.length);
        print(data.tags.items);
        _serverTagsController.add(data.tags.items);
        data.tags.items.forEach((element) {
          if (element.tag == _tagController.stream.value) {
            final _songId = element.songId;
            _serverTagController.add(element);
            _serverDataController.stream.value.forEach((element) {
              if (_songId == element.id) {
                _songController.add(element);
              }
            });
          }
        });
        return;
      } else if (data.status == 'INVALID' || data.status == 'LOGIN') {
        login();
        await Future.delayed(Duration(seconds: 2));

        return;
      } else if (data.status == 'SUCCESS') {
        print('success');

        response = data;
        if (data.rooms.items.length >= 0) {
          print(data.rooms.items.length);
          print(data.rooms.items);
          _serverRoomsController.add(data.rooms.items);

          return;
        }
        return;
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

        return;
      }
    });
    await serverDataProvider.prepareMqttClient();
  }

  Future<int> uploadSong(audioPath, name) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));

      if (token != '' && token != null) {
        final resp = await UploadProvider().upload(audioPath, name, token);
        if (resp == 2) requestSongs();
        return resp;
      }
      return 0;
    } else {
      final resp = await UploadProvider().upload(audioPath, name, token);
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
            '{"TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.songName}","FIELD2":"${song.artist}","FIELD3":"${song.flName}","FIELD4":"${song.id}"}';
        final resp = serverDataProvider.publishData(postData, 'APP/UPDATE');
        await Future.delayed(Duration(seconds: 1));

        return resp;
      }
    } else {
      final postData =
          '{"TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.songName}","FIELD2":"${song.artist}","FIELD3":"${song.flName}","FIELD4":"${song.id}"}';
      final resp = serverDataProvider.publishData(postData, 'APP/UPDATE');
      await Future.delayed(Duration(seconds: 1));

      return resp;
    }
    return false;
  }

  Future<bool> login() async {
    if (serverDataProvider.subscriptionState ==
        MqttSubscriptionState.SUBSCRIBED) {
      final resp =
          serverDataProvider.publishData(credentials, 'APP/CREDENTIALS');
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
        '{"TOKEN":"$token","TARGET":"MUSIC"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void requestTags() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }

    serverDataProvider.publishData(
        '{"TOKEN":"$token","TARGET":"TAGS"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void requestRooms() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }

    serverDataProvider.publishData(
        '{"TOKEN":"$token","TARGET":"ROOMS"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void bindSong(Music song) {
    _songController.add(song);
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
        '{"TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.id}"}';
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
            '{"TOKEN":"$token","TARGET":"TAGS","FIELD1":"$tag","FIELD2":"$songId"}';
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
          '{"TOKEN":"$token","TARGET":"TAGS","FIELD1":"$tag","FIELD2":"$songId"}';
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
        '{"TOKEN":"$token","TARGET":"TAGS","FIELD1":"$songId","FIELD2":"$tagId"}';
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
    final postData = '{"TOKEN":"$token","ID":"$songId"}';
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
    final postData = '{"TOKEN":"$token","TARGET":"TAGS","FIELD1":"$tagId"}';
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
  }

  void deleteRoomDevices() {
    _speakerController.add(null);
    _readerController.add(null);
  }

  void requestDevices() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData = '{"REQUEST":"INFO"}';
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
        '{"TOKEN":"$token","TARGET":"ROOMS","FIELD1":"$roomName","FIELD2":"$readerId","FIELD3":"$speakerId","FIELD4":"$readerName","FIELD5":"$speakerName"}';
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
        '{"TOKEN":"$token","TARGET":"ROOMS","FIELD1":"$roomName","FIELD2":"$readerId","FIELD3":"$speakerId","FIELD4":"$readerName","FIELD5":"$speakerName","FIELD6":"$roomId"}';
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
        '{"TOKEN":"$token","TARGET":"ROOMS","FIELD1":"${room.id}"}';
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
}
