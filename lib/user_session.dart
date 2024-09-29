import 'package:flutter/material.dart';
import 'package:lernplatform/menu/my_appBar.dart';

import 'menu/my_left_drawer.dart';

class UserSession {
  static final UserSession _instance = UserSession._internal();

  UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  late MyLeftDrawer drawer;
  late MyAppBar appBar;
  late Widget pageHeader = Text("Wiederholung ist die Mutter des Lernens");

  ThemeMode themeMode = ThemeMode.dark;

}
