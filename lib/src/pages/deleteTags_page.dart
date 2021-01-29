import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class DeleteTagsPage extends StatefulWidget {
  DeleteTagsPage({Key key}) : super(key: key);

  @override
  _DeleteTagsPageState createState() => _DeleteTagsPageState();
}

class _DeleteTagsPageState extends State<DeleteTagsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String tag = '', songId = '', tagId = '';
  ServerDataBloc serverDataBloc = ServerDataBloc();
  bool tagHere = false, songHere = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serverDataBloc.deleteData();
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
                          'Tags',
                          style: TextStyle(
                              color: colorVN,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w400),
                        ),
                        //Scan the tag  you want to Delete using your register device
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
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        tagHere = true;
                                        serverDataBloc.requestSongs();
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
                                'Song Binded',
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
                                      onTap: null,
                                      child: StreamBuilder(
                                        stream: serverDataBloc.songStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            songId =
                                                snapshot.data.id.toString();
                                            songHere = true;
                                            return textBoxForm(
                                                snapshot.data.songName,
                                                context);
                                          } else {
                                            return textBoxForm(
                                                'Song will appear here',
                                                context);
                                          }
                                        },
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: null,
                                      child: StreamBuilder(
                                        stream: serverDataBloc.songStream,
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            songHere = true;
                                            return textBoxForm(
                                                snapshot.data.songName,
                                                context);
                                          } else {
                                            return textBoxForm(
                                                'Song will appear here',
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
                                stream: serverDataBloc.serverTagStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40.0,
                                              child: submitButton('Delete', () {
                                                _action(
                                                    snapshot.data.id.toString(),
                                                    context);
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 40.0,
                                              child:
                                                  submitButton('Delete', null),
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

  void _action(String _tagId, BuildContext context) async {
    if (tagHere && songHere) {
      BuildContext dialogContext;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            dialogContext = context;
            return Container(
              //width: MediaQuery.of(context).size.width - 28,
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
                      //height: 40.0,

                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                              ' The tag will be deleted' +
                                  '\n' +
                                  'Do you want to continue?',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20.0)),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50.0,
                                  child: submitButtonS('Yes', () async {
                                    print('send tag');
                                    Navigator.of(context).pop();
                                    print(_tagId);
                                    updating(context, 'Deleting');
                                    final resp = await ServerDataBloc()
                                        .deleteTag(_tagId);
                                    if (resp) {
                                      Navigator.of(_scaffoldKey.currentContext)
                                          .pop();
                                      updated(_scaffoldKey.currentContext,
                                          'Tag deleted');
                                    } else {
                                      Navigator.of(_scaffoldKey.currentContext)
                                          .pop();
                                      errorPopUp(_scaffoldKey.currentContext,
                                          'Not deleted');
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
    } else {
      print('do nothing');
    }
  }
}
