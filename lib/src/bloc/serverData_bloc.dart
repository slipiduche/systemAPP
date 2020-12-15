import 'dart:io';

import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/models/mqtt_models.dart';
import 'package:systemAPP/src/provider/mqttClientWrapper.dart';
import 'package:rxdart/rxdart.dart';

import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/provider/upload_provider.dart';

class ServerDataBloc {
  String token;
  static final ServerDataBloc _singleton = new ServerDataBloc._internal();

  factory ServerDataBloc() {
    return _singleton;
  }

  ServerDataBloc._internal() {
    serverConnect("SERVER/AUTHORIZE", "SERVER/RESPONSE");
  }

  final _serverDataController = new BehaviorSubject<List<Music>>();
  final _cargandoController = new BehaviorSubject<bool>();

  MQTTClientWrapper _serverDataProvider;

  Stream<List<Music>> get serverDataStream => _serverDataController.stream;
  Stream<bool> get cargando => _cargandoController.stream;
  //String get tokenS => token;
  void serverConnect(String _topicIn, String _topicIn2) async {
    _serverDataProvider = MQTTClientWrapper(() async {
      if (_topicIn != 'NoSelecccionado') {
        await _serverDataProvider.subscribeToTopic(_topicIn);
        await _serverDataProvider.subscribeToTopic(_topicIn2);
        if (_serverDataProvider.subscriptionState ==
            MqttSubscriptionState.SUBSCRIBED)
          _serverDataProvider.publishData(credentials, 'APP/CREDENTIALS');
      }
    }, (ServerData data, String topic) {
      if ((data.token != null) && (data.token != '')) {
        print('respondio server/authorize');
        print(data);
        print(data.token);
        token = data.token;
        print('request songs');
        requestSongs();
        return;
      } else if (data.status != 'SUCCESS') {
        print(data.status);
        return;
      } else if (data.songs.items.length > 0) {
        print(data.songs.items.length);
        print(data.songs.items);
        _serverDataController.add(data.songs.items);
        return;
      } else if (data.status == 'INVALID' || data.status == 'LOGIN') {
        login();
        return;
      } else if (data.status == 'SUCCESS') {
        print('success');
        requestSongs();
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
    final postData =
        '{"TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.songName}","FIELD2":"${song.artist}","FIELD3":"${song.flName}","FIELD4":"${song.id}"}';
    final resp = _serverDataProvider.publishData(postData, 'APP/UPDATE');
    await Future.delayed(Duration(seconds: 1));
    requestSongs();
    return resp;
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
    _cargandoController.sink.add(true);
    _serverDataProvider.publishData(
        '{"TOKEN":"$token","TARGET":"MUSIC"}', 'APP/GET');
    //_cargandoController.sink.add(false);
  }

  dispose() {
    _serverDataController?.close();
    _cargandoController?.close();
  }

  Future<bool> deleteSong(Music song) async {
    final postData =
        '{"TOKEN":"$token","TARGET":"MUSIC","FIELD1":"${song.id}"}';
    final resp = _serverDataProvider.publishData(postData, 'APP/DELETE');
    //await Future.delayed(Duration(seconds: 1));
    return resp;
  }
}
