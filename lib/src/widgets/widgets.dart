import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/provider/upload_provider.dart';

int awaitUpload = 0;

void _moveTo(index, context) async {
  if (index == 0) {
    await Navigator.of(context)
        .pushReplacementNamed('roomsPage', arguments: null);
  }

  if (index == 1) {
    await Navigator.of(context)
        .pushReplacementNamed('tagPage', arguments: null);
  }
  if (index == 2) {
    await Navigator.of(context)
        .pushReplacementNamed('homePage', arguments: null);
  }
  if (index == 3) {
    await Navigator.of(context)
        .pushReplacementNamed('musicPage', arguments: null);
  }
}

Widget submitButton(text, void Function() function) {
  return RaisedButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: colorMedico)),
      elevation: 4.0,
      color: colorMedico,
      onPressed: function);
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
      if (index == 5) {
        await Navigator.of(context).pushNamed('songsPage', arguments: null);
      }
      if (index == 6) {
        await Navigator.of(context)
            .pushNamed('deleteSongPage', arguments: null);
      }

      if (index == 1) {
        await Navigator.of(context)
            .pushReplacementNamed('tagPage', arguments: null);
      }
      if (index == 2) {
        await Navigator.of(context)
            .pushReplacementNamed('homePage', arguments: null);
      }
      if (index == 3) {
        await Navigator.of(context)
            .pushReplacementNamed('musicPage', arguments: null);
      }
      if (index == 0) {
        await Navigator.of(context)
            .pushReplacementNamed('roomsPage', arguments: null);
      }
    },
  );
}

class TwoIconCard extends StatefulWidget {
  @override
  String label, description;
  Widget icon;
  dynamic icon1;
  String path, name;
  dynamic context;
  TwoIconCard(this.label, this.description, this.icon, this.icon1, this.path,
      this.context, this.name,
      {Key key})
      : super(key: key);
  _TwoIconCardState createState() =>
      _TwoIconCardState(label, description, icon, icon1, path, context, name);
}

class _TwoIconCardState extends State<TwoIconCard> {
  @override
  String label, description;
  Widget icon;
  dynamic icon1;
  String path, name;
  dynamic contexto;
  _TwoIconCardState(this.label, this.description, this.icon, this.icon1,
      this.path, this.contexto, this.name);

  Widget build(BuildContext context) {
    if (awaitUpload == 0) {
      return twoIconCard(label, description, icon, icon1, path, contexto, name);
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
      String path, dynamic context, String name) {
    String _path = path;
    print(_path);

    return Card(
      elevation: 5.0,
      color: Colors.white,
      child: Container(
        height: 105,
        width: MediaQuery.of(context).size.width - 30,
        child: Row(children: [
          Expanded(child: Container()),
          icon,
          Expanded(child: Container()),
          Container(
            width: MediaQuery.of(context).size.width - 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w100,
                  ),
                  overflow: TextOverflow.ellipsis,
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
          ),
          Expanded(child: Container()),
          Builder(builder: (context) {
            if (icon1 == false) {
              return GestureDetector(onTap: null, child: Container());
            } else {
              return GestureDetector(
                  onTap: () async {
                    print(_path);
                    uploading(1, 1, context);
                    awaitUpload =
                        await ServerDataBloc().uploadSong(_path, name);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: icon1);
            }
          }),
          Expanded(child: Container()),
        ]),
      ),
    );
  }
}

Widget makeSongsList(
    BuildContext context, List<Music> list, Widget icon3, String mode) {
  return ListView.builder(
      //controller: _scrollController,
      itemCount: (list.length),
      itemBuilder: (BuildContext context, int index) {
        print(index);

        return twoIconCardSingle(
            list[index], songIcon(40.0, colorMedico), icon3, context, mode);
      });
}

Widget twoIconCardSingle(
    Music song, Widget icon, dynamic icon1, dynamic context, String mode) {
  return Card(
    elevation: 5.0,
    color: Colors.white,
    child: Container(
      height: 105,
      width: MediaQuery.of(context).size.width - 30,
      child: Row(children: [
        Expanded(child: Container()),
        icon,
        Expanded(child: Container()),
        Container(
          width: MediaQuery.of(context).size.width - 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                song.songName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w100,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                song.artist,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w100),
              )
            ],
          ),
        ),
        Expanded(child: Container()),
        Builder(builder: (context) {
          if (icon1 == false) {
            return GestureDetector(onTap: null, child: Container());
          } else {
            return GestureDetector(
                onTap: () async {
                  print('presionaste id ');
                  print(song.id);
                  if (mode == 'edit') {
                    editing(song, context);
                  } else if (mode == 'delete') {
                    deleting(song, context);
                  } else if (mode == 'add') {
                    print('binding');
                    ServerDataBloc().bindSong(song);
                    Navigator.of(context).pop();
                  }
                },
                child: icon1);
          }
        }),
        Expanded(child: Container()),
      ]),
    ),
  );
}

