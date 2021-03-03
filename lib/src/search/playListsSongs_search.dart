import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/service/playListPtxSong_service.dart';
import 'package:systemAPP/src/service/playLists_service.dart';
import 'package:systemAPP/src/service/song_service.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class PlayListSongSearchDelegate extends SearchDelegate {
  PlayListSongSearchDelegate(this.playlists, this.playlistsId, this.mode);
  List<Music> playlists;
  List<int> playlistsId;
  String mode;
  final playlistService = SongPtxService();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear, color: colorMedico),
          onPressed: () {
            this.query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: colorMedico,
        ),
        onPressed: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
          Navigator.of(context).pop();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: playlistService.findSong(this.query, playlists, playlistsId),
      builder: (BuildContext context, AsyncSnapshot<PTX> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.ptxSongs.length > 0) {
            return makeSongsListPtx(
                context, snapshot.data.ptxSongs, snapshot.data.ptxIds, false);
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Text(
                  'No songs founded.',
                  style: TextStyle(fontSize: 20.0),
                )),
              ],
            );
          }
        } else {
          return Center(child: circularProgress());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: playlistService.findSong(this.query, playlists, playlistsId),
      builder: (BuildContext context, AsyncSnapshot<PTX> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.ptxSongs.length > 0) {
            return makeSongsListPtx(
                context, snapshot.data.ptxSongs, snapshot.data.ptxIds, false);
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: Text(
                  'No songs founded.',
                  style: TextStyle(fontSize: 20.0),
                )),
              ],
            );
          }
        } else {
          return Center(child: circularProgress());
        }
      },
    );
  }
}
