import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class BindSpeakerPage extends StatefulWidget {
  BindSpeakerPage({Key key}) : super(key: key);

  @override
  _BindSpeakerPageState createState() => _BindSpeakerPageState();
}

class _BindSpeakerPageState extends State<BindSpeakerPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                child: speakerIcon(98.0, colorMedico),
              ),
              SizedBox(height: 8.0),
              Text(
                'Speakers',
                style: TextStyle(
                    color: colorVN,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15.0),
              Text(
                'Select the speaker you want to Bind',
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
                    stream: serverDataBloc.serverDevicesStream,
                    // initialData: initialData ,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Device>> snapshot) {
                      if (!snapshot.hasData) {
                        if ((serverDataBloc.token == null) ||
                            (serverDataBloc.token == '')) {
                          serverDataBloc.login();
                        } else {
                          serverDataBloc.requestDevices();
                        }
                        return Stack(
                          children: <Widget>[
                            Container(
                              height: 40.0,
                              width: 40.0,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(colorMedico),
                              ),
                            ),
                          ],
                        );
                      } else {
                        //print(snapshot.data[0].deviceName);

                        return Container(
                          child: makeDevicesList(context, snapshot.data,
                              addIcon(40.0, colorMedico), 'bind','SPEAKER'),
                        );
                      }
                    },
                  ),
                ),
              ),
              gradientBar2(1),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(1),
      ),
    );
  }
}
