import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class ChangeDefaultPage extends StatefulWidget {
  ChangeDefaultPage({Key key}) : super(key: key);

  @override
  _ChangeDefaultPageState createState() => _ChangeDefaultPageState();
}

class _ChangeDefaultPageState extends State<ChangeDefaultPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //exit(0);
        Navigator.of(context).pop();
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        print('poppop');
      }, // SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            color: colorBackGround,
            child: Column(
              children: [
                Container(
                    height: 10.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: gradiente,
                    )),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 26.0),
                          Center(
                            child: Container(
                              height: 123,
                              width: 123,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100.0)),
                              child: musicIcon(98.0, colorMedico),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Center(
                            child: Text(
                              'Change Default',
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Text(
                              'Current default tag song',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    musicIcon(40.0, colorMedico),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: StreamBuilder(
                                        stream: ServerDataBloc().defaultStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Music> snapshot) {
                                          if (snapshot.hasData) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data.songName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: colorLetraSearch,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text(
                                                  snapshot.data.artist,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: colorLetraSearch),
                                                ),
                                              ],
                                            );
                                          } else {
                                            if ((serverDataBloc.token ==
                                                    null) ||
                                                (serverDataBloc.token == '')) {
                                              serverDataBloc.login();
                                            } else {
                                              serverDataBloc.requestSongs();
                                            }
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 40.0,
                                                  width: 40.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(colorMedico),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('playSongPage');
                                        },
                                        child: searchIcon(40.0, colorMedico))
                                  ],
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 20.0),
                              SizedBox(height: 10.0),
                              StreamBuilder(
                                stream: serverDataBloc.songStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<Music> snapshot) {
                                  if (snapshot.hasData) {
                                    //
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) =>
                                            _action(snapshot.data, context));
                                  } else {}
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 28.0),
                                    height: 40.0,
                                    //child: submitButton('Change', () {}),
                                  );
                                },
                              ),
                              SizedBox(height: 20.0),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                gradientBar2(2),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(2),
        ),
      ),
    );
  }

  void _action(Music data, BuildContext _context) async {
    updating(_scaffoldKey.currentContext, 'Updating');
    final resp = await ServerDataBloc().changeDefault(data.id.toString());
    if (resp) {
      Navigator.of(_scaffoldKey.currentContext).pop();
      updated(_scaffoldKey.currentContext, 'Default updated');
      serverDataBloc.deleteData();
    } else {
      Navigator.of(_scaffoldKey.currentContext).pop();
      errorPopUp(_scaffoldKey.currentContext, 'Default not updated');
      serverDataBloc.deleteData();
    }
  }
}