void deleting(Music song, BuildContext context) {
  Music upSong = song;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width - 20,
          child: Dialog(
            //insetPadding: EdgeInsets.symmetric(horizontal:10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 30.0,
                  color: colorMedico,
                  child: Center(
                      child: Text(
                    'Delete the song?',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(song.songName, style: TextStyle(fontSize: 20.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          submitButton('Delete', () async {
                            Navigator.pop(context);
                            updating(context, 'Deleting');
                            //print(upSong.toJson());
                            final resp =
                                await ServerDataBloc().deleteSong(song);
                            if (resp) {
                              print('deleted');
                              Navigator.pop(context);
                              updated(context, 'Deleted');
                            } else {
                              print('error');
                              Navigator.pop(context);
                              errorPopUp(context, 'Error');
                            }
                          }),
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

void editing(Music song, BuildContext context) {
  Music upSong = song;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width - 20,
          child: Dialog(
            //insetPadding: EdgeInsets.symmetric(horizontal:10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 30.0,
                  color: colorMedico,
                  child: Center(
                      child: Text(
                    'Edit the song',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  )),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          submitButton('Done', () async {
                            Navigator.pop(context);
                            updating(context, 'updating');
                            print(upSong.toJson());
                            final resp =
                                await ServerDataBloc().updateSong(upSong);
                            if (resp) {
                              print('updated');
                              Navigator.pop(context);
                              updated(context, 'Updated');
                            } else {
                              print('error');
                              Navigator.pop(context);
                              errorPopUp(context, 'Error');
                            }
                          }),
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

void updating(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 100.0,
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorMedico),
                ),
                Text(
                  '$message...',
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
        );
      });
}

void updated(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 100.0,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.check,
                  size: 50.0,
                  color: colorMedico,
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 100.0),
          actions: <Widget>[
            Expanded(
              child: Center(
                child: submitButton('OK', () {
                  Navigator.pop(context);
                  if (message == "Updated") {
                    Navigator.of(context).pushReplacementNamed('editSongPage');
                  } else if (message == "Deleted") {
                    Navigator.of(context)
                        .pushReplacementNamed('deleteSongPage');
                  }
                }),
              ),
            ),
          ],
        );
      });
}

void errorPopUp(BuildContext context, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 100.0,
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  size: 50.0,
                  color: Colors.red,
                ),
                Text(
                  message,
                  style: TextStyle(fontSize: 20.0),
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 100.0),
          actions: <Widget>[
            Expanded(
              child: Center(
                child: submitButton('OK', () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, 'addSongsPage');
                }),
              ),
            ),
          ],
        );
      });
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
      //padding: EdgeInsets.all(25.0),
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
        return AlertDialog(
          content: Container(
            height: 100.0,
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(colorMedico),
                ),
                Text(
                  'Uploading...$i of $songsCount',
                  style: TextStyle(fontSize: 20.0),
                )
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
            icon: roomBarIcon(25),
            title: Container(),
            activeIcon: roomBarIconS(25)),
        BottomNavigationBarItem(
            icon: tagBarIcon(25),
            title: Container(),
            activeIcon: tagBarIconS(25)),
        BottomNavigationBarItem(
          icon: homeBarIcon(25),
          title: Container(),
        ),
        BottomNavigationBarItem(
            icon: musicBarIcon(25),
            title: Container(),
            activeIcon: musicBarIconS(25)),
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
    if (index == 0) {
      await Navigator.of(context)
          .pushReplacementNamed('roomsPage', arguments: null);
    }

    if (index == 1) {
      await Navigator.of(context)
          .pushReplacementNamed('tagPage', arguments: null);
    }
    if (index == 2) {
      await Navigator.of(context)
          .pushReplacementNamed('homePage', arguments: null);
    }
    if (index == 3) {
      await Navigator.of(context)
          .pushReplacementNamed('musicPage', arguments: null);
    }
  }
}

Widget textBoxForm(String content, BuildContext context) {
  return Container(
    child: Container(
      height: 41.0,
      width: MediaQuery.of(context).size.width - 52.0,
      child: Expanded(
          child: Row(
        children: [
          SizedBox(
            width: 10.0,
          ),
          Text(
            content,
            style: TextStyle(color: colorLetraSearch, fontSize: 24),
            overflow: TextOverflow.ellipsis,
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
      width: MediaQuery.of(context).size.width - 52.0,
      child: Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width-100,
            child: Text(
              content,
              style: TextStyle(color: colorLetraSearch, fontSize: 24),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          searchIcon(20.0, colorMedico),
          SizedBox(
            width: 5.0,
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
