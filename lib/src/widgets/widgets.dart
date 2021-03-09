import 'package:flutter/material.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/pages/selectPlaylListPage_page.dart';
import 'package:systemAPP/src/provider/upload_provider.dart';

int songSelected;
int cardSelected;
int awaitUpload = 0;
BuildContext _updatingContext, _deletingContext;
void _moveTo(index, context) async {
  await ServerDataBloc().songPlayer.pause();
  if (index == 0) {
    await Navigator.of(context)
        .pushReplacementNamed('homePage', arguments: null);
  }

  if (index == 1) {
    await Navigator.of(context)
        .pushReplacementNamed('roomsPage', arguments: null);
  }
  if (index == 2) {
    await Navigator.of(context)
        .pushReplacementNamed('musicPage', arguments: null);
  }
  if (index == 3) {
    await Navigator.of(context)
        .pushReplacementNamed('tagPage', arguments: null);
  }
}

Widget submitButton(text, void Function() function) {
  Color activado;
  activado = colorMedico;
  if (function == null) {
    activado = gris;
  }
  return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: activado,
          boxShadow: [boxShadow1],
        ),
      ));
}

Widget submitButtonS(text, void Function() function) {
  return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10.0),
          color: colorMedico,
          boxShadow: [boxShadow1],
        ),
      ));
}

Widget submitButtonNo(text, void Function() function) {
  return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, color: colorVN, fontWeight: FontWeight.w400),
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [boxShadow1],
        ),
      ));
}

Widget tarjeta(
    String label, description, Widget icon, int index, dynamic context) {
  return GestureDetector(
    child: Card(
      elevation: 5.0,
      color: Colors.white,
      child: Container(
        height: 105,
        child: Row(children: [
          SizedBox(width: 30.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 36.0,
                    fontWeight: FontWeight.w100),
              ),
              Text(
                description,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100),
              )
            ],
          ),
          Expanded(child: Container()),
          icon,
          SizedBox(
            width: 23.48,
          )
        ]),
      ),
    ),
    onTap: () async {
      if (index == 20) {
        await Navigator.of(context)
            .pushNamed('listPlayListPage', arguments: null);
      }
      if (index == 13) {
        await Navigator.of(context)
            .pushNamed('deleteTagsPage', arguments: null);
      }
      if (index == 12) {
        await Navigator.of(context).pushNamed('editTagsPage', arguments: null);
      }
      if (index == 11) {
        await Navigator.of(context).pushNamed('addTagsPage', arguments: null);
      }
      if (index == 10) {
        await Navigator.of(context).pushNamed('editSongPage', arguments: null);
      }
      if (index == 9) {
        await Navigator.of(context).pushNamed('addSongsPage', arguments: null);
      }
      if (index == 8) {
        await Navigator.of(context).pushNamed('addSongPage', arguments: null);
      }
      if (index == 7) {
        await Navigator.of(context)
            .pushNamed('changeDefaultPage', arguments: null);
      }
      if (index == 5) {
        await Navigator.of(context).pushNamed('songsPage', arguments: null);
      }
      if (index == 6) {
        await Navigator.of(context).pushNamed('listSongsPage', arguments: null);
      }

      if (index == 1) {
        await Navigator.of(context)
            .pushReplacementNamed('roomsPage', arguments: null);
      }
      if (index == 2) {
        await Navigator.of(context)
            .pushReplacementNamed('musicPage', arguments: null);
      }
      if (index == 3) {
        await Navigator.of(context)
            .pushReplacementNamed('tagPage', arguments: null);
      }
      if (index == 0) {
        await Navigator.of(context)
            .pushReplacementNamed('homePage', arguments: null);
      }
    },
  );
}

class TwoIconCard extends StatefulWidget {
  @override
  String label, description;
  Widget icon;
  dynamic icon1;
  String path, name, genre;
  dynamic context;
  TwoIconCard(this.label, this.description, this.icon, this.icon1, this.path,
      this.context, this.name, this.genre,
      {Key key})
      : super(key: key);
  _TwoIconCardState createState() => _TwoIconCardState(
      label, description, icon, icon1, path, context, name, genre);
}

class _TwoIconCardState extends State<TwoIconCard> {
  @override
  String label, description;
  Widget icon;
  dynamic icon1;
  String path, name, genre;
  dynamic contexto;
  _TwoIconCardState(this.label, this.description, this.icon, this.icon1,
      this.path, this.contexto, this.name, this.genre);

  Widget build(BuildContext context) {
    if (awaitUpload == 0) {
      return twoIconCard(
          label, description, icon, icon1, path, contexto, name, genre);
    } else if (awaitUpload == 1) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorMedico),
          ),
        ],
      );
    } else if (awaitUpload == 2) {
      awaitUpload = 0;
      return Center(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Text(
              'Uploaded.',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ));
    }
  }

  Widget twoIconCard(String label, description, Widget icon, dynamic icon1,
      String path, dynamic context, String name, String genre) {
    String _path = path;
    print(_path);

    return Card(
      elevation: 5.0,
      color: Colors.white,
      child: Container(
        height: 105,
        //width: MediaQuery.of(context).size.width - 30,
        child: Row(children: [
          SizedBox(
            width: 20.0,
          ),
          icon,
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            //width: MediaQuery.of(context).size.width - 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Builder(builder: (context) {
            if (icon1 == false) {
              return GestureDetector(onTap: null, child: Container());
            } else {
              return GestureDetector(
                  onTap: () async {
                    print(_path);
                    uploading(1, 1, context);
                    awaitUpload = await ServerDataBloc()
                        .uploadSong(_path, name, description, genre);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: icon1);
            }
          }),
          SizedBox(
            width: 20.0,
          ),
        ]),
      ),
    );
  }
}

Widget makeDevicesList(BuildContext _context, List<Device> list, Widget icon3,
    String mode, String type) {
  int availableDevices = 0;
  list.forEach((element) {
    if (element.status == 'UNASSIGNED') {
      availableDevices++;
    }
  });
  if (availableDevices > 0) {
    return ListView.builder(
        //controller: _scrollController,
        itemCount: (list.length),
        itemBuilder: (BuildContext _context, int index) {
          print('makedeviceslist');
          print(index);
          if (type == "SPEAKER") {
            if (list[index].type == "SPEAKER" &&
                list[index].status == 'UNASSIGNED') {
              return twoIconCardDevices(list[index],
                  speakerIcon(40.0, colorMedico), icon3, _context, mode);
            } else {
              return Container();
            }
          } else {
            if (list[index].type == "READER" &&
                list[index].status == 'UNASSIGNED') {
              return twoIconCardDevices(list[index],
                  readerIcon(40.0, colorMedico), icon3, _context, mode);
            } else {
              return Container();
            }
          }
        });
  } else {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          'No devices available',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}

Widget makeSongsListPlay(BuildContext _context, List<Music> list, Widget icon1,
    Widget icon2, String mode) {
  return ListView.builder(
      //controller: _scrollController,
      itemCount: (list.length),
      itemBuilder: (BuildContext _context, int index) {
        //print(index);

        return threeIconCardP(list[index], songIcon(40.0, colorMedico), icon1,
            icon2, _context, mode, index);
      });
}

Widget circularProgress() {
  return Column(
    children: <Widget>[
      SizedBox(
        height: 20.0,
      ),
      CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(colorMedico),
      ),
    ],
  );
}

Widget circularProgressSimple() {
  return Container(
    width: 25.0,
    height: 25.0,
    child: Column(
      children: <Widget>[
        Container(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorMedico),
          ),
        ),
      ],
    ),
  );
}

Widget makeSongsList(
    BuildContext _context, List<Music> list, Widget icon3, String mode) {
  if (list.length > 3) {
    return ListView.builder(
        //controller: _scrollController,
        itemCount: (list.length),
        itemBuilder: (BuildContext _context, int index) {
          //print(index);
          if ((mode == 'delete' || mode == 'edit' || mode == 'add') &&
              list[index].id < 2) {
            return Container();
          } else {
            return twoIconCardSingle(list[index], songIcon(40.0, colorMedico),
                icon3, _context, mode);
          }
        });
  } else {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          'No songs available',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}

Widget makeSongsListPtx(BuildContext _context, List<Music> list,
    List<int> listId, bool allSelected) {
  final selected = ServerDataBloc().getPtxIds();
  if (list.length < 1) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          'No songs available',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  } else {
    return ListView.builder(
        //controller: _scrollController,
        itemCount: (list.length),
        itemBuilder: (BuildContext _context, int index) {
          //print(index);
          if (list[index].id > 1) {
            if (selected.contains(listId[index])) {
              allSelected = true;
            } else {
              allSelected = false;
            }

            return twoIconCardPtx1(list[index], () {}, () {
              deleting(list[index], _context);
            }, () {
              editing(list[index], _context);
            }, _context, allSelected, index, listId[index]);
          } else {
            return Container();
          }
        });
  }
}

