import 'package:flutter/material.dart';
import 'package:lernplatform/menu/my_appBar.dart';

import 'menu/my_left_drawer.dart';
import 'menu/punkte_widget.dart';

class Session {
  static final Session _instance = Session._internal();

  Session._internal();

  factory Session() {
    return _instance;
  }

  late MyLeftDrawer drawer;
  late MyAppBar appBar;
  late Widget pageHeader = Text("Wiederholung ist die Mutter des Lernens");

  PunkteAnzeige punkteAnzeige = PunkteAnzeige(punkte: 345);

  ThemeMode themeMode = ThemeMode.dark;

}
