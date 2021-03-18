import 'package:systemAPP/src/bloc/serverData_bloc.dart';
import 'package:systemAPP/src/models/serverData_model.dart';

class PlayListService {
  Future<List<PlayList>> findPlayList(
      String key, List<PlayList> _playlists) async {
    List<PlayList> filtered = [];
    final minus = key.toLowerCase();
    //await ServerDataBloc().playlistPlayer.pause();
    await _playlists.forEach((element) {
      //(element.artist.toLowerCase().contains(minus))
      if (element.listName.toLowerCase().contains(minus)) {
        filtered.add(element);
      }
    });
    return filtered;
  }
}
