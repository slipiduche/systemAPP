import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/provider/file_provider.dart';

class AddSongPage extends StatefulWidget {
  AddSongPage({Key key}) : super(key: key);

  @override
  _AddSongPageState createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  //FilePickerDemo filePicker = new FilePickerDemo();
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  Widget build(BuildContext context) {
    awaitUpload = 0;
    
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
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
              SizedBox(height: 30.0),
              Expanded( //container
                child: Container(
                  //height: 200.0,
                  //width: double.infinity,

                  child: FilePickerDemo(false,
                      "Select the song you want to add", "Search for a song"),
                ),
              ),
              gradientBar2(2),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(2),
      ),
    );
  }
}
