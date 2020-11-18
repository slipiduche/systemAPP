import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class SongsPage extends StatefulWidget {
  SongsPage({Key key}) : super(key: key);

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
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
                        SizedBox(height: 40.0),
                        tarjeta('Add song', 'Add new song',
                            addSongIcon(40, colorMedico), 8, context),
                        SizedBox(height: 20.0),
                        tarjeta('Add songs', 'Add multiple new songs',
                            addSongsIcon(40, colorMedico), 9, context),
                        SizedBox(height: 20.0),
                        tarjeta('Edit songs', 'Edit songs names and artist',
                            editIcon(40, colorMedico), 10, context),
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
    );
  }
}