Widget makeSongsListAdd(
    BuildContext _context, List<Music> list, bool allSelected) {
  final selected = ServerDataBloc().getSongIds();
  if (list.length < 1) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          'No songs available',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  } else {
    return ListView.builder(
        //controller: _scrollController,
        itemCount: (list.length),
        itemBuilder: (BuildContext _context, int index) {
          //print(index);
          if (list[index].id > 1) {
            if (selected.contains(list[index].id)) {
              allSelected = true;
            } else {
              allSelected = false;
            }
            return twoIconCardAdd(list[index], () {}, () {
              deleting(list[index], _context);
            }, () {
              editing(list[index], _context);
            }, _context, allSelected, index);
          } else {
            return Container();
          }
        });
  }
}

Widget twoIconCardAdd(Music song, Function icon, Function icon1, Function icon2,
    BuildContext _context, bool itemSelected, int index) {
  bool _itemSelected = itemSelected;
  print(_itemSelected);
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Column(
      children: [
        Container(
          height: 105,
          //width: MediaQuery.of(_context).size.width - 30,
          child: Row(children: [
            SizedBox(width: 20.0),
            StreamBuilder(
                stream: ServerDataBloc().songPlayer.isPlayingStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if ((snapshot.data ==
                                FlutterRadioPlayer.flutter_radio_stopped ||
                            snapshot.data ==
                                FlutterRadioPlayer.flutter_radio_paused) &&
                        song.id == songSelected &&
                        index == cardSelected) {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;
                            cardSelected = index;
                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/0/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                            } else {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/1/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(Icons.play_arrow,
                              color: colorMedico, size: 40.0));
                    }
                    if (snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_playing &&
                        song.id == songSelected &&
                        index == cardSelected) {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;
                            cardSelected = index;
                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.pause();
                            } else {
                              await ServerDataBloc().songPlayer.pause();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(Icons.pause,
                              color: colorMedico, size: 40.0));
                    } else {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;
                            cardSelected = index;
                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/0/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                            } else {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/1/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: colorMedico,
                            size: 40.0,
                          ));
                    }
                  } else {
                    return GestureDetector(
                        onTap: () async {
                          print('presionaste id ');
                          print(song.id);
                          songSelected = song.id;
                          cardSelected = index;
                          print('playing');
                          if (song.id == 0 || song.id == 1) {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/0/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                          } else {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/1/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                            //ServerDataBloc().bindSong(song);
                            //Navigator.of(_context).pop();
                          }
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: colorMedico,
                          size: 40.0,
                        ));
                  }
                }),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    song.songName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w100,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    song.artist,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
            SizedBox(width: 10.0),
            StreamBuilder(
              stream: ServerDataBloc().itemSelected,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == index) {
                    print(snapshot.data.toString() + ':' + index.toString());
                    print(_itemSelected);
                    if (_itemSelected) {
                      //_itemSelected = false;
                      // ServerDataBloc().removeSongId(song.id);
                      print('${song.id}$_itemSelected');
                    } else {
                      //_itemSelected = true;
                      // ServerDataBloc().songIdAdd(song.id);
                      print('${song.id}$_itemSelected');
                    }
                  }
                }
                return Container(
                  child: Theme(
                    data: ThemeData(unselectedWidgetColor: colorMedico),
                    child: Checkbox(
                      focusColor: colorMedico,
                      hoverColor: colorMedico,
                      activeColor: colorMedico,
                      value: _itemSelected,
                      onChanged: (valor) {
                        //_itemSelected = valor;
                        if (valor) {
                          ServerDataBloc().songIdAdd(song.id);
                        } else {
                          ServerDataBloc().removeSongId(song.id);
                        }
                        _itemSelected = valor;
                        ServerDataBloc().itemAdd(index);

                        print(index);
                      },
                      tristate: false,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 20.0,
            ),
          ]),
        ),
      ],
    ),
  );
}

Widget twoIconCardPtx1(
    Music song,
    Function icon,
    Function icon1,
    Function icon2,
    BuildContext _context,
    bool itemSelected,
    int index,
    int ptxId) {
  bool _itemSelected = itemSelected;
  print(_itemSelected);
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Column(
      children: [
        Container(
          height: 105,
          //width: MediaQuery.of(_context).size.width - 30,
          child: Row(children: [
            SizedBox(width: 20.0),
            StreamBuilder(
                stream: ServerDataBloc().songPlayer.isPlayingStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if ((snapshot.data ==
                                FlutterRadioPlayer.flutter_radio_stopped ||
                            snapshot.data ==
                                FlutterRadioPlayer.flutter_radio_paused) &&
                        song.id == songSelected &&
                        index == cardSelected) {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;
                            cardSelected = index;
                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/0/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                            } else {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/1/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(Icons.play_arrow,
                              color: colorMedico, size: 40.0));
                    }
                    if (snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_playing &&
                        song.id == songSelected &&
                        index == cardSelected) {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;
                            cardSelected = index;
                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.pause();
                            } else {
                              await ServerDataBloc().songPlayer.pause();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(Icons.pause,
                              color: colorMedico, size: 40.0));
                    } else {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;
                            cardSelected = index;
                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/0/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                            } else {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/1/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: colorMedico,
                            size: 40.0,
                          ));
                    }
                  } else {
                    return GestureDetector(
                        onTap: () async {
                          print('presionaste id ');
                          print(song.id);
                          songSelected = song.id;
                          cardSelected = index;
                          print('playing');
                          if (song.id == 0 || song.id == 1) {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/0/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                          } else {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/1/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                            //ServerDataBloc().bindSong(song);
                            //Navigator.of(_context).pop();
                          }
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: colorMedico,
                          size: 40.0,
                        ));
                  }
                }),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    song.songName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w100,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    song.artist,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
            SizedBox(width: 10.0),
            StreamBuilder(
              stream: ServerDataBloc().itemSelected,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == index) {
                    print(snapshot.data.toString() + ':' + index.toString());
                    print(_itemSelected);
                    if (_itemSelected) {
                      //_itemSelected = false;
                      //ServerDataBloc().removePtxId(ptxId);
                      print(_itemSelected);
                    } else {
                      //_itemSelected = true;
                      //ServerDataBloc().ptxIdAdd(ptxId);
                      print(_itemSelected);
                    }
                  }
                  ServerDataBloc().itemDelete();
                }
                return Container(
                  child: Theme(
                    data: ThemeData(unselectedWidgetColor: colorMedico),
                    child: Checkbox(
                      focusColor: colorMedico,
                      hoverColor: colorMedico,
                      activeColor: colorMedico,
                      value: _itemSelected,
                      onChanged: (valor) {
                        if (valor) {
                          ServerDataBloc().ptxIdAdd(ptxId);
                        } else {
                          ServerDataBloc().removePtxId(ptxId);
                        }
                        _itemSelected = valor;
                        ServerDataBloc().itemAdd(index);

                        print(index);
                      },
                      tristate: false,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 20.0,
            ),
          ]),
        ),
      ],
    ),
  );
}

Widget makeSongsList2(BuildContext _context, List<Music> list) {
  if (list.length < 2) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Text(
          'No songs available',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  } else {
    return ListView.builder(
        //controller: _scrollController,
        itemCount: (list.length),
        itemBuilder: (BuildContext _context, int index) {
          //print(index);
          if (list[index].id > 1) {
            return twoIconCardList(list[index], () {}, () {
              deleting(list[index], _context);
            }, () {
              editing(list[index], _context);
            }, _context);
          } else {
            return Container();
          }
        });
  }
}

Widget twoIconCardDevices(Device device, Widget icon, dynamic icon1,
    BuildContext _context, String mode) {
  ///
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Container(
      height: 105,
      //width: MediaQuery.of(_context).size.width - 30,
      child: Row(children: [
        SizedBox(width: 10.0),
        Expanded(child: Container()),
        icon,
        SizedBox(width: 10.0),
        Expanded(child: Container()),
        Container(
          width: MediaQuery.of(_context).size.width - 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                device.deviceName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w100,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                device.chipId,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100),
              )
            ],
          ),
        ),
        Expanded(child: Container()),
        Builder(builder: (_context) {
          if (icon1 == false) {
            return GestureDetector(onTap: null, child: Container());
          } else {
            return GestureDetector(
                onTap: () async {
                  print('presionaste id ');
                  print(device.chipId);
                  if (mode == 'bind') {
                    // print('binding');
                    // ServerDataBloc().bindSong(song);
                    if (device.type == 'SPEAKER') {
                      ServerDataBloc().bindSpeaker(device);
                    } else {
                      ServerDataBloc().bindReader(device);
                    }
                    Navigator.of(_context).pop();
                  }
                },
                child: icon1);
          }
        }),
        Expanded(child: Container()),
        SizedBox(width: 10.0),
      ]),
    ),
  );
}

