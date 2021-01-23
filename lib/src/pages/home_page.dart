import 'dart:io';

import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/models/mqtt_models.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                return Scaffold(
                  body: Container(
                    color: colorBackGround,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                  height: 10.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: gradiente,
                                  )),
                              SizedBox(height: 26.0),
                              Container(
                                height: 123,
                                width: 123,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100.0)),
                                child: homeIcon(98.0, colorMedico),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Home',
                                style: TextStyle(
                                    color: colorVN,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              StreamBuilder<Object>(
                                  stream: serverDataBloc.tokenStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 40.0),
                                          tarjeta(
                                              'Music',
                                              'Add new songs or delete old ones',
                                              musicIcon(40, colorMedico),
                                              2,
                                              context),
                                          SizedBox(height: 20.0),
                                          tarjeta(
                                              'Tags',
                                              'Add , delete or edit tags',
                                              tagIcon(40, colorMedico),
                                              3,
                                              context),
                                          SizedBox(height: 20.0),
                                          tarjeta('Rooms', 'Mannage the rooms ',
                                              roomIcon(40), 1, context),
                                        ],
                                      );
                                    } else {
                                      return circularProgress();
                                    }
                                  }),
                              Expanded(child: Container()),
                              gradientBar2(0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: BottomBar(0),
                );
              } else {
                print('cargando');

                return Scaffold(
                  body: Container(
                    color: colorBackGround,
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                  height: 10.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: gradiente,
                                  )),
                              SizedBox(height: 26.0),
                              Container(
                                height: 123,
                                width: 123,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100.0)),
                                child: homeIcon(98.0, colorMedico),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Home',
                                style: TextStyle(
                                    color: colorVN,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              StreamBuilder<Object>(
                                  stream: serverDataBloc.tokenStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 40.0),
                                          tarjeta(
                                              'Music',
                                              'Add new songs or delete old ones',
                                              musicIcon(40, colorMedico),
                                              2,
                                              context),
                                          SizedBox(height: 20.0),
                                          tarjeta(
                                              'Tags',
                                              'Add , delete or edit tags',
                                              tagIcon(40, colorMedico),
                                              3,
                                              context),
                                          SizedBox(height: 20.0),
                                          tarjeta('Rooms', 'Mannage the rooms ',
                                              roomIcon(40), 1, context),
                                        ],
                                      );
                                    } else {
                                      return StreamBuilder<Object>(
                                          stream: serverDataBloc.timer,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              _firstTime = false;
                                            }
                                            if (serverDataBloc
                                                    .serverDataProvider
                                                    .connectionState ==
                                                MqttCurrentConnectionState
                                                    .CONNECTED) {
                                              _reconnect = false;
                                            } else {
                                              if (_errorClosed) {
                                                _reconnect = true;
                                              }
                                            }
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    onAfterBuild(context));
                                            return circularProgress();
                                          });
                                    }
                                  }),
                              Expanded(child: Container()),
                              //gradientBar2(0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //bottomNavigationBar: BottomBar(0),
                );
              }
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
          'Error connecting to server make sure your phone is connected in the same Wifi Network System',
          () async {
        Navigator.of(context).pop();
        await Future.delayed(Duration(seconds: 10));
        _errorClosed = true;
        serverDataBloc.serverConnect(
            'SERVER/AUTHORIZE', 'SERVER/RESPONSE', 'SERVER/INFO');
        serverDataBloc.initRadioService();
      });
    }
  }
}
