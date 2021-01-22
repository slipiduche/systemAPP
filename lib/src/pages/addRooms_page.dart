import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

class AddRoomsPage extends StatefulWidget {
  AddRoomsPage({Key key}) : super(key: key);

  @override
  _AddRoomsPageState createState() => _AddRoomsPageState();
}

class _AddRoomsPageState extends State<AddRoomsPage> {
  String _roomName;
  String _readerId, _speakerId;
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //serverDataBloc.requestRooms();
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
              SizedBox(height: 30.0),
              Expanded(
                  child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Create a new room',
                          style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 10.0),
                      roomCard(context),
                    ],
                  ),
                ),
              )),
              gradientBar2(1),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(1),
      ),
    );
  }

  Widget roomCard(BuildContext _context) {
    return Card(
      elevation: 5.0,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Room Name',
              style: TextStyle(
                fontSize: 25.0,
              ),
              // overflow: TextOverflow.clip,
              // textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10.0,
            ),
            roomInput('Type room name ex: Room1', _roomName, (valor) {
              _roomName = valor;
            }),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Select Room Speaker',
              style: TextStyle(
                fontSize: 25.0,
              ),
              // overflow: TextOverflow.clip,
              // textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
                onTap: () {
                  serverDataBloc.bindLoading();
                  Navigator.of(context).pushNamed('bindSpeakerPage');
                },
                child: StreamBuilder(
                  stream: serverDataBloc.speakerStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<Device> snapshot) {
                    if (snapshot.hasData) {
                      _speakerId = snapshot.data.chipId;
                      return searchBoxFormRooms(
                          snapshot.data.deviceName, context);
                    } else {
                      _speakerId = '';
                      return searchBoxFormRooms(
                          'Select a speaker from the list', context);
                    }
                  },
                )),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Select Room Reader',
              style: TextStyle(
                fontSize: 25.0,
              ),
              // overflow: TextOverflow.clip,
              // textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
                onTap: () {
                  serverDataBloc.bindLoading();
                  Navigator.of(context).pushNamed('bindReaderPage');
                },
                child: StreamBuilder(
                  stream: serverDataBloc.readerStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<Device> snapshot) {
                    if (snapshot.hasData) {
                      _readerId = snapshot.data.chipId;
                      return searchBoxFormRooms(
                          snapshot.data.deviceName, context);
                    } else {
                      _readerId = '';
                      return searchBoxFormRooms(
                          'Select a reader from the list', context);
                    }
                  },
                )),
            SizedBox(
              height: 10.0,
            ),
            Center(
                child: submitButton('Done', () {
              _action(_roomName, _speakerId, _readerId, context);
            })),
          ],
        ),
      ),
    );
  }

  void _action(String roomName, String speakerId, String readerId,
      BuildContext _context) async {
    if ((roomName.length > 0) &&
        (speakerId.length > 0) &&
        (readerId.length > 0)) {
      updating(_context, 'Adding room');
      final resp = await serverDataBloc.addRoom(roomName, speakerId, readerId);
      if (resp) {
        updated(_context, 'Room added');
        serverDataBloc.deleteData();
      } else {
        errorPopUp(_context, 'Room not added');
        serverDataBloc.deleteData();
      }
    }
  }
}
