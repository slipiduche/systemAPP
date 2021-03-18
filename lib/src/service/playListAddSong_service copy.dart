import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/models/serverData_model.dart';

class SongAddService {
  Future<List<Music>> findSong(String key, List<Music> _songs) async {
    List<Music> filtered = [];

    final minus = key.toLowerCase();
    await ServerDataBloc().songPlayer.pause();
    await _songs.forEach((element) {
      if (element.id > 1) {
        if (element.songName.toLowerCase().contains(minus) ||
            (element.artist.toLowerCase().contains(minus))) {
          print(element.songName);
          filtered.add(element);
        }
      }
    });
    return filtered;
  }
}
