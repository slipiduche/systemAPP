import 'package:systemAPP/src/models/dispositivos_model.dart';
import 'package:flutter/material.dart';


final String serverUri = "broker.hivemq.com";
final int port = 1883;
final String topicName = "SDR/#";
// final String topicIn = "SDR/c4d7ba3a7d80/out";
// final String topicOut = "SDR/c4d7ba3a7d80/in";

final Color colorResaltadoBoton=Color.fromRGBO(234, 234, 234, 1.0);
final Color colorOrbittas=Color.fromRGBO(0, 122, 146, 1.0);
final Color coloBackGround=Color.fromRGBO(229, 229, 229, 1.0);
final Color colorMedico=Color.fromRGBO(67, 205, 197, 1.0);
final Color colorMedico1=Color.fromRGBO(51, 232, 221, 1.0);
final Color colorMedico2=Color.fromRGBO(49, 188, 180, 1.0);
final Color colorMedico3=Color.fromRGBO(13, 148, 140, 1.0);
final Color colorBordeBotton=Color.fromRGBO(196, 196, 196, 1.0);
final Color colorShadow=Color.fromRGBO(0,0,0, 0.25);
final BoxShadow boxShadow1= BoxShadow(
                    color: colorShadow,
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                    offset: Offset(0, 4.0));
// final List dispositivos = [{   "id":0,
//     "nombreDispositivo":"SDRVEN",
//     "chipID":"XXXXXXXXXXXX"
    
  
// },
//   {   "id":1,
//     "nombreDispositivo":"SDRVEN",
//     "chipID":"c4d7ba3a7d80"
    
  
// },{   "id":3,
//     "nombreDispositivo":"SDROTRO",
//     "chipID":"c5a7ba3a7d85"
    
  
// }];
