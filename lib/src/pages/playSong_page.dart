import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class PlaySongPage extends StatefulWidget {
  PlaySongPage({Key key}) : super(key: key);

  @override
  _PlaySongPageState createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySongPage> {
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
        serverDataBloc.songPlayer.pause();
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
                  child: songIcon(98.0, colorMedico),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Songs',
                  style: TextStyle(
                      color: colorVN,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Select  the song',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.0),
                Expanded(
                  child: Container(
                    //height: 200.0,
                    //width: double.infinity,

                    child: StreamBuilder(
                      stream: serverDataBloc.serverDataStream,
                      // initialData: initialData ,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Music>> snapshot) {
                        if (!snapshot.hasData) {
                          if ((serverDataBloc.token == null) ||
                              (serverDataBloc.token == '')) {
                            serverDataBloc.login();
                          } else {
                            serverDataBloc.requestSongs();
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

                          return Container(
                            child: makeSongsListPlay(
                                _scaffoldKey.currentContext,
                                snapshot.data,
                                speakerIcon(40.0, colorMedico),
                                addIcon(40.0, colorMedico),
                                'changeDefault'),
                          );
                        }
                      },
                    ),
                  ),
                ),
                gradientBar2(3),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(3),
        ),
      ),
    );
  }
}
