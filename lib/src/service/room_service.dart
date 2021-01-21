import 'package:systemAPP/src/models/serverData_model.dart';

class RoomService {
  Future<List<Room>> findRoom(String roomName) async {
    final rooms = Rooms().items;
    return rooms;
  }
}
