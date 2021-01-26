import 'package:flutter/material.dart';
import 'package:systemAPP/constants.dart';
import 'package:systemAPP/src/widgets/widgets.dart';

Widget homeIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/home.png'),
      width: size,
      height: size,
      color: color);
}

Widget homeBarIcon(double size) {
  return Image(
    
    image: AssetImage(
      'assets/homebar.png',
    ),
    width: size,
    height: size,
  );
}

Widget homeBarIconS(double size) {
  return Image(
    fit: BoxFit.contain,
    image: AssetImage('assets/home.png'),
    width: size,
    height: size,
    color: colorMedico,
  );
}

Widget musicIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/music.png'),
      width: size,
      height: size,
      color: color);
}

Widget musicBarIcon(double size) {
  return Image(
    image: AssetImage('assets/musicbar.png'),
    width: size,
    height: size,
  );
}

Widget musicBarIconS(double size) {
  return Image(
    image: AssetImage('assets/music.png'),
    width: size,
    height: size,
  );
}

Widget roomIcon(double size) {
  return Row(
    children: [
      SizedBox(
        width: 25.0,
      ),
      Image(
        image: AssetImage('assets/rooms.png'),
        width: size,
        height: size,
      ),
    ],
  );
}

Widget roomBarIcon(double size) {
  return Image(
    image: AssetImage('assets/roomsbar.png'),
    width: size,
    height: size,
  );
}

Widget roomBarIconS(double size) {
  return Image(
    image: AssetImage('assets/roomsbarS.png'),
    width: size,
    height: size,
  );
}

Widget tagBarIcon(double size) {
  return Image(
    image: AssetImage('assets/tagbar.png'),
    width: size,
    height: size,
  );
}

Widget tagBarIconS(double size) {
  return Image(
    image: AssetImage('assets/tag.png'),
    width: size,
    height: size,
  );
}

Widget tagIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/tag.png'),
      width: size,
      height: size,
      color: color);
}

Widget addIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/add.png'),
    width: size,
    height: size,
    //fit: BoxFit.contain,
  );
}

Widget uploadIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/upload.png'),
    width: size,
    height: size,
    //fit: BoxFit.contain,
  );
}

Widget addRoomIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/addRoom.png'),
    //width: size,
    height: size,
    fit: BoxFit.contain,
  );
}

Widget deleteIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/delete.png'),
      width: size,
      height: size,
      color: color);
}

Widget editIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/edit.png'),
      width: size,
      height: size,
      color: color);
}

Widget songIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/songs.png'),
    width: size,
    height: size,
  );
}

Widget speakerIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/speakers.png'),
    width: size,
    height: size,
  );
}

Widget readerIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/readers.png'),
    width: size,
    height: size,
  );
}

Widget addSongIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/addSong.png'),
    width: size,
    height: size,
  );
}

Widget addSongsIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/addSongs.png'),
    width: size,
    height: size,
  );
}

Widget searchIcon(double size, Color color) {
  return Image(
    image: AssetImage('assets/search.png'),
    width: size,
    height: size,
  );
}
