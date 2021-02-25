import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/search/room_search.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

class PlayListPage extends StatefulWidget {
  PlayListPage({Key key}) : super(key: key);

  @override
  _PlayListPageState createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  List<PlayList> _playlist;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //serverDataBloc.requestPlayLists();

    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushReplacementNamed('playListPage');
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
                      Column(
                        children: [
                          Container(
                              width: 200.0,
                              child: Text('New list', style: TextStyle(fontSize: 26.0),),
                              //child: _listNameInput('Name', 'default', (valor) {
                               // print(valor);
                             // }
                              //)
                              )
                        ],
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
                              stream: serverDataBloc.serverPlayListsStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<PlayList>> snapshot) {
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
                                    _playlist = snapshot.data;
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
                                                  // if (_playlist.length > 0) {
                                                  //   showSearch(
                                                  //       context: context,
                                                  //       delegate:
                                                  //           PlayListearchDelegate(
                                                  //               _playlist));
                                                  // } else {}
                                                },
                                                child: Container(
                                                  child: searchBoxForm(
                                                      'Search for a playlist',
                                                      context),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                } else {
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
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Container(
              //margin: EdgeInsets.symmetric(horizontal:12.0),
              child: FloatingActionButton(
                onPressed: () {
                  print('add SONG');
                  ///Navigator.of(context).pushNamed('addPlayListPage');
                },
                child: floatingIcon(60.0),
              ),
            ),
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


