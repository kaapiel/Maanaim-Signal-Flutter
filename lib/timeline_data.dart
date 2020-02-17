import 'package:flutter/material.dart';

class Doodle {
  final String name;
  final String time;
  final String content;
  final String doodle;
  final Color iconBackground;
  final Icon icon;
  const Doodle(
      {this.name,
        this.time,
        this.content,
        this.doodle,
        this.icon,
        this.iconBackground});
}

const List<Doodle> doodles = [
  Doodle(
      name: "IC sem Auxiliar",
      time: "",
      content: "",
      doodle: "",
      icon: Icon(Icons.assistant_photo, color: Colors.white),
      iconBackground: Colors.red),
  Doodle(
      name: "IC sem membros suficiente",
      time: "",
      content: "",
      doodle: "",
      icon: Icon(Icons.info, color: Colors.white),
      iconBackground: Colors.yellow),
  Doodle(
      name: " IC pronta para multiplicar",
      time: "",
      content: "",
      doodle: "",
      icon: Icon(Icons.check_circle, color: Colors.white),
      iconBackground: Colors.green)
];