import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class ChangeDefaultPage extends StatefulWidget {
  ChangeDefaultPage({Key key}) : super(key: key);

  @override
  _ChangeDefaultPageState createState() => _ChangeDefaultPageState();
}

class _ChangeDefaultPageState extends State<ChangeDefaultPage> {
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
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 26.0),
                          Center(
                            child: Container(
                              height: 123,
                              width: 123,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100.0)),
                              child: musicIcon(98.0, colorMedico),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Center(
                            child: Text(
                              'Music',
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 40.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Current',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Card(
                            child: Column(
                              children: [
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    musicBarIconS(40.0),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'default',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: colorLetraSearch,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'GOOGLE TRANSLATE',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: colorLetraSearch),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),
                            color: Colors.white,
                            elevation: 4.0,
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Change',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: colorVN,
                                  fontSize: 36.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Card(
                            color: Colors.white,
                            elevation: 4.0,
                            child: Column(
                              children: [
                                SizedBox(height: 20.0),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed('playSongPage');
                                      },
                                      child: searchBoxForm(
                                          'Select a song from the list',
                                          context)),
                                ),
                                SizedBox(height: 10.0),
                                submitButton('Change', () {}),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          )
                        ],
                      ),
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
