import 'package:flutter/material.dart';
import 'package:lernplatform/globals/user_viewmodel.dart';
import 'package:lernplatform/menu/my_appBar.dart';
import 'package:lernplatform/menu/my_left_drawer.dart';
import 'package:lernplatform/menu/punkte_widget.dart';
import 'package:lernplatform/globals/print_colors.dart';

class Session {
  static final Session _instance = Session._internal();

  final MyLeftDrawer drawer = MyLeftDrawer();
  late MyAppBar appBar;
  late Widget pageHeader = Text("Wiederholung ist die Mutter des Lernens");
  late UserModel user = UserModel();
  late final Function changeTemeMode;
  final PunkteAnzeige _sterneAnzeige = PunkteAnzeige(punkte: 0); // todo punkte sollten im User sein
  final bool IS_IN_DEBUG_MODE = true;

  Session._internal(); // private constructor for Singleton

  factory Session()=> _instance; // Rückgabe des Singleton-Instanz

  void initializeAppBar(void Function(ThemeMode) setThemeMode) {
    appBar = MyAppBar(setThemeMode: setThemeMode);
  }

  bool _drawerIsOpen = false;
  bool get drawerIsOpen => _drawerIsOpen;
  PunkteAnzeige get sterneAnzeige =>_sterneAnzeige;
  int get gesamtSterne =>_sterneAnzeige.punkte;
  set gesamtSterne(int value){
    _sterneAnzeige.punkte = value;
    user.teilnehmer.sterne = value;
  }
  set drawerIsOpen(bool value){
    _drawerIsOpen = value;
  }
}
