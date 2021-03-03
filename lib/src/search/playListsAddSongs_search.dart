import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/service/playListAddSong_service%20copy.dart';
import 'package:systemAPP/src/service/playListPtxSong_service.dart';
import 'package:systemAPP/src/service/playLists_service.dart';
import 'package:systemAPP/src/service/song_service.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class PlayListAddSongSearchDelegate extends SearchDelegate {
  PlayListAddSongSearchDelegate(this.playlists, this.mode);
  List<Music> playlists;

  String mode;
  final playlistService = SongAddService();
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
      future: playlistService.findSong(this.query, playlists),
      builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return makeSongsListAdd(context, snapshot.data, false);
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
      future: playlistService.findSong(this.query, playlists),
      builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return makeSongsListAdd(context, snapshot.data, false);
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
