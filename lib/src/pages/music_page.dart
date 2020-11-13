import 'package:flutter/material.dart';
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
                        tarjeta('Add songs', 'Add new songs',
                            addIcon(40, colorMedico), 5, context),
                        SizedBox(height: 20.0),
                        tarjeta('Delete songs', 'Delete old songs',
                            deleteIcon(40, colorMedico), 6, context),
                        SizedBox(height: 20.0),
                        tarjeta('Change Default', 'Select a new default song',
                            addIcon(40, colorMedico), 7, context),
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
