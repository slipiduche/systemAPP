import 'package:flutter/material.dart';
import 'package:systemAPP/src/pages/home_page.dart';
import 'package:systemAPP/src/pages/iniciando_page.dart';
import 'package:systemAPP/src/pages/music_page.dart';
import 'package:systemAPP/src/pages/rooms_page.dart';
import 'package:systemAPP/src/pages/songs_page.dart';
import 'package:systemAPP/src/pages/tags_page.dart';
import 'package:systemAPP/src/pages/addSong_page.dart';
import 'package:systemAPP/src/pages/addSongs_page.dart';
import 'package:systemAPP/src/pages/editSong_page.dart';
import 'package:systemAPP/src/pages/deleteSong_page.dart';
Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'iniciandoPage': (BuildContext context) => IniciandoPage(),
    
    'homePage': (BuildContext context) => HomePage(),
    'musicPage': (BuildContext context) => MusicPage(),
    'addSongsPage': (BuildContext context) => AddSongsPage(),
    'addSongPage': (BuildContext context) => AddSongPage(),
    'editSongPage': (BuildContext context) => EditSongPage(),
    'deleteSongPage': (BuildContext context) => DeleteSongPage(),
    'songsPage': (BuildContext context) => SongsPage(),
    'tagPage': (BuildContext context) => TagsPage(),
    'roomsPage': (BuildContext context) => RoomsPage(),
    
  };
}