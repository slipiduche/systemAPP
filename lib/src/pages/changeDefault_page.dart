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
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        print('poppop');
      }, // SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
      child: SafeArea(
        child: Scaffold(
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
                              'Music',
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Current',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Card(
                            child: Column(
                              children: [
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.0,
                                    ),
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
                                  ],
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                            color: Colors.white,
                            elevation: 4.0,
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Change',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Card(
                            color: Colors.white,
                            elevation: 4.0,
                            child: Column(
                              children: [
                                SizedBox(height: 20.0),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: StreamBuilder(
                                    stream: ServerDataBloc().songStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Music> snapshot) {
                                      if (snapshot.hasData) {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed('playSongPage');
                                            },
                                            child: searchBoxForm(
                                                snapshot.data.songName,
                                                context));
                                      } else {
                                        return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed('playSongPage');
                                            },
                                            child: searchBoxForm(
                                                'Select a song from the list',
                                                context));
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                StreamBuilder(
                                  stream: serverDataBloc.songStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Music> snapshot) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal:10.0),
                                      height: 40.0,
                                      child: submitButton('Change', () {
                                        if (snapshot.hasData) {
                                          _action(snapshot.data, context);
                                        } else {}
                                      }),
                                    );
                                  },
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
    updating(_context, 'Updating');
    final resp = await ServerDataBloc().changeDefault(data.id.toString());
    if (resp) {
      Navigator.of(_context).pop();
      updated(_context, 'Default updated');
      serverDataBloc.deleteData();
    } else {
      Navigator.of(_context).pop();
      errorPopUp(_context, 'Default not updated');
      serverDataBloc.deleteData();
    }
  }
}