Widget threeIconCardP(Music song, Widget icon, Widget icon2, Widget icon3,
    BuildContext _context, String mode, int index) {
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Container(
      height: 105,
      //width: MediaQuery.of(_context).size.width - 30,
      child: Row(children: [
        SizedBox(
          width: 20.0,
        ),
        icon,
        SizedBox(
          width: 10.0,
          child: Container(
            width: 10.0,
          ),
        ),
        Expanded(
          child: Container(
            //width: MediaQuery.of(_context).size.width - 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  song.songName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w100,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        StreamBuilder(
            stream: ServerDataBloc().songPlayer.isPlayingStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_stopped ||
                        snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_paused) &&
                    song.id == songSelected &&
                    index == cardSelected) {
                  return GestureDetector(
                      onTap: () async {
                        print('presionaste id ');
                        print(song.id);
                        songSelected = song.id;
                        cardSelected = index;
                        if (mode == 'changeDefault') {
                          print('playing');
                          if (song.id == 0 || song.id == 1) {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/0/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                          } else {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/1/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                            //ServerDataBloc().bindSong(song);
                            //Navigator.of(_context).pop();
                          }
                        }
                      },
                      child: icon2);
                }
                if (snapshot.data == FlutterRadioPlayer.flutter_radio_playing &&
                    song.id == songSelected &&
                    index == cardSelected) {
                  return GestureDetector(
                      onTap: () async {
                        print('presionaste id ');
                        print(song.id);
                        songSelected = song.id;
                        cardSelected = index;
                        if (mode == 'changeDefault') {
                          print('playing');
                          if (song.id == 0 || song.id == 1) {
                            await ServerDataBloc().songPlayer.pause();
                          } else {
                            await ServerDataBloc().songPlayer.pause();
                            //ServerDataBloc().bindSong(song);
                            //Navigator.of(_context).pop();
                          }
                        }
                      },
                      child: Icon(Icons.pause, color: colorMedico, size: 40.0));
                } else {
                  return GestureDetector(
                      onTap: () async {
                        print('presionaste id ');
                        print(song.id);
                        songSelected = song.id;
                        cardSelected = index;
                        if (mode == 'changeDefault') {
                          print('playing');
                          if (song.id == 0 || song.id == 1) {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/0/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                          } else {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/1/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                            //ServerDataBloc().bindSong(song);
                            //Navigator.of(_context).pop();
                          }
                        }
                      },
                      child: icon2);
                }
              } else {
                return GestureDetector(
                    onTap: () async {
                      print('presionaste id ');
                      print(song.id);
                      songSelected = song.id;
                      cardSelected = index;
                      if (mode == 'changeDefault') {
                        print('playing');
                        if (song.id == 0 || song.id == 1) {
                          await ServerDataBloc().songPlayer.setUrl(
                              'http://$serverUri:8080/audio/0/${song.flName}',
                              'true');
                          await ServerDataBloc().songPlayer.play();
                        } else {
                          await ServerDataBloc().songPlayer.setUrl(
                              'http://$serverUri:8080/audio/1/${song.flName}',
                              'true');
                          await ServerDataBloc().songPlayer.play();
                          //ServerDataBloc().bindSong(song);
                          //Navigator.of(_context).pop();
                        }
                      }
                    },
                    child: icon2);
              }
            }),
        SizedBox(width: 20.0),
        Builder(builder: (_context) {
          return GestureDetector(
              onTap: () async {
                print('presionaste id ');
                print(song.id);
                if (mode == 'changeDefault') {
                  print('changing');
                  ServerDataBloc().bindSong(song);
                  //ServerDataBloc().bindSong(song);
                  Navigator.of(_context).pop();
                }
              },
              child: icon3);
        }),
        SizedBox(
          width: 20.0,
        )
      ]),
    ),
  );
}

Widget twoIconCardList(Music song, Function icon, Function icon1,
    Function icon2, BuildContext _context) {
  final List<PopupMenuItem<String>> _popUpMenuItems = [
    PopupMenuItem<String>(
      value: 'Edit',
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Edit',
                style: TextStyle(fontSize: 26),
              ),
              Expanded(child: Container()),
              editIcon(40.0, colorMedico)
            ],
          ),
          Divider(),
        ],
      ),
    ),
    PopupMenuItem<String>(
      value: 'AddPlay',
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Add to playlist',
                style: TextStyle(fontSize: 26),
              ),
              Expanded(child: Container()),
              playListIcon(40.0)
            ],
          ),
          Divider(),
        ],
      ),
    ),
    PopupMenuItem<String>(
      value: 'Delete',
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Delete',
                style: TextStyle(fontSize: 26),
              ),
              Expanded(child: Container()),
              deleteIcon(40.0, colorMedico)
            ],
          ),
          Divider(),
        ],
      ),
    ),
  ];
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Column(
      children: [
        Container(
          height: 105,
          //width: MediaQuery.of(_context).size.width - 30,
          child: Row(children: [
            SizedBox(width: 20.0),
            StreamBuilder(
                stream: ServerDataBloc().songPlayer.isPlayingStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if ((snapshot.data ==
                                FlutterRadioPlayer.flutter_radio_stopped ||
                            snapshot.data ==
                                FlutterRadioPlayer.flutter_radio_paused) &&
                        song.id == songSelected) {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;

                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/0/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                            } else {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/1/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(Icons.play_arrow,
                              color: colorMedico, size: 40.0));
                    }
                    if (snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_playing &&
                        song.id == songSelected) {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;

                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.pause();
                            } else {
                              await ServerDataBloc().songPlayer.pause();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(Icons.pause,
                              color: colorMedico, size: 40.0));
                    } else {
                      return GestureDetector(
                          onTap: () async {
                            print('presionaste id ');
                            print(song.id);
                            songSelected = song.id;

                            print('playing');
                            if (song.id == 0 || song.id == 1) {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/0/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                            } else {
                              await ServerDataBloc().songPlayer.setUrl(
                                  'http://$serverUri:8080/audio/1/${song.flName}',
                                  'true');
                              await ServerDataBloc().songPlayer.play();
                              //ServerDataBloc().bindSong(song);
                              //Navigator.of(_context).pop();
                            }
                          },
                          child: Icon(
                            Icons.play_arrow,
                            color: colorMedico,
                            size: 40.0,
                          ));
                    }
                  } else {
                    return GestureDetector(
                        onTap: () async {
                          print('presionaste id ');
                          print(song.id);
                          songSelected = song.id;

                          print('playing');
                          if (song.id == 0 || song.id == 1) {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/0/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                          } else {
                            await ServerDataBloc().songPlayer.setUrl(
                                'http://$serverUri:8080/audio/1/${song.flName}',
                                'true');
                            await ServerDataBloc().songPlayer.play();
                            //ServerDataBloc().bindSong(song);
                            //Navigator.of(_context).pop();
                          }
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: colorMedico,
                          size: 40.0,
                        ));
                  }
                }),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    song.songName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w100,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    song.artist,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
            SizedBox(width: 10.0),
            PopupMenuButton<String>(
                padding: EdgeInsets.all(0.0),
                offset: Offset.fromDirection(0.0, 50.0),
                onSelected: (value) {
                  switch (value) {
                    case 'Edit':
                      icon2();

                      break;
                    case 'Delete':
                      icon1();

                      break;
                    case 'AddPlay':
                      {
                        //ServerDataBloc().requestPlayLists();
                        Navigator.of(_context).pushNamed('selectPlayListPage',
                            arguments: Arguments(song.id));
                      }

                      break;
                    //default:
                  }
                },
                child: moreCircleIcon(30.0),
                itemBuilder: (BuildContext _context) {
                  return _popUpMenuItems;
                }),
            SizedBox(
              width: 20.0,
            ),
          ]),
        ),
      ],
    ),
  );
}

// Widget moreCircleIcon(double size) {
//   return Container(
//     width: size,
//     height: size,
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       //crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // SizedBox(height: 1.0,),
//         Expanded(
//           child: Text(
//             '···',
//             //textAlign: TextAlign.start,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: size,
//             ),
//           ),
//         ),
//         //SizedBox(height: 10.0,),
//       ],
//     ),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100.0), color: colorMedico),
//   );
// }

