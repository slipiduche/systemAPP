import 'package:flutter/material.dart';
import 'package:systemAPP/src/pages/home_page.dart';
import 'package:systemAPP/src/pages/iniciando_page.dart';
import 'package:systemAPP/src/pages/music_page.dart';
import 'package:systemAPP/src/pages/rooms_page.dart';
import 'package:systemAPP/src/pages/tags_page.dart';
Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'iniciandoPage': (BuildContext context) => IniciandoPage(),
    
    'homePage': (BuildContext context) => HomePage(),
    'musicPage': (BuildContext context) => MusicPage(),
    'tagPage': (BuildContext context) => TagsPage(),
    'roomsPage': (BuildContext context) => RoomsPage(),
    
  };
}