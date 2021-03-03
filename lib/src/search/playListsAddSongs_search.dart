import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/service/playListAddSong_service%20copy.dart';
import 'package:systemAPP/src/service/playListPtxSong_service.dart';
import 'package:systemAPP/src/service/playLists_service.dart';
import 'package:systemAPP/src/service/song_service.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class PlayListAddSongSearchDelegate extends SearchDelegate {
  PlayListAddSongSearchDelegate(this.playlists, this.playList, this.mode);
  List<Music> playlists;
  PlayList playList;
  String mode;
  ServerDataBloc serverDataBloc = ServerDataBloc();
  List<PlayListsSong> _playListsSongs;
  List<Music> listPtx = [];
  List<int> listPtxId = [];
  List<int> songsSelected = [];
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
            return Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 25.0),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () async {
                        songsSelected = [];
                        if (serverDataBloc.getSongIds().length > 0) {
                          updating(context, 'Adding songs');
                          final resp =
                              await serverDataBloc.addSongsToPlayList(playList);
                          songsSelected = [];
                          serverDataBloc.removeAllPtxs();
                          serverDataBloc.removeAllSongs();
                          serverDataBloc.itemDelete();
                          if (resp) {
                            updated(context, 'Songs added to playlist');
                          } else {
                            errorPopUp(context, 'Songs not added');
                          }
                        }
                      },
                      child: Row(
                        children: [
                          addIcon(20.0, colorMedico),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Add songs',
                            style: TextStyle(
                                color: colorMedico,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 25.0)
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                    child: makeSongsListAdd(context, snapshot.data, false)),
              ],
            );
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
            return Column(
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 25.0),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () async {
                        songsSelected = [];
                        if (serverDataBloc.getSongIds().length > 0) {
                          updating(context, 'Adding songs');
                          final resp =
                              await serverDataBloc.addSongsToPlayList(playList);
                          songsSelected = [];
                          serverDataBloc.removeAllPtxs();
                          serverDataBloc.removeAllSongs();
                          serverDataBloc.itemDelete();
                          if (resp) {
                            updated(context, 'Songs added to playlist');
                          } else {
                            errorPopUp(context, 'Songs not added');
                          }
                        }
                      },
                      child: Row(
                        children: [
                          addIcon(20.0, colorMedico),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Add songs',
                            style: TextStyle(
                                color: colorMedico,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 25.0)
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                    child: makeSongsListAdd(context, snapshot.data, false)),
              ],
            );
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