Widget twoIconCardSingle(Music song, Widget icon, dynamic icon1,
    BuildContext _context, String mode) {
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Container(
      height: 105,
      //width: MediaQuery.of(_context).size.width - 30,
      child: Row(children: [
        SizedBox(
          width: 20.0,
        ),
        icon,
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Container(
            //width: MediaQuery.of(_context).size.width - 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  song.songName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w100,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artist,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        StreamBuilder(
            stream: ServerDataBloc().songPlayer.isPlayingStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if ((snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_stopped ||
                        snapshot.data ==
                            FlutterRadioPlayer.flutter_radio_paused) &&
                    song.id == songSelected) {
                  return GestureDetector(
                      onTap: () async {
                        print('presionaste id ');
                        print(song.id);
                        songSelected = song.id;

                        print('playing');
                        if (song.id == 0 || song.id == 1) {
                          await ServerDataBloc().songPlayer.setUrl(
                              'http://$serverUri:8080/audio/0/${song.flName}',
                              'true');
                          await ServerDataBloc().songPlayer.play();
                        } else {
                          await ServerDataBloc().songPlayer.setUrl(
                              'http://$serverUri:8080/audio/1/${song.flName}',
                              'true');
                          await ServerDataBloc().songPlayer.play();
                          //ServerDataBloc().bindSong(song);
                          //Navigator.of(_context).pop();
                        }
                      },
                      child: speakerIcon(40.0, colorMedico));
                }
                if (snapshot.data == FlutterRadioPlayer.flutter_radio_playing &&
                    song.id == songSelected) {
                  return GestureDetector(
                      onTap: () async {
                        print('presionaste id ');
                        print(song.id);
                        songSelected = song.id;

                        print('playing');
                        if (song.id == 0 || song.id == 1) {
                          await ServerDataBloc().songPlayer.pause();
                        } else {
                          await ServerDataBloc().songPlayer.pause();
                          //ServerDataBloc().bindSong(song);
                          //Navigator.of(_context).pop();
                        }
                      },
                      child: Icon(Icons.pause, color: colorMedico, size: 40.0));
                } else {
                  return GestureDetector(
                      onTap: () async {
                        print('presionaste id ');
                        print(song.id);
                        songSelected = song.id;

                        print('playing');
                        if (song.id == 0 || song.id == 1) {
                          await ServerDataBloc().songPlayer.setUrl(
                              'http://$serverUri:8080/audio/0/${song.flName}',
                              'true');
                          await ServerDataBloc().songPlayer.play();
                        } else {
                          await ServerDataBloc().songPlayer.setUrl(
                              'http://$serverUri:8080/audio/1/${song.flName}',
                              'true');
                          await ServerDataBloc().songPlayer.play();
                          //ServerDataBloc().bindSong(song);
                          //Navigator.of(_context).pop();
                        }
                      },
                      child: speakerIcon(40.0, colorMedico));
                }
              } else {
                return GestureDetector(
                    onTap: () async {
                      print('presionaste id ');
                      print(song.id);
                      songSelected = song.id;

                      print('playing');
                      if (song.id == 0 || song.id == 1) {
                        await ServerDataBloc().songPlayer.setUrl(
                            'http://$serverUri:8080/audio/0/${song.flName}',
                            'true');
                        await ServerDataBloc().songPlayer.play();
                      } else {
                        await ServerDataBloc().songPlayer.setUrl(
                            'http://$serverUri:8080/audio/1/${song.flName}',
                            'true');
                        await ServerDataBloc().songPlayer.play();
                        //ServerDataBloc().bindSong(song);
                        //Navigator.of(_context).pop();
                      }
                    },
                    child: speakerIcon(40.0, colorMedico));
              }
            }),
        SizedBox(
          width: 10.0,
        ),
        Builder(builder: (_context) {
          if (icon1 == false) {
            return GestureDetector(onTap: null, child: Container());
          } else {
            return GestureDetector(
                onTap: () async {
                  await ServerDataBloc().songPlayer.pause();
                  print('presionaste id ');
                  print(song.id);
                  if (mode == 'edit') {
                    editing(song, _context);
                  } else if (mode == 'delete') {
                    deleting(song, _context);
                  } else if (mode == 'add') {
                    print('binding');
                    ServerDataBloc().bindSong(song);
                    Navigator.of(_context).pop();
                  } else if (mode == 'bind') {
                    print('binding');
                    ServerDataBloc().bindSong(song);
                    final FocusScopeNode focus = FocusScope.of(_context);
                    if (!focus.hasPrimaryFocus && focus.hasFocus) {
                      FocusManager.instance.primaryFocus.unfocus();
                    }
                    Navigator.of(_context).pop();
                    Navigator.of(_context).pop();
                  }
                },
                child: icon1);
          }
        }),
        SizedBox(
          width: 20.0,
        ),
      ]),
    ),
  );
}

void deleting(Music song, BuildContext _context) {
  Music upSong = song;
  BuildContext dialogContext;
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        dialogContext = _context;

        return Container(
          //width: MediaQuery.of(context).size.width - 20,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  //height: 30.0,
                  //color: colorMedico,
                  child: Center(
                      child: Text(
                    'Confirmation',
                    style: TextStyle(fontSize: 30.0, color: colorVN),
                  )),
                ),
                Container(
                  //margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                            song.songName +
                                '.' +
                                '\n\n' +
                                ' The tag associated with this song will be deleted',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20.0)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.0,
                              child: submitButtonS('YES', () async {
                                print('deleting');
                                Navigator.of(dialogContext).pop();
                                updating(context, 'Deleting');
                                //print(upSong.toJson());
                                final resp =
                                    await ServerDataBloc().deleteSong(song);
                                await Future.delayed(Duration(seconds: 1));
                                if (resp) {
                                  print('deleted');
                                  Navigator.of(_updatingContext).pop();
                                  updated(dialogContext, 'Deleted');
                                } else {
                                  print('error');
                                  Navigator.of(_updatingContext).pop();
                                  errorPopUp(dialogContext, 'Song not deleted');
                                }
                              }),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50.0,
                              child: submitButtonNo('NO', () async {
                                print('deleting');
                                Navigator.of(dialogContext).pop();
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

void editing(Music song, BuildContext _context) {
  Music upSong = song;
  BuildContext dialogContext;
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        dialogContext = _context;
        return Container(
          //width: MediaQuery.of(context).size.width - 20,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Song name',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  _deviceInput('Name', song.songName,
                                      (String name) {
                                    upSong.songName = name;
                                    print('name:$name');
                                  }),
                                  Text('Artist',
                                      style: TextStyle(fontSize: 25.0)),
                                  _deviceInput('Artist', song.artist,
                                      (String artist) {
                                    upSong.artist = artist;
                                    print('artist:$artist');
                                  }),
                                  Text('Genre',
                                      style: TextStyle(fontSize: 25.0)),
                                  _deviceInput('Genre', song.genre,
                                      (String genre) {
                                    upSong.genre = genre;
                                    print('genre:$genre');
                                  }),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.0,
                              child: submitButton('Done', () async {
                                Navigator.of(dialogContext).pop();
                                updating(context, 'updating');
                                print(upSong.toJson());
                                final resp =
                                    await ServerDataBloc().updateSong(upSong);
                                if (resp) {
                                  print('updated');
                                  Navigator.of(_updatingContext).pop();
                                  updated(dialogContext, 'Updated');
                                } else {
                                  print('error');
                                  Navigator.of(_updatingContext).pop();
                                  errorPopUp(dialogContext, 'Song not edited');
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

void updating(BuildContext _context, String message) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (_context) {
        _updatingContext = _context;
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            //height: 200.0,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorMedico),
                ),
                Text(
                  '$message...',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        );
      });
}

void updated(BuildContext _context, String message) {
  BuildContext dialogContext;
  showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (context) {
        dialogContext = _context;
        return Dialog(
          //scrollable: true,
          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            // height: 100.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Icon(
                  Icons.check,
                  size: 50.0,
                  color: colorMedico,
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: submitButton('OK', () {
                            Navigator.of(dialogContext).pop();
                            ServerDataBloc().deleteData();
                            if (message == "Updated") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message == "Deleted") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message == "Added") {
                              Navigator.of(context)
                                  .pushReplacementNamed('addTagsPage');
                            } else if (message == "Tag updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('editTagsPage');
                            } else if (message == "Tag deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('deleteTagsPage');
                            } else if (message == "Room added") {
                              Navigator.of(context)
                                  .pushReplacementNamed('roomsPage');
                            } else if (message == "Room updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('roomsPage');
                            } else if (message == "Room deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('roomsPage');
                            } else if (message == "Default updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('changeDefaultPage');
                            } else if (message == "Playlist Created") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Playlist deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Playlist updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Song added to playlist") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message == "Songs added to playlist") {
                              ServerDataBloc().requestSongs();
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            } else if (message == "Songs deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listPlayListPage');
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      });
}

void errorPopUp1(BuildContext _context, String message, Function function) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          //scrollable: true,
          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            //height: 100.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Icon(
                  Icons.error_outline,
                  size: 50.0,
                  color: Colors.red,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 50.0,
                  //margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: submitButton('OK', () {
                          function();
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      });
}

void errorPopUp(BuildContext _context, String message) {
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          //scrollable: true,
          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            //height: 100.0,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Icon(
                  Icons.error_outline,
                  size: 50.0,
                  color: Colors.red,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0,
                          child: submitButton('OK', () {
                            ServerDataBloc().deleteData();
                            if (message == 'Not updated') {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  _context, 'editTagsPage');
                            } else if (message == 'Not added') {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'addTagsPage');
                            } else if (message == 'Room not added') {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'roomsPage');
                            } else if (message == 'Room not updated') {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'roomsPage');
                            } else if (message == 'Room not deleted') {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'roomsPage');
                            } else if (message == "Default not updated") {
                              Navigator.of(context)
                                  .pushReplacementNamed('changeDefaultPage');
                            } else if (message == "Song not edited") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message == "Song not deleted") {
                              Navigator.of(context)
                                  .pushReplacementNamed('listSongsPage');
                            } else if (message ==
                                "Error connecting to server make sure your phone is connected in the same Wifi Network System") {
                              Navigator.of(context).pop();
                              ServerDataBloc().serverConnect('SERVER/AUTHORIZE',
                                  'SERVER/RESPONSE', 'SERVER/INFO');
                              ServerDataBloc().initRadioService();
                            } else if (message == "Songs not uploaded") {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'addSongsPage');
                            } else if (message == "Playlist not deleted") {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'listPlayListPage');
                            } else if (message == "Playlist not created") {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'listPlayListPage');
                            } else if (message == "Playlist not updated") {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'listPlayListPage');
                            } else if (message == "Songs not deleted") {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'listPlayListPage');
                            } else if (message == "Songs not added") {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'listPlayListPage');
                            } else {
                              Navigator.of(_context).pop();
                              Navigator.pushReplacementNamed(
                                  context, 'homePage');
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      });
}

