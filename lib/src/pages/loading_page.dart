import 'dart:io';

import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/models/mqtt_models.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool _reconnect = false, _errorClosed = true, _firstTime = true;
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  Widget build(BuildContext context) {
    if ((serverDataBloc.token == null) || (serverDataBloc.token == '')) {
      serverDataBloc.login();
      print('before');
    }

    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: SafeArea(
        child: StreamBuilder<Object>(
            stream: serverDataBloc.tokenStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _reconnect = false;
              } else {
                print('cargando');
              }
              return Scaffold(
                body: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sound',
                              style: TextStyle(
                                  color: colorMedico,
                                  fontSize: title,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Fog',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: title,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      StreamBuilder<Object>(
                          stream: serverDataBloc.timer,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _firstTime = false;
                            }
                            if (serverDataBloc
                                    .serverDataProvider.connectionState ==
                                MqttCurrentConnectionState.CONNECTED) {
                              _reconnect = false;
                            } else {
                              if (_errorClosed) {
                                _reconnect = true;
                              }
                            }
                            WidgetsBinding.instance.addPostFrameCallback(
                                (_) => onAfterBuild(context));
                            return circularProgress();
                          })
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  onAfterBuild(BuildContext context) async {
    print('se construyó');
    if (_reconnect && !_firstTime) {
      _firstTime = false;
      _reconnect = false;
      _errorClosed = false;
      errorPopUp1(context,
          'Error connecting to server, make sure your phone is connected to the same WiFi network of your devices',
          () async {
        Navigator.of(context).pop();
        await Future.delayed(Duration(seconds: 10));
        _errorClosed = true;
        serverDataBloc.serverConnect('SERVER/$apIdMain/AUTHORIZE',
            'SERVER/$apIdMain/RESPONSE', 'SERVER/$apIdMain/INFO');
        serverDataBloc.initRadioService();
      });
    } else if (_reconnect == false &&
        serverDataBloc.token != null &&
        serverDataBloc.token != '') {
      Navigator.of(context).pushReplacementNamed('homePage');
    }
  }
}
