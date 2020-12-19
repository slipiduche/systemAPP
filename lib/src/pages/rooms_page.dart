import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

class RoomsPage extends StatefulWidget {
  RoomsPage({Key key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    serverDataBloc.requestRooms();
    return WillPopScope(
      onWillPop: () {
        //exit(0);
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        print('poppop');
      },
      child: SafeArea(
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
                SizedBox(height: 26.0),
                Container(
                  height: 123,
                  width: 123,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100.0)),
                  child: roomIcon(98.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Rooms',
                  style: TextStyle(
                      color: colorVN,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 40.0),
                Expanded(
                    child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        StreamBuilder(
                          stream: serverDataBloc.serverRoomsStream,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length < 1) {
                                return Column(
                                  children: <Widget>[
                                    Text(
                                      'No rooms configured',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Add rooms',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Center(
                                      child: Container(
                                          height: 70.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              40,
                                          child: Expanded(
                                              child: GestureDetector(
                                            onTap: () {
                                              print('add room');
                                              Navigator.of(context).pushNamed('addRoomsPage');
                                            },
                                            child:
                                                addRoomIcon(50.0, colorMedico),
                                          ))),
                                    ),
                                  ],
                                );
                              } else {

                              }
                            } else {
                              return Container(
                                height: 40.0,
                                width: 40,
                                margin: EdgeInsets.all(6.0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      colorMedico),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )),
                gradientBar2(0),
              ],
            ),
          ),
          bottomNavigationBar: BottomBar(0),
        ),
      ),
    );
  }
}