Widget roomInput(String hintText, String textValue, Function update) {
  final _textValue = new TextEditingController(text: textValue);
  return Container(
      // width: _screenSize.width -48.0,
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      //margin: EdgeInsets.symmetric(vertical: 5.0),
      height: 40.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: colorBordeSearch,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: Center(
        child: TextField(
          //autofocus: true,
          //textCapitalization: TextCapitalization.sentences,
          style: TextStyle(
            fontSize: 24,
          ),

          controller: _textValue,
          scrollPadding: EdgeInsets.symmetric(horizontal: 5.0),

          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 20, color: colorLetraSearch),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0)),
          onChanged: (valor) {
            // _opcionSeleccionada = null;
            // prefs.dispositivoSeleccionado = null;

            update(valor);

            update(valor);
            // _nombreNuevo = valor;
          }
          //setState(() {});
          ,
        ),
      ));
}

Widget _deviceInput(String hintText, String textValue, Function update) {
  final _textValue = new TextEditingController(text: textValue);
  if (hintText == 'MAC') {
    //_macNueva = textValue;
  } else {
    //_nombreNuevo = textValue;
  }

  return Container(
      // width: _screenSize.width -48.0,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorBordeBotton,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: TextField(
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

void uploading(int i, songsCount, BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            //height: 100.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorMedico),
                ),
                Text(
                  'Uploading...$i of $songsCount',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        );
      });
}

Widget gradientBar(bool selected) {
  if (selected) {
    return Container(
      height: 10.0,
      width: 90,
      decoration: BoxDecoration(
        //color: colorMedico,
        gradient: gradiente,
      ),
    );
  } else {
    return Container(
      height: 10.0,
      width: 90,
      color: colorBackGround,
    );
  }
}

Widget gradientBar2(int index) {
  return Container(
    height: 10.0,
    width: double.infinity,
    child: Row(
      children: [
        gradientBar(index == 0),
        Expanded(child: Container()),
        gradientBar(index == 1),
        Expanded(child: Container()),
        gradientBar(index == 2),
        Expanded(child: Container()),
        gradientBar(index == 3),
      ],
    ),
  );
}

class BottomBar extends StatefulWidget {
  int index;
  BottomBar(this.index, {Key key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState(index);
}

class _BottomBarState extends State<BottomBar> {
  int _itemselected;
  _BottomBarState(this._itemselected);
  @override
  Widget build(BuildContext context) {
    return botomBar();
  }

  Widget botomBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: homeBarIcon(25),
            title: Container(),
            activeIcon: homeBarIconS(30)),
        BottomNavigationBarItem(
            icon: roomBarIcon(25),
            title: Container(),
            activeIcon: roomBarIconS(25)),
        BottomNavigationBarItem(
            icon: musicBarIcon(25),
            title: Container(),
            activeIcon: musicBarIconS(25)),
        BottomNavigationBarItem(
            icon: tagBarIcon(25),
            title: Container(),
            activeIcon: tagBarIconS(25)),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _itemselected,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(index) async {
    _itemselected = index;
    print('presionaste:');
    print(index);
    ServerDataBloc().songPlayer.pause();
    if (index == 0) {
      await Navigator.of(context)
          .pushReplacementNamed('homePage', arguments: null);
    }

    if (index == 1) {
      await Navigator.of(context)
          .pushReplacementNamed('roomsPage', arguments: null);
    }
    if (index == 2) {
      await Navigator.of(context)
          .pushReplacementNamed('musicPage', arguments: null);
    }
    if (index == 3) {
      await Navigator.of(context)
          .pushReplacementNamed('tagPage', arguments: null);
    }
  }
}

Widget textBoxForm(String content, BuildContext context) {
  return Container(
    child: Container(
      height: 41.0,
      //width: MediaQuery.of(context).size.width - 52.0,
      child: Container(
          child: Row(
        children: [
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              //width: MediaQuery.of(context).size.width - 100,
              child: Text(
                content,
                style: TextStyle(color: colorLetraSearch, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          border: Border.all(
            color: colorBordeSearch,
            style: BorderStyle.solid,
          )),
    ),
  );
}

Widget searchBoxForm(String content, BuildContext context) {
  return Container(
    child: Container(
      height: 41.0,
      //width: MediaQuery.of(context).size.width - 52.0,
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              //width: MediaQuery.of(context).size.width - 100,
              child: Text(
                content,
                style: TextStyle(color: colorLetraSearch, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          searchIcon(20.0, colorMedico),
          SizedBox(
            width: 20.0,
          ),
        ],
      )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          border: Border.all(
            color: colorBordeSearch,
            style: BorderStyle.solid,
          )),
    ),
  );
}

Widget searchBoxFormRooms(String content, BuildContext context) {
  return Container(
    child: Container(
      height: 41.0,
      //width: MediaQuery.of(context).size.width,
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              //width: MediaQuery.of(context).size.width - 100,
              child: Text(
                content,
                style: TextStyle(color: colorLetraSearch, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          searchIcon(20.0, colorMedico),
          SizedBox(
            width: 20.0,
          ),
        ],
      )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          border: Border.all(
            color: colorBordeSearch,
            style: BorderStyle.solid,
          )),
    ),
  );
}

Widget makeRoomsListSimple(
    List<Room> _rooms, List<Device> devices, BuildContext _context) {
  BuildContext listContext = _context;
  List<int> roomStatus = [];
  return ListView.builder(
      //controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: (_rooms.length),
      itemBuilder: (context, int index) {
        BuildContext itemContext = listContext;
        print(index);
        if (index == 0) {
          roomStatus.clear();
        }
        if (devices.length > 0) {
          print('devices:${devices.length}');
          int _roomStatus = 0;
          devices.forEach((element) {
            if (element.chipId == _rooms[index].readerId &&
                (element.status == 'ASSIGNED')) {
              {
                _roomStatus = 1;
              }
            }
            if (element.chipId == _rooms[index].readerId &&
                (element.status == 'UNRESPONSIVE')) {
              {
                _roomStatus = 0;
              }
            }
          });
          if (_roomStatus == 1) {
            devices.forEach((element) {
              if (element.chipId == _rooms[index].speakerId &&
                  (element.status == 'ASSIGNED')) {
                _roomStatus = 1;
              }
              if (element.chipId == _rooms[index].speakerId &&
                  (element.status == 'UNRESPONSIVE')) {
                _roomStatus = 0;
              }
            });
          }
          roomStatus.insert(index, _roomStatus);
        } else {
          roomStatus.insert(index, 2);
        }
        print(roomStatus);
        if (index == _rooms.length - 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    child: Dialog(
                      //scrollable: true,
                      insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          threeIconCardDialog(
                              _rooms[index],
                              roomIcon(40.0),
                              editIcon(40.0, colorMedico),
                              deleteIcon(40.0, colorMedico),
                              _context),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                    context: _context,
                  );
                },
                child: threeIconCardSimple(
                    _rooms[index],
                    roomStatus[index],
                    editIcon(40.0, colorMedico),
                    deleteIcon(40.0, colorMedico),
                    _context),
              ),
              SizedBox(
                height: 100.0,
              )
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    child: Dialog(
                      //scrollable: true,
                      insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          threeIconCardDialog(
                              _rooms[index],
                              roomIcon(40.0),
                              editIcon(40.0, colorMedico),
                              deleteIcon(40.0, colorMedico),
                              _context),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    ),
                    context: _context,
                  );
                },
                child: threeIconCardSimple(
                    _rooms[index],
                    roomStatus[index],
                    editIcon(40.0, colorMedico),
                    deleteIcon(40.0, colorMedico),
                    _context),
              ),
              //Divider(),
            ],
          );
        }
      });
}

