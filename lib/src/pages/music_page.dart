import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class MusicPage extends StatefulWidget {
  MusicPage({Key key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //exit(0);
        Navigator.of(context).pushReplacementNamed('homePage');
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        print('poppop');
      }, // SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
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
                Expanded(
                  child: Container(
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
                            child: musicIcon(98.0, colorMedico),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Music',
                            style: TextStyle(
                                color: colorVN,
                                fontSize: 40.0,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 40.0),
                          // tarjeta('Add songs', 'Add new songs',
                          //     addIcon(40, colorMedico), 9, context),
                          // SizedBox(height: 20.0),
                          tarjeta('Playlist', 'View my current playlists',
                              playListIcon(40), 20, context),
                          SizedBox(height: 20.0),
                          tarjeta('Song list', 'View my current songs',
                              listIcon(40), 6, context),
                          SizedBox(height: 20.0),
                          tarjeta(
                              'Change Default',
                              'Select a new default playlist',
                              Icon(Icons.settings,
                                  color: colorMedico, size: 40.0),
                              7,
                              context),
                        ],
                      ),
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
