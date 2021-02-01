import 'package:systemAPP/src/models/serverData_model.dart';

class SongService {
  Future<List<Music>> findSong(String key, List<Music> _songs) async {
    List<Music> filtered = [];
    final minus = key.toLowerCase();

    await _songs.forEach((element) {
      if (element.songName.toLowerCase().contains(minus) ||
          (element.artist.toLowerCase().contains(minus))) {
        filtered.add(element);
      }
    });
    return filtered;
  }
}
