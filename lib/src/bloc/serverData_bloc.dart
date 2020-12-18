import 'dart:io';

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
  }

  String token;
  static final ServerDataBloc _singleton = new ServerDataBloc._internal();

  factory ServerDataBloc() {
    return _singleton;
  }

  ServerDataBloc._internal() {
    serverConnect('SERVER/AUTHORIZE', 'SERVER/RESPONSE', 'REGISTER/INFO');
  }

  final _serverTagsController = new BehaviorSubject<List<Tag>>();
  final _serverTagController = new BehaviorSubject<Tag>();
  final _serverDataController = new BehaviorSubject<List<Music>>();
  final _cargandoController = new BehaviorSubject<bool>();
  final _tagController = new BehaviorSubject<String>();
  final _songController = new BehaviorSubject<Music>();
  final _tokenController = new BehaviorSubject<String>();
  final _serverRoomsController = new BehaviorSubject<List<Room>>();

  MQTTClientWrapper _serverDataProvider;
  ServerData response;

  Stream<List<Music>> get serverDataStream => _serverDataController.stream;
  Stream<List<Tag>> get serverTagsStream => _serverTagsController.stream;
  Stream<Tag> get serverTagStream => _serverTagController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
  Stream<String> get tagStream => _tagController.stream;
  Stream<Music> get songStream => _songController.stream;
  Stream<String> get tokenStream => _tokenController.stream;
  Stream<List<Room>> get serverRoomsStream => _serverRoomsController.stream;
  //String get tokenS => token;
  void serverConnect(
      String _topicIn, String _topicIn2, String _topicIn3) async {
    _serverDataProvider = MQTTClientWrapper(() async {
      if (_topicIn != 'NoSelecccionado') {
        await _serverDataProvider.subscribeToTopic(_topicIn);
        await _serverDataProvider.subscribeToTopic(_topicIn2);
        await _serverDataProvider.subscribeToTopic(_topicIn3);
        if (_serverDataProvider.subscriptionState ==
            MqttSubscriptionState.SUBSCRIBED)
          _serverDataProvider.publishData(credentials, 'APP/CREDENTIALS');
      }
    }, (ServerData data, String topic) async {
      if (data.tag != null) {
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
      } else if (data.songs.items.length > 0) {
        print(data.songs.items.length);
        print(data.songs.items);
        _serverDataController.add(data.songs.items);
        return;
      } else if (data.tags.items.length > 0) {
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
      } else if (data.rooms.items.length >= 0) {
        print(data.rooms.items.length);
        print(data.rooms.items);
        _serverRoomsController.add(data.rooms.items);

        return;
      } else if (data.status == 'INVALID' || data.status == 'LOGIN') {
        login();

        return;
      } else if (data.status == 'SUCCESS') {
        print('success');

        response = data;
        return;
      } else if (data.status == 'FAILURE') {
        print('failure here');

        response = data;
        return;
      }
    });
    await _serverDataProvider.prepareMqttClient();
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
        final resp = _serverDataProvider.publishData(postData, 'APP/UPDATE');
        await Future.delayed(Duration(seconds: 1));

        return resp;
      }
    } else {
      final postData =
          '{"TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.songName}","FIELD2":"${song.artist}","FIELD3":"${song.flName}","FIELD4":"${song.id}"}';
      final resp = _serverDataProvider.publishData(postData, 'APP/UPDATE');
      await Future.delayed(Duration(seconds: 1));

      return resp;
    }
    return false;
  }

  bool login() {
    if (_serverDataProvider.subscriptionState ==
        MqttSubscriptionState.SUBSCRIBED) {
      final resp =
          _serverDataProvider.publishData(credentials, 'APP/CREDENTIALS');
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
    _cargandoController.sink.add(true);
    _serverDataProvider.publishData(
        '{"TOKEN":"$token","TARGET":"MUSIC"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void requestTags() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    _cargandoController.sink.add(true);
    _serverDataProvider.publishData(
        '{"TOKEN":"$token","TARGET":"TAGS"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void requestRooms() async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    _cargandoController.sink.add(true);
    _serverDataProvider.publishData(
        '{"TOKEN":"$token","TARGET":"ROOMS"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  void bindSong(Music song) {
    _songController.add(song);
  }

  Future<bool> deleteSong(Music song) async {
    if (token == '' || token == null) {
      login();
      await Future.delayed(Duration(seconds: 1));
    }
    final postData =
        '{"TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.id}"}';
    final resp = _serverDataProvider.publishData(postData, 'APP/DELETE');
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
        final resp = _serverDataProvider.publishData(postData, 'APP/POST');
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
      final resp = _serverDataProvider.publishData(postData, 'APP/POST');
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
    final resp = _serverDataProvider.publishData(postData, 'APP/UPDATE');
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
    final resp = _serverDataProvider.publishData(postData, 'APP/DELETE');
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
  }
}
