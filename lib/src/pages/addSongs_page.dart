import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/provider/file_provider.dart';

class AddSongsPage extends StatefulWidget {
  AddSongsPage({Key key}) : super(key: key);

  @override
  _AddSongsPageState createState() => _AddSongsPageState();
}

class _AddSongsPageState extends State<AddSongsPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  Widget build(BuildContext context) {
    awaitUpload = 0;

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
                'Add songs',
                style: TextStyle(
                    color: colorVN,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 25.0),
              Expanded(
                child: Container(
                  //height: 200.0,
                  //width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25.0),

                  child: FilePickerDemo(true, "Select the song you want to add",
                      "Search for a song"),
                ),
              ),
              SizedBox(height: 5.0),
              gradientBar2(2),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(2),
      ),
    );
  }
}
