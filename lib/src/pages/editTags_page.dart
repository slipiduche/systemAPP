import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class EditTagsPage extends StatefulWidget {
  EditTagsPage({Key key}) : super(key: key);

  @override
  _EditTagsPageState createState() => _EditTagsPageState();
}

class _EditTagsPageState extends State<EditTagsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ServerDataBloc serverDataBloc = ServerDataBloc();
  bool tagHere = false, songHere = false;
  String tag = '', songId = '', tagId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serverDataBloc.deleteData();
    serverDataBloc.deletePrevtag();
  }

  @override
  Widget build(BuildContext context) {
    tagHere = false;
    return WillPopScope(
      onWillPop: () {
        serverDataBloc.deleteData();
        Navigator.of(context).pop();
      },
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
                          'Edit tag',
                          style: TextStyle(
                              color: colorVN,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w400),
                        ),
                        //Scan the tag  you want to Edit using your register device
                        SizedBox(height: 15.0),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.0),
                          child: Text(
                            'Scan your tag using your register device',
                            style: TextStyle(
                              fontSize: title1,
                            ),
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 28.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    'Tag Detected: ',
                                    style: TextStyle(
                                      fontSize: 25.0,
                                    ),
                                    // overflow: TextOverflow.clip,
                                    // textAlign: TextAlign.left,
                                  ),
                                  StreamBuilder(
                                    stream: ServerDataBloc().tagStream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> snapshot) {
                                      if (snapshot.hasData) {
                                        tagHere = true;
                                        tag = snapshot.data;
                                        tagId = '';
                                        serverDataBloc.requestPlayLists();
                                        serverDataBloc.requestTags();

                                        return Row(
                                          children: [
                                            Text(
                                              'Yes',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            statusIcon(25.0, 1),
                                          ],
                                        );
                                      } else {
                                        tagHere = false;
                                        return Row(
                                          children: [
                                            Text(
                                              'No',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            statusIcon(25.0, 0),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Bind a playlist',
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
                                stream: serverDataBloc.serverTagStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    tagHere = true;
                                    tagId = snapshot.data.id.toString();
                                    print('taghere:$tagHere');

                                    return GestureDetector(
                                      onTap: tagHere
                                          ? () {
                                              Navigator.of(context).pushNamed(
                                                  'bindPlayListPage');
                                              print('search song');
                                            }
                                          : () {
                                              print('do nothing');
                                            },
                                      child: StreamBuilder(
                                        stream: serverDataBloc.playListStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            songId =
                                                snapshot.data.id.toString();
                                            songHere = true;
                                            return searchBoxForm(
                                                snapshot.data.listName,
                                                context);
                                          } else {
                                            return searchBoxForm(
                                                'Select a playlist from the list',
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  } else {
                                    if (tagHere) {
                                      print('taghere:$tagHere');
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) => _action2(
                                              _scaffoldKey.currentContext));
                                    }
                                    tagHere = false;
                                    print('taghere:$tagHere');

                                    return GestureDetector(
                                      onTap: tagHere
                                          ? () {
                                              Navigator.of(context).pushNamed(
                                                  'bindPlayListPage');
                                              print('search playlists');
                                            }
                                          : () {
                                              print('do nothing2');
                                            },
                                      child: StreamBuilder(
                                        stream: serverDataBloc.playListStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            songHere = true;
                                            return searchBoxForm(
                                                snapshot.data.listName,
                                                context);
                                          } else {
                                            songHere = false;
                                            return searchBoxForm(
                                                'Select a playlist from the list',
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
                                stream: serverDataBloc.playListStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    tagHere = true;
                                    return Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40.0,
                                              child: submitButton('Edit', () {
                                                _action(songId, tagId, context);
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    tagHere = false;
                                    return Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40.0,
                                              child: submitButton('Edit', null),
                                            ),
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
                SizedBox(height: 5.0),
                gradientBar2(3),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(3),
        ),
      ),
    );
  }

  void _action(String _songId, String _tagId, BuildContext context) async {
    if (tagHere && songHere) {
      print('send tag');

      print(_songId);
      updating(context, 'Updating');
      final resp = await ServerDataBloc().editTag(_songId, _tagId);
      if (resp) {
        Navigator.of(context).pop();
        updated(context, 'Tag updated');
      } else {
        Navigator.of(context).pop();
        errorPopUp(context, 'Not updated');
      }
    } else {
      print('do nothing3');
    }
  }

  _action2(_context) {
    errorPopUp(_context, 'The tag does not exist');
    print('el tag no existe');
  }
}
