import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/mok_user_model.dart';
import 'package:lernplatform/menu/my_appBar.dart';
import 'package:lernplatform/menu/my_left_drawer.dart';
import 'package:lernplatform/menu/punkte_widget.dart';
import 'package:lernplatform/print_colors.dart';

class Session {
  static final Session _instance = Session._internal();

  final MyLeftDrawer drawer = MyLeftDrawer();
  late MyAppBar appBar;
  late Widget pageHeader = Text("Wiederholung ist die Mutter des Lernens");
  late UserModel user = UserModel();
  late final Function changeTemeMode;
  final PunkteAnzeige punkteAnzeige = PunkteAnzeige(punkte: 345);

  Session._internal(); // private constructor for Singleton

  factory Session()=> _instance; // Rückgabe des Singleton-Instanz

  void initializeAppBar(void Function(ThemeMode) setThemeMode) {
    // print_Yellow("initializeAppBar");// todo
    appBar = MyAppBar(setThemeMode: setThemeMode);
  }

  bool _drawerIsOpen = false;
  bool get drawerIsOpen => _drawerIsOpen;
  set drawerIsOpen(bool value){
    _drawerIsOpen = value;
  }
}