Widget makeRoomsListSimpleNoStatus(
    List<Room> _rooms, List<Device> devices, BuildContext _context) {
  BuildContext listContext = _context;
  List<int> roomStatus = [];
  return ListView.builder(
      //controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: (_rooms.length),
      itemBuilder: (context, int index) {
        BuildContext itemContext = listContext;
        print(index);
        if (index == 0) {
          roomStatus.clear();
        }
        if (devices.length > 0) {
          print('devices:${devices.length}');
          int _roomStatus = 0;
          devices.forEach((element) {
            if (element.chipId == _rooms[index].readerId) {
              {
                _roomStatus = 1;
              }
            }
          });
          if (_roomStatus == 1) {
            devices.forEach((element) {
              if (element.chipId == _rooms[index].speakerId) {
                _roomStatus = 1;
              }
            });
          }
          roomStatus.insert(index, _roomStatus);
        } else {
          roomStatus.insert(index, 2);
        }
        print(roomStatus);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                showDialog(
                  barrierDismissible: true,
                  child: Dialog(
                    //scrollable: true,
                    insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        threeIconCardDialog(
                            _rooms[index],
                            roomIcon(40.0),
                            editIcon(40.0, colorMedico),
                            deleteIcon(40.0, colorMedico),
                            _context),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                  context: _context,
                );
              },
              child: threeIconCardSimpleNoStatus(
                  _rooms[index],
                  editIcon(40.0, colorMedico),
                  deleteIcon(40.0, colorMedico),
                  _context),
            ),
            //Divider(),
          ],
        );
      });
}

Widget makeRoomsList(List<Room> _rooms, BuildContext _context) {
  BuildContext listContext = _context;
  return ListView.builder(
      //controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: (_rooms.length),
      itemBuilder: (context, int index) {
        BuildContext itemContext = listContext;
        print(index);
        if (_rooms.length == index + 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              threeIconCard(
                  _rooms[index],
                  roomIcon(40.0),
                  editIcon(40.0, colorMedico),
                  deleteIcon(40.0, colorMedico),
                  itemContext),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              threeIconCard(
                  _rooms[index],
                  roomIcon(40.0),
                  editIcon(40.0, colorMedico),
                  deleteIcon(40.0, colorMedico),
                  _context),
              Divider(),
            ],
          );
        }
      });
}

Widget statusIcon(double size, int status) {
  LinearGradient _gradiente;
  if (status == 1) {
    _gradiente = gradiente;
    print('status1');
  } else {
    _gradiente = gradiente1;
    print('estatus0:$status');
  }
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0), gradient: _gradiente),
  );
}

Widget threeIconCardSimpleNoStatus(
    Room room, Widget editIcon, Widget deleteIcon, BuildContext _context) {
  Widget icon = Center(
    child: Column(
      children: [
        Center(child: circularProgressSimple()),
      ],
    ),
  );

  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Container(
      //width: MediaQuery.of(_context).size.width - 30,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  room.roomName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                  onTap: () {
                    BuildContext dialogContext;
                    showDialog(
                        context: _context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          dialogContext = _context;
                          return Container(
                            //width: MediaQuery.of(context).size.width - 28,
                            child: Dialog(
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 28.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0),
                                    width: double.infinity,
                                    //height: 30.0,
                                    //color: colorMedico,
                                    child: Center(
                                        child: Text(
                                      'Confirmation',
                                      style: TextStyle(
                                          fontSize: 30.0, color: colorVN),
                                    )),
                                  ),
                                  Container(
                                    //height: 40.0,

                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                            ' The room ${room.roomName} will be deleted' +
                                                '\n' +
                                                'Do you want to continue?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 20.0)),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 50.0,
                                                child: submitButtonS('Yes',
                                                    () async {
                                                  print('deleting');
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                  updating(context, 'Deleting');
                                                  //print(upSong.toJson());
                                                  final resp =
                                                      await ServerDataBloc()
                                                          .deleteRoom(room);
                                                  await Future.delayed(
                                                      Duration(seconds: 1));
                                                  if (resp) {
                                                    print('deleted');
                                                    Navigator.of(
                                                            _updatingContext)
                                                        .pop();
                                                    updated(dialogContext,
                                                        'Room deleted');
                                                  } else {
                                                    print('error');
                                                    Navigator.of(
                                                            _updatingContext)
                                                        .pop();
                                                    errorPopUp(dialogContext,
                                                        'Room not deleted');
                                                  }
                                                }),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 50.0,
                                                child: submitButtonNo('NO',
                                                    () async {
                                                  print('deleting');
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: deleteIcon),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                  onTap: () {
                    //ServerDataBloc().deleteRoomDevices();
                    ServerDataBloc().roomToModify(room);
                    ServerDataBloc().loadingEdit();
                    ServerDataBloc().requestDevices();
                    Navigator.of(_context)
                        .pushReplacementNamed('editRoomsPage');
                  },
                  child: editIcon),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        ]),
      ),
    ),
  );

  // Container(
  //   child: Center(child: Text(room.roomName)),
  // );
}

Widget threeIconCardSimple(Room room, int status, Widget editIcon,
    Widget deleteIcon, BuildContext _context) {
  Widget icon = Center(
    child: Column(
      children: [
        Center(child: circularProgressSimple()),
      ],
    ),
  );
  if (status < 2) {
    icon = statusIcon(25.0, status);
  }
  final List<PopupMenuItem<String>> _popUpMenuItems = [
    PopupMenuItem<String>(
      value: 'Edit',
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Edit',
                style: TextStyle(fontSize: 26),
              ),
              Expanded(child: Container()),
              editIcon
            ],
          ),
          Divider(),
        ],
      ),
    ),
    PopupMenuItem<String>(
      value: 'Delete',
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Delete',
                style: TextStyle(fontSize: 26),
              ),
              Expanded(child: Container()),
              deleteIcon
            ],
          ),
          Divider(),
        ],
      ),
    ),
  ];
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 25),
    child: Card(
      elevation: 5.0,
      color: Colors.white,
      child: Container(
        //width: MediaQuery.of(_context).size.width - 30,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    icon,
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        room.roomName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    PopupMenuButton<String>(
                        padding: EdgeInsets.all(0.0),
                        offset: Offset.fromDirection(0.0, 50.0),
                        onSelected: (value) {
                          switch (value) {
                            case 'Edit':
                              {
                                ServerDataBloc().roomToModify(room);
                                ServerDataBloc().loadingEdit();
                                ServerDataBloc().requestDevices();
                                Navigator.of(_context)
                                    .pushReplacementNamed('editRoomsPage');
                              }

                              break;
                            case 'Delete':
                              {
                                BuildContext dialogContext;
                                showDialog(
                                    context: _context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      dialogContext = _context;
                                      return Container(
                                        //width: MediaQuery.of(context).size.width - 28,
                                        child: Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 28.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 20.0),
                                                width: double.infinity,
                                                //height: 30.0,
                                                //color: colorMedico,
                                                child: Center(
                                                    child: Text(
                                                  'Confirmation',
                                                  style: TextStyle(
                                                      fontSize: 30.0,
                                                      color: colorVN),
                                                )),
                                              ),
                                              Container(
                                                //height: 40.0,

                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Text(
                                                        ' The room ${room.roomName} will be deleted' +
                                                            '\n' +
                                                            'Do you want to continue?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 20.0)),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 50.0,
                                                            child:
                                                                submitButtonS(
                                                                    'Yes',
                                                                    () async {
                                                              print('deleting');
                                                              Navigator.of(
                                                                      dialogContext)
                                                                  .pop();
                                                              updating(context,
                                                                  'Deleting');
                                                              //print(upSong.toJson());
                                                              final resp =
                                                                  await ServerDataBloc()
                                                                      .deleteRoom(
                                                                          room);
                                                              await Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          1));
                                                              if (resp) {
                                                                print(
                                                                    'deleted');
                                                                Navigator.of(
                                                                        _updatingContext)
                                                                    .pop();
                                                                updated(
                                                                    dialogContext,
                                                                    'Room deleted');
                                                              } else {
                                                                print('error');
                                                                Navigator.of(
                                                                        _updatingContext)
                                                                    .pop();
                                                                errorPopUp(
                                                                    dialogContext,
                                                                    'Room not deleted');
                                                              }
                                                            }),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            height: 50.0,
                                                            child:
                                                                submitButtonNo(
                                                                    'NO',
                                                                    () async {
                                                              print('deleting');
                                                              Navigator.of(
                                                                      dialogContext)
                                                                  .pop();
                                                            }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }

                              break;
                            case 'AddPlay':
                              //icon2();

                              break;
                            //default:
                          }
                        },
                        child: moreCircleIcon(30.0),
                        itemBuilder: (BuildContext _context) {
                          return _popUpMenuItems;
                        }),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
              ]),
        ),
      ),
    ),
  );

  // Container(
  //   child: Center(child: Text(room.roomName)),
  // );
}

