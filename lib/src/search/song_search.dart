import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/icons/icons.dart';
import 'package:systemAPP/src/models/serverData_model.dart';
import 'package:systemAPP/src/service/song_service.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

class SongSearchDelegate extends SearchDelegate {
  SongSearchDelegate(this.songs, this.mode);
  String mode;
  List<Music> songs;

  final songService = SongService();
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
          ServerDataBloc().songPlayer.pause();
          Navigator.of(context).pop();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: songService.findSong(this.query, songs),
      builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (mode == 'bind') {
              return makeSongsList(
                  context, snapshot.data, addIcon(20.0, colorMedico), 'add');
            }
            if (mode == 'play') {
              return Container(
                //margin: EdgeInsets.symmetric(horizontal: 25.0),
                child: makeSongsListPlay(
                    context,
                    snapshot.data,
                    speakerIcon(40.0, colorMedico),
                    addIcon(40.0, colorMedico),
                    'changeDefault'),
              );
            } else {
              return makeSongsList2(context, snapshot.data);
            }
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
      future: songService.findSong(this.query, songs),
      builder: (BuildContext context, AsyncSnapshot<List<Music>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            if (mode == 'bind') {
              return makeSongsList(
                  context, snapshot.data, addIcon(20.0, colorMedico), 'bind');
            }
            if (mode == 'play') {
              return Container(
                //margin: EdgeInsets.symmetric(horizontal: 25.0),
                child: makeSongsListPlay(
                    context,
                    snapshot.data,
                    speakerIcon(40.0, colorMedico),
                    addIcon(40.0, colorMedico),
                    'changeDefault'),
              );
            } else {
              return makeSongsList2(context, snapshot.data);
            }
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
