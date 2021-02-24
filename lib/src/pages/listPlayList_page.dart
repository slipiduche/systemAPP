import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/search/room_search.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

class ListPlayListPage extends StatefulWidget {
  ListPlayListPage({Key key}) : super(key: key);

  @override
  _ListPlayListPageState createState() => _ListPlayListPageState();
}

class _ListPlayListPageState extends State<ListPlayListPage> {
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
    serverDataBloc.requestPlayLists();

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('musicPage');
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
                Container(
                  height: 123,
                  width: 123,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: playListIcon(50.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Playlists',
                  style: TextStyle(
                      color: colorVN,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w400),
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
                                        'No playlist configured',
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
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 25.0),
                                            child: makePlayListsListSimple(
                                                snapshot.data, context),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                print('no data');
                                //serverDataBloc.requestPlayLists();
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
                print('add playlist');
                addPlayList(context);
                //Navigator.of(context).pushNamed('playListPage');
              },
              child: floatingIcon(60.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget makePlayListsListSimple(
      List<PlayList> playList, BuildContext currentContext) {
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

    return ListView.builder(
      itemCount: playList.length,
      itemBuilder: (BuildContext context, int index) {
        if (playList.length - 1 == index) {
          return Column(
            children: [
              Card(
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
                            style: TextStyle(fontSize: 36.0),
                          ),
                          Text(
                            '${playList[index].tracks} songs',
                            style: TextStyle(fontSize: 20.0),
                          ),
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
                              break;
                            case 'Delete':
                              break;
                            case 'View':
                              break;
                          }
                        },
                        child: moreCircle(30.0),
                        itemBuilder: (BuildContext _context) {
                          return _popUpMenuItems;
                        }),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100.0,
              )
            ],
          );
        } else {
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
                        style: TextStyle(fontSize: 36.0),
                      ),
                      Text(
                        '${playList[index].tracks} songs',
                        style: TextStyle(fontSize: 20.0),
                      ),
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
                          break;
                        case 'Delete':
                          break;
                        case 'View':
                          break;
                      }
                    },
                    child: moreCircle(30.0),
                    itemBuilder: (BuildContext _context) {
                      return _popUpMenuItems;
                    }),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
