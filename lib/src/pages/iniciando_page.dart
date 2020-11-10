import 'dart:ui';

import 'package:systemAPP/constants.dart';

import 'package:systemAPP/src/bloc/error_bloc.dart';
import 'package:systemAPP/src/models/dispositivos_model.dart';
import 'package:systemAPP/src/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/src/share_prefs/preferencias_usuario.dart';

class IniciandoPage extends StatefulWidget {
  @override
  _IniciandoPageState createState() => _IniciandoPageState();
}

class _IniciandoPageState extends State<IniciandoPage> {
  final prefs = new PreferenciasUsuario();

  final errorBloc = ErrorBloc();
  int _ruta;
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: _rutaInicial(context),
    );
  }

  Widget _rutaInicial(BuildContext context) {
    return StreamBuilder(
        stream: errorBloc.ErrorStream,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => onAfterBuild(context));
          print('redibujando');
          if (!snapshot.hasData) {
            //dispBloc.obtenerDispositivos();
            _ruta = 0;
            return _iniciandoPage(context);
          } else {
            final _error = snapshot.data;
            if (_error.length == 0) {
              //dispBloc.obtenerDispositivos();
              _ruta = 0;
              return _iniciandoPage(context);
            }
            if ((_error.length > 2) && (_ruta != 5)) {
              if ((prefs.token != '') && (_error["Error"] != true)) {
                if (prefs.dispositivoSeleccionado != null) {
                  // Navigator.pop(context);
                  //Navigator.pushReplacementNamed(context, 'homePage');
                  _ruta = 1;
                  return _iniciandoPage(context); //HomePage();
                } else {
                  // Navigator.pop(context);
                  //Navigator.pushReplacementNamed(context, 'perfilPage');
                  _ruta = 2;
                  return _iniciandoPage(context); //PerfilPage();
                }
              } else {
                //Navigator.pop(context);
                _ruta = 3;
                return _iniciandoPage(context); //LoginPage();
              }
            } else {
              _ruta = 3;
              return _iniciandoPage(context); //LoginPage();
            }
          }
        });
  }

  Widget _iniciandoPage(BuildContext context) {
    //dispBloc.obtenerDispositivos();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: colorMedico,
            gradient: LinearGradient(
                colors: [colorMedico3, colorMedico2, colorMedico1, colorMedico],
                stops: [0.0, 0.651, 0.9999, 1.0],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: Container()),
            GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'iniciandoPage');
                },
                child: Image(
                  image: AssetImage('assets/ORBITTAS-03.png'),
                )),
            Text(
              'STARTING',
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  onAfterBuild(BuildContext context) async {
    print('ruta:$_ruta');
    if (_ruta == 1) {
      _ruta = 5;
      Navigator.pushReplacementNamed(context, 'homePage');
    } else if (_ruta == 2) {
      _ruta = 5;
      Navigator.pushReplacementNamed(context, 'perfilPage');
    } else if (_ruta == 3) {
      _ruta = 5;
      Navigator.pushReplacementNamed(context, 'loginPage');
    }
    // if(_ruta==4)
    //  {
    //    Navigator.pushReplacementNamed(context, 'iniciandoPage');
    //  }

    dynamic _sinConexion = await Future.delayed(Duration(seconds: 15), () {
      if (_ruta == 0) {
        _ruta = 6;
        final _error = true;
        // Navigator.pop(context);

        showDialog(
            context: context,
            child: AlertDialog(
                elevation: 5.0,
                title: Center(child: Text('Error')),
                content: Container(
                  child: Text(
                    "No se pudo establecer conexión con el servidor. ¿Desea intentar de nuevo?",
                    textAlign: TextAlign.center,
                  ),
                ),
                actions: [
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      color: colorMedico,
                      onPressed: () {
                        // dispBloc.obtenerDispositivos();
                        //Navigator.pop(context);
                        _ruta = 0;
                        Navigator.pushReplacementNamed(context, 'faqPage');
                      },
                      child: Text('Preguntas Frecuentes',
                          style: TextStyle(color: Colors.white))),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      color: colorMedico,
                      onPressed: () {
                        _ruta = 0;

                        Navigator.pushReplacementNamed(
                            context, 'iniciandoPage');
                      },
                      child: Text('Retry',
                          style: TextStyle(color: Colors.white))),
                ]));
        print(
            'no se pudo establecer conexión con el servidor intentar de nuevo?');

        return _error;
      } else {
        print('Sigue...');
        final _error = false;
        return _error;
      }
    });
    // if (_ruta==0) {
    //    setState(() {

    //    });

    //  }
  }
}
