import 'dart:io';

import 'package:systemAPP/src/provider/mqttClientWrapper.dart';
import 'package:rxdart/rxdart.dart';

import 'package:systemAPP/src/models/serverData_model.dart';




class ServerDataBloc {

  final _serverDataController = new BehaviorSubject<List<ServerData>>();
  final _cargandoController  = new BehaviorSubject<bool>();

   MQTTClientWrapper _serverDataProvider;
   


  Stream<List<ServerData>> get productosStream => _serverDataController.stream;
  Stream<bool> get cargando => _cargandoController.stream;



  void cargarData() async {

    // final data = await _serverDataProvider.cargarProductos();
    // _productosController.sink.add( productos );
  }


  void agregarProducto( ServerData producto ) async {

    // _cargandoController.sink.add(true);
    // await _productosProvider.crearProducto(producto);
    // _cargandoController.sink.add(false);

  }

  Future<String> subirFoto( File foto ) async {

    // _cargandoController.sink.add(true);
    // final fotoUrl = await _productosProvider.subirImagen(foto);
    // _cargandoController.sink.add(false);

    // return fotoUrl;

  }


   void editarProducto( ServerData producto ) async {

    // _cargandoController.sink.add(true);
    // await _productosProvider.editarProducto(producto);
    // _cargandoController.sink.add(false);

  }

  void borrarProducto( String id ) async {

    // await _productosProvider.borrarProducto(id);

  }


  dispose() {
    _serverDataController?.close();
    _cargandoController?.close();
  }

}