import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/icons/icons.dart';

import 'package:systemAPP/src/models/dispositivos_model.dart';
import 'package:systemAPP/src/models/mqtt_models.dart';
import 'package:systemAPP/src/models/mqtt_protocol_models.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                child: homeIcon(98.0, colorMedico),
              ),
              SizedBox(height: 8.0),
              Text(
                'Home',
                style: TextStyle(
                  color: colorVN,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 40.0),
              tarjeta('Music', 'Add new songs or delete old ones', musicIcon(40, colorMedico)),
              SizedBox(height: 20.0),
              tarjeta('Tags', 'Add , delete or edit tags', tagIcon(40, colorMedico)),
              SizedBox(height: 20.0),
              tarjeta('Rooms', 'Mannage the rooms ', roomIcon(40, colorMedico)),
            ],
          ),
        ),
      ),
    );
  }

  
}
