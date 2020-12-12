import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class EditSongPage extends StatefulWidget {
  EditSongPage({Key key}) : super(key: key);

  @override
  _EditSongPageState createState() => _EditSongPageState();
}

class _EditSongPageState extends State<EditSongPage> {
  //FilePickerDemo filePicker = new FilePickerDemo();
  ServerDataBloc serverDataBloc = ServerDataBloc();
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
              Expanded(
                child: Container(
                  //height: 200.0,
                  //width: double.infinity,

                  child: StreamBuilder(
                    stream: serverDataBloc.serverDataStream,
                    // initialData: initialData ,
                    builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
                      
                      if (!snapshot.hasData) {
                        if((serverDataBloc.token==null)||(serverDataBloc.token=='')) {
                          serverDataBloc.login();
                        }
                        return Container(child: CircularProgressIndicator());
                      } else { print(snapshot.data[0].songName);
                      
                        return Container(
                          child: makeSongsList(context, snapshot.data, editIcon(40.0, colorMedico)),
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
    );
  }
}
