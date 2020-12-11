import 'dart:io';

import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/models/mqtt_models.dart';
import 'package:systemAPP/src/provider/mqttClientWrapper.dart';
import 'package:rxdart/rxdart.dart';

import 'package:systemAPP/src/models/serverData_model.dart';

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
      } else {
        print('maybe rooms');
      }
    });
    await _serverDataProvider.prepareMqttClient();
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

  Future<String> subirFoto(File foto) async {
    // _cargandoController.sink.add(true);
    // final fotoUrl = await _productosProvider.subirImagen(foto);
    // _cargandoController.sink.add(false);

    // return fotoUrl;
  }

  void editarProducto(ServerData producto) async {
    // _cargandoController.sink.add(true);
    // await _productosProvider.editarProducto(producto);
    // _cargandoController.sink.add(false);
  }

  void borrarProducto(String id) async {
    // await _productosProvider.borrarProducto(id);
  }

  dispose() {
    _serverDataController?.close();
    _cargandoController?.close();
  }
}
