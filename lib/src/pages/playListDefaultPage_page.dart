import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/pages/playList_page.dart';
import 'package:systemAPP/src/search/playLists_search.dart';
import 'package:systemAPP/src/search/song_search.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class PlayListDefaultPage extends StatefulWidget {
  PlayListDefaultPage({Key key}) : super(key: key);

  @override
  _PlayListDefaultPageState createState() => _PlayListDefaultPageState();
}

class _PlayListDefaultPageState extends State<PlayListDefaultPage> {
  List<PlayList> _playLists;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //FilePickerDemo filePicker = new FilePickerDemo();
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //exit(0);

        Navigator.of(context).pop();
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        print('poppop');
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
                SizedBox(height: 26.0),
                Container(
                  height: 123,
                  width: 123,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Container(
                    height: 123,
                    width: 123,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.0)),
                    child: playListIcon(50.0),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Playlists',
                  style: TextStyle(
                      color: colorVN,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Select the playlist',
                  style: TextStyle(
                    fontSize: title1,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Container(
                  //margin: EdgeInsets.symmetric(horizontal: 28.0),
                  //padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          if (_playLists.length > 0) {
                            showSearch(
                                context: context,
                                delegate: PlayListSearchDelegate(
                                    _playLists, 'Default'));
                          } else {}
                        },
                        child: Container(
                          height: 41.0,

                          //width: MediaQuery.of(context).size.width - 52.0,
                          child: Container(
                              //margin: EdgeInsets.symmetric(horizontal: 0),
                              //expanded
                              child: Row(
                            children: [
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Text(
                                  'Search for a playlist',
                                  style: TextStyle(
                                      color: colorLetraSearch,
                                      fontSize: search1),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              searchIcon(20.0, colorMedico),
                              SizedBox(
                                width: 10.0,
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0),
                Expanded(
                  child: Container(
                    //height: 200.0,
                    //width: double.infinity,

                    child: StreamBuilder(
                      stream: serverDataBloc.serverPlayListsStream,
                      // initialData: initialData ,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PlayList>> snapshot) {
                        if (!snapshot.hasData) {
                          if ((serverDataBloc.token == null) ||
                              (serverDataBloc.token == '')) {
                            serverDataBloc.login();
                          } else {
                            serverDataBloc.requestPlayLists();
                          }
                          return Stack(
                            children: <Widget>[
                              Container(
                                height: 40.0,
                                width: 40.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      colorMedico),
                                ),
                              ),
                            ],
                          );
                        } else {
                          //print(snapshot.data[0].songName);
                          _playLists = snapshot.data;
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 25.0),
                              child: makePlayListsListDefault(
                                  _playLists, _scaffoldKey.currentContext));
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                gradientBar2(2),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(2),
        ),
      ),
    );
  }
}
