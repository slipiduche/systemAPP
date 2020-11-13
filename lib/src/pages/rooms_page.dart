import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class RoomsPage extends StatefulWidget {
  RoomsPage({Key key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
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
                child: roomIcon(98.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Rooms',
                style: TextStyle(
                  color: colorVN,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 40.0),

              
              Expanded(child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      
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
    );
    
  }

  
}
