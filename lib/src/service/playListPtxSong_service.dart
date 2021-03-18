import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/models/serverData_model.dart';

class SongPtxService {
  Future<PTX> findSong(String key, List<Music> _songs, List<int> _ids) async {
    List<Music> filtered = [];
    List<int> filteredId = [];
    int count = 0;

    final minus = key.toLowerCase();
    await ServerDataBloc().songPlayer.pause();
    await _songs.forEach((element) {
      if (element.songName.toLowerCase().contains(minus) ||
          (element.artist.toLowerCase().contains(minus))) {
        print(element.songName);
        filtered.add(element);
        filteredId.add(_ids[count]);
      }
      count++;
    });
    return PTX(filtered, filteredId);
  }
}

class PTX {
  List<Music> ptxSongs;
  List<int> ptxIds;
  PTX(this.ptxSongs, this.ptxIds);
}
