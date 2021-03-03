import 'package:flutter/material.dart';
import 'package:systemAPP/src/pages/bindPlaylListPage_page.dart';
import 'package:systemAPP/src/pages/playListAddSongs_page.dart';
import 'package:systemAPP/src/pages/playListDefaultPage_page.dart';
import 'package:systemAPP/src/pages/playList_page.dart';
import 'package:systemAPP/src/pages/changeDefault_page.dart';
import 'package:systemAPP/src/pages/home_page.dart';
import 'package:systemAPP/src/pages/music_page.dart';
import 'package:systemAPP/src/pages/listPlayList_page.dart';
import 'package:systemAPP/src/pages/playSong_page.dart';
import 'package:systemAPP/src/pages/selectPlaylListPage_page.dart';
import 'package:systemAPP/src/pages/songs_page.dart';
import 'package:systemAPP/src/pages/addSong_page.dart';
import 'package:systemAPP/src/pages/addSongs_page.dart';
import 'package:systemAPP/src/pages/editSong_page.dart';
import 'package:systemAPP/src/pages/deleteSong_page.dart';
import 'package:systemAPP/src/pages/listSong_page.dart';
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
import 'package:systemAPP/src/provider/player_provider.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
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
    'listSongsPage': (BuildContext context) => ListSongsPage(),
    'roomsPage': (BuildContext context) => RoomsPage(),
    'addRoomsPage': (BuildContext context) => AddRoomsPage(),
    'listPlayListPage': (BuildContext context) => ListPlayListPage(),
    'playListPage': (BuildContext context) => PlayListPage(),
    'playListAddSongsPage': (BuildContext context) => PlayListAddSongsPage(),
    'playListDefaultPage': (BuildContext context) => PlayListDefaultPage(),
    'bindPlayListPage': (BuildContext context) => PlayListAddTagPage(),
    'selectPlayListPage': (BuildContext context) => PlayListSelectPage(),
    'editRoomsPage': (BuildContext context) => EditRoomsPage(),
    'bindSpeakerPage': (BuildContext context) => BindSpeakerPage(),
    'bindReaderPage': (BuildContext context) => BindReaderPage(),
    'playerPage': (BuildContext context) => Player(),
    'playSongPage': (BuildContext context) => PlaySongPage(),
    'changeDefaultPage': (BuildContext context) => ChangeDefaultPage(),
  };
}
