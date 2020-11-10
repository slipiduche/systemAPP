import 'package:flutter/material.dart';

Widget homeIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/home.png'),
      width: size,
      height: size,
      color: color);
}

Widget musicIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/music.png'),
      width: size,
      height: size,
      color: color);
}
Widget roomIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/rooms.png'),
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
      );
}
Widget deleteIcon(double size, Color color) {
  return Image(
      image: AssetImage('assets/delete.png'),
      width: size,
      height: size,
      color: color);
}