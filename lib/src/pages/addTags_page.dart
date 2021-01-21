import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class AddTagsPage extends StatefulWidget {
  AddTagsPage({Key key}) : super(key: key);

  @override
  _AddTagsPageState createState() => _AddTagsPageState();
}

class _AddTagsPageState extends State<AddTagsPage> {
  ServerDataBloc serverDataBloc = ServerDataBloc();
  bool tagHere = false, songHere = false;
  String tag = '', songId = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 26.0),
                      Container(
                        height: 123,
                        width: 123,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100.0)),
                        child: tagIcon(98.0, colorMedico),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Tags',
                        style: TextStyle(
                            color: colorVN,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w400),
                      ),
                      //Scan the tag  you want to add using your register device
                      SizedBox(height: 15.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Scan your tag using your register device',
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25.0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Tag code',
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                              // overflow: TextOverflow.clip,
                              // textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            StreamBuilder(
                              stream: serverDataBloc.tagStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  tagHere = true;
                                  tag = snapshot.data;
                                  serverDataBloc.requestSongs();
                                  serverDataBloc.requestTags();

                                  return textBoxForm(snapshot.data, context);
                                } else {
                                  tag = '';
                                  return textBoxForm(
                                      'The tag will appear here', context);
                                }
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Bind a song',
                              style: TextStyle(
                                fontSize: 25.0,
                              ),
                              // overflow: TextOverflow.clip,
                              // textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            StreamBuilder(
                              stream: serverDataBloc.tagStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: tagHere
                                        ? () {
                                            Navigator.of(context)
                                                .pushNamed('bindSongPage');
                                            print('search song');
                                          }
                                        : null,
                                    child: StreamBuilder(
                                      stream: serverDataBloc.songStream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          songId = snapshot.data.id.toString();
                                          songHere = true;
                                          return searchBoxForm(
                                              snapshot.data.songName, context);
                                        } else {
                                          return searchBoxForm(
                                              'Select a song from the list',
                                              context);
                                        }
                                      },
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: tagHere
                                        ? () {
                                            Navigator.of(context)
                                                .pushNamed('bindSong');
                                            print('search song');
                                          }
                                        : null,
                                    child: StreamBuilder(
                                      stream: serverDataBloc.songStream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.hasData) {
                                          songHere = true;
                                          return searchBoxForm(
                                              snapshot.data.songName, context);
                                        } else {
                                          return searchBoxForm(
                                              'Select a song from the list',
                                              context);
                                        }
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            StreamBuilder(
                              stream: serverDataBloc.songStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Center(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: submitButton('Done', () {
                                          _action(tag, songId, context);
                                        }),
                                      ),
                                    ],
                                  ));
                                } else {
                                  return Center(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: submitButton('Done', () {
                                            _action(tag, songId, context);
                                          }),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(child: Container()),
              gradientBar2(1),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(1),
      ),
    );
  }

  void _action(String _tag, String _songId, BuildContext context) async {
    if (tagHere && songHere) {
      print('send tag');
      print(_tag);
      print(_songId);
      updating(context, 'Adding');
      final resp = await serverDataBloc.addTag(_tag, _songId);
      if (resp) {
        Navigator.of(context).pop();
        updated(context, 'Added');
      } else {
        Navigator.of(context).pop();
        errorPopUp(context, 'Not added');
      }
    } else {
      print('do nothing');
    }
  }
}
