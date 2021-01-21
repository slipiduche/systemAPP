import 'package:systemAPP/src/models/serverData_model.dart';

class RoomService {
  Future<List<Room>> findRoom(String key, List<Room> _rooms) async {
    List<Room> filtered = [];
    await _rooms.forEach((element) {
      if (element.roomName.contains(key)) {
        filtered.add(element);
      }
    });
    return filtered;
  }
}
