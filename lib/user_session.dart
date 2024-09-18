import 'package:flutter/material.dart';
import 'package:lernplatform/my_appBar.dart';
import 'package:lernplatform/static_menu_drawer.dart';

class UserSession {
  static final UserSession _instance = UserSession._internal();

  UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  late StaticMenuDrawer drawer;
  late MyAppBar appBar;
  late String pageHeader = "Wiederholung ist die Mutter des Lernens";
}
