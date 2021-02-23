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
                print('add playlist');
                //Navigator.of(context).pushNamed('playListPage');
              },
              child: floatingIcon(60.0),
            ),
          ),
        ),
      ),
    );
  }

  void addPlayList() {}

  Widget makePlayListsListSimple(
      List<PlayList> playList, BuildContext currentContext) {
    return ListView.builder(
      itemCount: playList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5.0,
          color: Colors.white,
          child: Column(
            children: [Text(playList[index].listName)],
          ),
        );
      },
    );
  }
}
