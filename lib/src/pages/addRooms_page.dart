import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';

class AddRoomsPage extends StatefulWidget {
  AddRoomsPage({Key key}) : super(key: key);

  @override
  _AddRoomsPageState createState() => _AddRoomsPageState();
}

class _AddRoomsPageState extends State<AddRoomsPage> {
  ServerDataBloc serverDataBloc = ServerDataBloc();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //serverDataBloc.requestRooms();
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
                SizedBox(height: 30.0),
                Expanded(
                    child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('Create a new room',style:TextStyle(fontSize: 20.0)),
                        SizedBox(height: 10.0),
                        roomCard(context),
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
            roomInput('Type room name ex: Room1', '', () {}),
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
            searchBoxFormRooms('Select a speaker from the list', context),
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
            searchBoxFormRooms('Select a reader from the list', context),
          ],
        ),
      ),
    );
  }
}
