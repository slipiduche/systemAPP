import 'package:flutter/material.dart';
import 'package:systemAPP/src/pages/home_page.dart';
import 'package:systemAPP/src/pages/iniciando_page.dart';
import 'package:systemAPP/src/pages/music_page.dart';
import 'package:systemAPP/src/pages/songs_page.dart';
import 'package:systemAPP/src/pages/addSong_page.dart';
import 'package:systemAPP/src/pages/addSongs_page.dart';
import 'package:systemAPP/src/pages/editSong_page.dart';
import 'package:systemAPP/src/pages/deleteSong_page.dart';
import 'package:systemAPP/src/pages/bindSong_page.dart';
import 'package:systemAPP/src/pages/tags_page.dart';
import 'package:systemAPP/src/pages/addTags_page.dart';
import 'package:systemAPP/src/pages/editTags_page.dart';
import 'package:systemAPP/src/pages/deleteTags_page.dart';
import 'package:systemAPP/src/pages/rooms_page.dart';
import 'package:systemAPP/src/pages/addRooms_page.dart';
import 'package:systemAPP/src/pages/editRooms_page.dart';
import 'package:systemAPP/src/pages/bindReader_page.dart';
import 'package:systemAPP/src/pages/bindSpeaker_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    'iniciandoPage': (BuildContext context) => IniciandoPage(),
    'homePage': (BuildContext context) => HomePage(),
    'musicPage': (BuildContext context) => MusicPage(),
    'addSongsPage': (BuildContext context) => AddSongsPage(),
    'addSongPage': (BuildContext context) => AddSongPage(),
    'editSongPage': (BuildContext context) => EditSongPage(),
    'bindSongPage': (BuildContext context) => BindSongPage(),
    'deleteSongPage': (BuildContext context) => DeleteSongPage(),
    'changeDefaultSongPage': (BuildContext context) => DeleteSongPage(),
    'songsPage': (BuildContext context) => SongsPage(),
    'tagPage': (BuildContext context) => TagsPage(),
    'addTagsPage': (BuildContext context) => AddTagsPage(),
    'editTagsPage': (BuildContext context) => EditTagsPage(),
    'deleteTagsPage': (BuildContext context) => DeleteTagsPage(),
    'roomsPage': (BuildContext context) => RoomsPage(),
    'addRoomsPage': (BuildContext context) => AddRoomsPage(),
    'editRoomsPage': (BuildContext context) => EditRoomsPage(),
    'bindSpeakerPage': (BuildContext context) => BindSpeakerPage(),
    'bindReaderPage': (BuildContext context) => BindReaderPage(),
  };
}
