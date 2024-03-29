import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/models/serverData_model.dart';

class SongService {
  Future<List<Music>> findSong(String key, List<Music> _songs) async {
    List<Music> filtered = [];
    final minus = key.toLowerCase();
    await ServerDataBloc().songPlayer.pause();
    await _songs.forEach((element) {
      if (element.songName.toLowerCase().contains(minus) ||
          (element.artist.toLowerCase().contains(minus))) {
        if (element.id != 1) filtered.add(element);
      }
    });
    return filtered;
  }
}
