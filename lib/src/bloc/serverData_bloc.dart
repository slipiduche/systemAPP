import 'dart:io';

import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/provider/mqttClientWrapper.dart';
import 'package:rxdart/rxdart.dart';

import 'package:systemAPP/src/models/serverData_model.dart';

class ServerDataBloc {
  static final ServerDataBloc _singleton = new ServerDataBloc._internal();

  factory ServerDataBloc() {
    return _singleton;
  }

  ServerDataBloc._internal() {
    serverConnect();
  }

  final _serverDataController = new BehaviorSubject<List<ServerData>>();
  final _cargandoController = new BehaviorSubject<bool>();

  MQTTClientWrapper _serverDataProvider;

  Stream<List<ServerData>> get productosStream => _serverDataController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void serverConnect() {
    _serverDataProvider = MQTTClientWrapper(() {
      _serverDataProvider.publishData(credentials, 'APP/CREDENTIALS');
    }, (dynamic data, String topic) {
      if (topic == "SERVER/AUTHORIZE") {
        print('respondio server/authorize');
        print(data);
      }
    });
    _serverDataProvider.prepareMqttClient(
        "SERVER/AUTHORIZE", "SERVER/RESPONSE");
  }

  void cargarData() async {
    // final data = await _serverDataProvider.cargarProductos();
    // _productosController.sink.add( productos );
  }

  void agregarProducto(ServerData producto) async {
    // _cargandoController.sink.add(true);
    // await _productosProvider.crearProducto(producto);
    // _cargandoController.sink.add(false);
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
