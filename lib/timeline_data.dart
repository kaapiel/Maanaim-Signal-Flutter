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
      name: "",
      time: "",
      content: "",
      doodle: "",
      icon: Icon(Icons.adjust, color: Colors.white),
      iconBackground: Colors.red),
  Doodle(
      name: "",
      time: "",
      content: "",
      doodle: "",
      icon: Icon(Icons.exposure, color: Colors.white),
      iconBackground: Colors.redAccent),
  Doodle(
      name: "",
      time: "",
      content: "",
      doodle: "",
      icon: Icon(Icons.visibility, color: Colors.black87),
      iconBackground: Colors.yellow)
];