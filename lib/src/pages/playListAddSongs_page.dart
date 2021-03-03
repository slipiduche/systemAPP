import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/search/room_search.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

class PlayListAddSongsPage extends StatefulWidget {
  PlayListAddSongsPage({Key key}) : super(key: key);

  @override
  _PlayListAddSongsPageState createState() => _PlayListAddSongsPageState();
}

class _PlayListAddSongsPageState extends State<PlayListAddSongsPage> {
  PlayList _playList;
  List<Music> _allSongs;
  List<Music> listSongs = [];
  List<int> listPtxId = [];
  List<int> songsSelected = [];
  bool _allSelected = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _playList = ModalRoute.of(context).settings.arguments;
    //songsSelected = [];
    serverDataBloc.requestPlayLists();
    serverDataBloc.itemDelete();
    return WillPopScope(
        onWillPop: () {
          songsSelected = [];
          serverDataBloc.removeAllSongs();
          Navigator.of(context)
              .pushReplacementNamed('playListPage', arguments: _playList);
        },
        child: SafeArea(
          key: _scaffoldKey,
          child: Scaffold(
            body: Container(
              color: colorBackGround,
              height: double.infinity,
              child: Column(
                children: [
                  Container(
                      height: 10.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: gradiente,
                      )),
                  SizedBox(height: 26.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 25.0,
                      ),
                      Container(
                        height: 123,
                        width: 123,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0)),
                        child: playListIcon(50.0),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          width: 200.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _playList.listName,
                                style: TextStyle(fontSize: 26.0),
                              ),
                              Text(
                                '${_playList.tracks} songs',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Text(
                                'Genre: ${_playList.genre}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: StreamBuilder(
                              stream: serverDataBloc.serverDataStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Music>> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data.length < 1) {
                                    return Column(
                                      children: <Widget>[
                                        Text(
                                          'No songs added',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    );
                                  } else {
                                    _allSongs = snapshot.data;
                                    return Container(
                                      // margin:
                                      //     EdgeInsets.symmetric(horizontal: 1.0),

                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 28),
                                            child: GestureDetector(
                                                onTap: () {
                                                  // if (_playlistaddsongs.length > 0) {
                                                  //   showSearch(
                                                  //       context: context,
                                                  //       delegate:
                                                  //           PlayListAddSongsearchDelegate(
                                                  //               _playlistaddsongs));
                                                  // } else {}
                                                },
                                                child: Container(
                                                  child: searchBoxForm(
                                                      'Search for a song',
                                                      context),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    SizedBox(width: 25.0),
                                                    Builder(
                                                      builder: (context) {
                                                        if (songsSelected
                                                                .length >
                                                            0) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              serverDataBloc
                                                                  .removeAllSongs();
                                                              _allSelected =
                                                                  false;
                                                              songsSelected =
                                                                  [];
                                                              print(
                                                                  songsSelected);
                                                              serverDataBloc
                                                                  .itemDelete();
                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                              'Unselect All',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorMedico,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          );
                                                        } else {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              _allSelected =
                                                                  true;
                                                              songsSelected =
                                                                  [];
                                                              _allSongs.forEach(
                                                                  (element) {
                                                                songsSelected
                                                                    .add(element
                                                                        .id);
                                                              });
                                                              serverDataBloc
                                                                  .addSongsIds(
                                                                      songsSelected);
                                                              serverDataBloc
                                                                  .itemDelete();
                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                              'Select All',
                                                              style: TextStyle(
                                                                  color:
                                                                      colorMedico,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    Expanded(
                                                        child: Container()),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        songsSelected = [];
                                                        if (serverDataBloc
                                                                .getSongIds()
                                                                .length >
                                                            0) {
                                                          updating(context,
                                                              'Adding songs');
                                                          final resp =
                                                              await serverDataBloc
                                                                  .addSongsToPlayList(
                                                                      _playList);
                                                          serverDataBloc
                                                              .removeAllSongs();
                                                          if (resp) {
                                                            updated(context,
                                                                'Songs added to playlist');
                                                          } else {
                                                            errorPopUp(context,
                                                                'Songs not added');
                                                          }
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          addIcon(20.0,
                                                              colorMedico),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            'Add songs',
                                                            style: TextStyle(
                                                                color:
                                                                    colorMedico,
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 25.0)
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 25.0),
                                                    child: StreamBuilder(
                                                      stream: serverDataBloc
                                                          .serverDataStream,
                                                      builder: (BuildContext
                                                              context,
                                                          AsyncSnapshot<
                                                                  List<Music>>
                                                              snapshot) {
                                                        if (snapshot.hasData) {
                                                          //listPtx = [];
                                                          listPtxId = [];
                                                          print('canciones');

                                                          print(_allSelected);
                                                          return Column(
                                                            children: [
                                                              Expanded(
                                                                child: makeSongsListAdd(
                                                                    context,
                                                                    _allSongs,
                                                                    _allSelected),
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          serverDataBloc
                                                              .requestSongs();
                                                          return Container(
                                                            height: 100.0,
                                                            width: 100,
                                                            //margin: EdgeInsets.all(6.0),
                                                            //padding: EdgeInsets.all(25.0),
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height:
                                                                        20.0),
                                                                SizedBox(
                                                                  height: 40.0,
                                                                  width: 40,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<Color>(
                                                                            colorMedico),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  serverDataBloc.requestSongs();
                                  return Container(
                                    height: 100.0,
                                    width: 100,
                                    //margin: EdgeInsets.all(6.0),
                                    //padding: EdgeInsets.all(25.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20.0),
                                        SizedBox(
                                          height: 40.0,
                                          width: 40,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    colorMedico),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  gradientBar2(2),
                ],
              ),
            ),
            bottomNavigationBar: BottomBar(2),
            // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            // floatingActionButton: Container(
            //   //margin: EdgeInsets.symmetric(horizontal:12.0),
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       print('add SONG');

            //       ///Navigator.of(context).pushNamed('addPlayListAddSongsPage');
            //     },
            //     child: floatingIcon(60.0),
            //   ),
            // ),
          ),
        ));
  }
}

Widget _listNameInput(String hintText, String textValue, Function update) {
  final _textValue = new TextEditingController(text: textValue);

  return Container(
      // width: _screenSize.width -48.0,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: colorBordeBotton,
        //   width: 1.0,
        // ),
        borderRadius: BorderRadius.circular(12.0),
        color: colorBackGround,
      ),
      child: TextField(
        style: TextStyle(fontSize: 24.0),
        //autofocus: true,
        //textCapitalization: TextCapitalization.sentences,
        controller: _textValue,
        scrollPadding: EdgeInsets.all(5.0),

        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
        onChanged: (valor) {
          // _opcionSeleccionada = null;
          // prefs.dispositivoSeleccionado = null;
          if (hintText == 'Name') {
            update(valor);
          } else {
            update(valor);
            // _nombreNuevo = valor;
          }
          //setState(() {});
        },
      ));
}