Widget threeIconCardDialog(Room room, Widget roomIcon, Widget editIcon,
    Widget deleteIcon, BuildContext _context) {
  return Container(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          room.roomName,
          style: TextStyle(
            fontSize: 28.0,
          ),
          textAlign: TextAlign.start,
        ),
        Container(
          height: 3.0,
          color: colorMedico4,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          'Speaker',
          style: TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
                child: textBoxForm(
                    room.speakerName + '/' + room.speakerId, _context)),
          ],
        ),
        Text(
          'Reader',
          style: TextStyle(
            fontSize: 20.0,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
                child: textBoxForm(
                    room.readerName + '/' + room.readerId, _context)),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            GestureDetector(
                onTap: () {
                  BuildContext dialogContext;
                  showDialog(
                      context: _context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        dialogContext = _context;
                        return Container(
                          //width: MediaQuery.of(context).size.width - 28,
                          child: Dialog(
                            insetPadding:
                                EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 20.0),
                                  width: double.infinity,
                                  //height: 30.0,
                                  //color: colorMedico,
                                  child: Center(
                                      child: Text(
                                    'Confirmation',
                                    style: TextStyle(
                                        fontSize: 30.0, color: colorVN),
                                  )),
                                ),
                                Container(
                                  //height: 40.0,

                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                          ' The room ${room.roomName} will be deleted' +
                                              '\n' +
                                              'Do you want to continue?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20.0)),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 50.0,
                                              child: submitButtonS('Yes',
                                                  () async {
                                                print('deleting');
                                                Navigator.of(dialogContext)
                                                    .pop();
                                                updating(context, 'Deleting');
                                                //print(upSong.toJson());
                                                final resp =
                                                    await ServerDataBloc()
                                                        .deleteRoom(room);
                                                await Future.delayed(
                                                    Duration(seconds: 1));
                                                if (resp) {
                                                  print('deleted');
                                                  Navigator.of(_updatingContext)
                                                      .pop();
                                                  updated(dialogContext,
                                                      'Room deleted');
                                                } else {
                                                  print('error');
                                                  Navigator.of(_updatingContext)
                                                      .pop();
                                                  errorPopUp(dialogContext,
                                                      'Room not deleted');
                                                }
                                              }),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 50.0,
                                              child: submitButtonNo('NO',
                                                  () async {
                                                print('deleting');
                                                Navigator.of(dialogContext)
                                                    .pop();
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: deleteIcon),
            SizedBox(
              width: 10.0,
            ),
            GestureDetector(
                onTap: () {
                  //ServerDataBloc().deleteRoomDevices();
                  ServerDataBloc().roomToModify(room);
                  ServerDataBloc().loadingEdit();
                  ServerDataBloc().requestDevices();
                  Navigator.of(_context).pushReplacementNamed('editRoomsPage');
                },
                child: editIcon),
            SizedBox(
              width: 35.0,
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
      ]),
    ),
  );

  // Container(
  //   child: Center(child: Text(room.roomName)),
  // );
}

Widget threeIconCard(Room room, Widget roomIcon, Widget editIcon,
    Widget deleteIcon, BuildContext _context) {
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Container(
      height: 260,
      width: MediaQuery.of(_context).size.width - 30,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            room.roomName,
            style: TextStyle(
              fontSize: 28.0,
            ),
            textAlign: TextAlign.start,
          ),
          Container(
            height: 3.0,
            color: colorMedico4,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'Speaker',
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10.0,
          ),
          textBoxForm(room.speakerName + '/' + room.speakerId, _context),
          Text(
            'Reader',
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10.0,
          ),
          textBoxForm(room.readerName + '/' + room.readerId, _context),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                  onTap: () {
                    BuildContext dialogContext;
                    showDialog(
                        context: _context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          dialogContext = _context;
                          return Container(
                            //width: MediaQuery.of(context).size.width - 28,
                            child: Dialog(
                              insetPadding:
                                  EdgeInsets.symmetric(horizontal: 28.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 20.0),
                                    width: double.infinity,
                                    //height: 30.0,
                                    //color: colorMedico,
                                    child: Center(
                                        child: Text(
                                      'Confirmation',
                                      style: TextStyle(
                                          fontSize: 30.0, color: colorVN),
                                    )),
                                  ),
                                  Container(
                                    //height: 40.0,

                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                            ' The room ${room.roomName} will be deleted' +
                                                '\n' +
                                                'Do you want to continue?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 20.0)),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 50.0,
                                                child: submitButtonS('Yes',
                                                    () async {
                                                  print('deleting');
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                  updating(context, 'Deleting');
                                                  //print(upSong.toJson());
                                                  final resp =
                                                      await ServerDataBloc()
                                                          .deleteRoom(room);
                                                  await Future.delayed(
                                                      Duration(seconds: 1));
                                                  if (resp) {
                                                    print('deleted');
                                                    Navigator.of(
                                                            _updatingContext)
                                                        .pop();
                                                    updated(dialogContext,
                                                        'Room deleted');
                                                  } else {
                                                    print('error');
                                                    Navigator.of(
                                                            _updatingContext)
                                                        .pop();
                                                    errorPopUp(dialogContext,
                                                        'Room not deleted');
                                                  }
                                                }),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 50.0,
                                                child: submitButtonNo('NO',
                                                    () async {
                                                  print('deleting');
                                                  Navigator.of(dialogContext)
                                                      .pop();
                                                }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: deleteIcon),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                  onTap: () {
                    //ServerDataBloc().deleteRoomDevices();
                    ServerDataBloc().roomToModify(room);
                    ServerDataBloc().loadingEdit();
                    ServerDataBloc().requestDevices();
                    Navigator.of(_context)
                        .pushReplacementNamed('editRoomsPage');
                  },
                  child: editIcon),
              SizedBox(
                width: 35.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
        ]),
      ),
    ),
  );

  // Container(
  //   child: Center(child: Text(room.roomName)),
  // );
}

Widget listNameInput(String hintText, String textValue, Function update) {
  final _textValue = new TextEditingController(text: textValue);

  return Container(
      // width: _screenSize.width -48.0,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: colorBordeBotton,
          width: 1.0,
        ),
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

void renamePlayList(BuildContext _context, PlayList playList) {
  BuildContext dialogContext;
  String _listName = playList.listName;
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        dialogContext = _context;
        return Container(
          //width: MediaQuery.of(context).size.width - 20,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Playlist name',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  listNameInput('Name', _listName, (value) {
                                    _listName = value;
                                  }),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.0,
                              child: submitButton('Done', () async {
                                Navigator.of(dialogContext).pop();
                                updating(context, 'updating');
                                //print(upSong.toJson());
                                final resp = await ServerDataBloc()
                                    .renamePlayList(_listName, playList);
                                if (resp) {
                                  print('created');
                                  Navigator.of(_updatingContext).pop();
                                  updated(dialogContext, 'Playlist updated');
                                } else {
                                  print('error Playlist not updated');
                                  Navigator.of(_updatingContext).pop();
                                  errorPopUp(
                                      dialogContext, 'Playlist not updated');
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

void addPlayList(BuildContext _context) {
  BuildContext dialogContext;
  String _listName = 'Playlist1';
  showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        dialogContext = _context;
        return Container(
          //width: MediaQuery.of(context).size.width - 20,
          child: Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                // mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Playlist name',
                                    style: TextStyle(fontSize: 25.0),
                                  ),
                                  listNameInput('Name', 'Playlist1', (value) {
                                    _listName = value;
                                  }),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.0,
                              child: submitButton('Done', () async {
                                Navigator.of(dialogContext).pop();
                                updating(context, 'updating');
                                //print(upSong.toJson());
                                final resp = await ServerDataBloc()
                                    .createPlayList(_listName);
                                if (resp) {
                                  print('created');
                                  Navigator.of(_updatingContext).pop();
                                  updated(dialogContext, 'Playlist Created');
                                } else {
                                  print('error Playlist not created');
                                  Navigator.of(_updatingContext).pop();
                                  errorPopUp(
                                      dialogContext, 'Playlist not created');
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Widget makePlayListsListSimple(List<PlayList> playList, BuildContext _context) {
  return ListView.builder(
    itemCount: playList.length,
    itemBuilder: (BuildContext context, int index) {
      final List<PopupMenuItem<String>> _popUpMenuItems = [
        PopupMenuItem<String>(
          value: 'View',
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'View songs',
                    style: TextStyle(fontSize: 26),
                  ),
                  Expanded(child: Container()),
                  songIcon(40.0, colorMedico)
                ],
              ),
              Divider(),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Edit',
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Rename',
                    style: TextStyle(fontSize: 26),
                  ),
                  Expanded(child: Container()),
                  editIcon(40.0, colorMedico)
                ],
              ),
              Divider(),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Delete',
                    style: TextStyle(fontSize: 26),
                  ),
                  Expanded(child: Container()),
                  deleteIcon(40.0, colorMedico)
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ];
      if (playList.length - 1 == index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('playListPage',
                    arguments: playList[index]);
              },
              child: Card(
                elevation: 5.0,
                color: Colors.white,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            playList[index].listName,
                            style: TextStyle(fontSize: 25.0),
                          ),
                          Text(
                            '${playList[index].tracks} songs',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          // Text(
                          //   'Genre: ${playList[index].genre}',
                          //   style: TextStyle(fontSize: 18.0),
                          // ),
                          SizedBox(
                            height: 7.0,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                        padding: EdgeInsets.all(0.0),
                        offset: Offset.fromDirection(0.0, 50.0),
                        onSelected: (value) {
                          print(value);
                          switch (value) {
                            case 'Edit':
                              renamePlayList(_context, playList[index]);
                              break;
                            case 'Delete':
                              BuildContext dialogContext;
                              showDialog(
                                  context: _context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    dialogContext = _context;
                                    return Container(
                                      //width: MediaQuery.of(context).size.width - 28,
                                      child: Dialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  EdgeInsets.only(top: 20.0),
                                              width: double.infinity,
                                              //height: 30.0,
                                              //color: colorMedico,
                                              child: Center(
                                                  child: Text(
                                                'Confirmation',
                                                style: TextStyle(
                                                    fontSize: 30.0,
                                                    color: colorVN),
                                              )),
                                            ),
                                            Container(
                                              //height: 40.0,

                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Text(
                                                      ' The playlist ${playList[index].listName} will be deleted' +
                                                          '\n' +
                                                          'Do you want to continue?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          height: 50.0,
                                                          child: submitButtonS(
                                                              'Yes', () async {
                                                            print('deleting');
                                                            Navigator.of(
                                                                    dialogContext)
                                                                .pop();
                                                            updating(context,
                                                                'Deleting');
                                                            //print(upSong.toJson());
                                                            final resp = await ServerDataBloc()
                                                                .deletePlayList(
                                                                    playList[
                                                                        index]);
                                                            await Future
                                                                .delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            1));
                                                            if (resp) {
                                                              print('deleted');
                                                              Navigator.of(
                                                                      _updatingContext)
                                                                  .pop();
                                                              updated(
                                                                  dialogContext,
                                                                  'Playlist deleted');
                                                            } else {
                                                              print('error');
                                                              Navigator.of(
                                                                      _updatingContext)
                                                                  .pop();
                                                              errorPopUp(
                                                                  dialogContext,
                                                                  'Playlist not deleted');
                                                            }
                                                          }),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 50.0,
                                                          child: submitButtonNo(
                                                              'NO', () async {
                                                            print('deleting');
                                                            Navigator.of(
                                                                    dialogContext)
                                                                .pop();
                                                          }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });

                              break;
                            case 'View':
                              Navigator.of(context).pushNamed('playListPage',
                                  arguments: playList[index]);
                              break;
                          }
                        },
                        child: moreCircleIcon(30.0),
                        itemBuilder: (BuildContext _context) {
                          return _popUpMenuItems;
                        }),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100.0,
            )
          ],
        );
      } else {
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('playListPage', arguments: playList[index]);
          },
          child: Card(
            elevation: 5.0,
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        playList[index].listName,
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Text(
                        '${playList[index].tracks} songs',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      // Text(
                      //   'Genre: ${playList[index].genre}',
                      //   style: TextStyle(fontSize: 18.0),
                      // ),
                      SizedBox(
                        height: 7.0,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                    padding: EdgeInsets.all(0.0),
                    offset: Offset.fromDirection(0.0, 50.0),
                    onSelected: (value) {
                      switch (value) {
                        case 'Edit':
                          renamePlayList(_context, playList[index]);
                          break;
                        case 'Delete':
                          BuildContext dialogContext;
                          showDialog(
                              context: _context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                dialogContext = _context;
                                return Container(
                                  //width: MediaQuery.of(context).size.width - 28,
                                  child: Dialog(
                                    insetPadding:
                                        EdgeInsets.symmetric(horizontal: 28.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 20.0),
                                          width: double.infinity,
                                          //height: 30.0,
                                          //color: colorMedico,
                                          child: Center(
                                              child: Text(
                                            'Confirmation',
                                            style: TextStyle(
                                                fontSize: 30.0, color: colorVN),
                                          )),
                                        ),
                                        Container(
                                          //height: 40.0,

                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text(
                                                  ' The playlist ${playList[index].listName} will be deleted' +
                                                      '\n' +
                                                      'Do you want to continue?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20.0)),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 50.0,
                                                      child: submitButtonS(
                                                          'Yes', () async {
                                                        print('deleting');
                                                        Navigator.of(
                                                                dialogContext)
                                                            .pop();
                                                        updating(context,
                                                            'Deleting');
                                                        //print(upSong.toJson());
                                                        final resp =
                                                            await ServerDataBloc()
                                                                .deletePlayList(
                                                                    playList[
                                                                        index]);
                                                        await Future.delayed(
                                                            Duration(
                                                                seconds: 1));
                                                        if (resp) {
                                                          print('deleted');
                                                          Navigator.of(
                                                                  _updatingContext)
                                                              .pop();
                                                          updated(dialogContext,
                                                              'Playlist deleted');
                                                        } else {
                                                          print('error');
                                                          Navigator.of(
                                                                  _updatingContext)
                                                              .pop();
                                                          errorPopUp(
                                                              dialogContext,
                                                              'Playlist not deleted');
                                                        }
                                                      }),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 50.0,
                                                      child: submitButtonNo(
                                                          'NO', () async {
                                                        print('deleting');
                                                        Navigator.of(
                                                                dialogContext)
                                                            .pop();
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                          break;
                        case 'View':
                          Navigator.of(context).pushNamed('playListPage',
                              arguments: playList[index]);
                          break;
                      }
                    },
                    child: moreCircleIcon(30.0),
                    itemBuilder: (BuildContext _context) {
                      return _popUpMenuItems;
                    }),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}

Widget makePlayListsListDefault(
    List<PlayList> playList, BuildContext currentContext, String mode,
    {int songId}) {
  return ListView.builder(
    itemCount: playList.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        elevation: 5.0,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    playList[index].listName,
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    '${playList[index].tracks} songs',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  // Text(
                  //   'Genre: ${playList[index].genre}',
                  //   style: TextStyle(fontSize: 18.0),
                  // ),
                  SizedBox(
                    height: 7.0,
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () async {
                  print(index);
                  if (mode == 'Default') {
                    ServerDataBloc().bindDefault(playList[index]);
                    Navigator.of(context).pop();
                  } else if (mode == 'AddTag') {
                    ServerDataBloc().bindPlayList(playList[index]);
                    Navigator.of(context).pop();
                    print('aquí');
                  } else if (mode == 'AddTagSearch') {
                    ServerDataBloc().bindPlayList(playList[index]);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else if (mode == 'DefaultSearch') {
                    ServerDataBloc().bindDefault(playList[index]);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  } else if (mode == 'Select') {
                    updating(context, 'Adding song to playlist');
                    final resp = await ServerDataBloc()
                        .addSongToPlayList(playList[index], [songId]);
                    if (resp) {
                      updated(context, 'Song added to playlist');
                    }
                    // Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                  }
                },
                child: addIcon(40.0, colorMedico)),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
      );
    },
  );
}
