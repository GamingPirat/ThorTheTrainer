import 'package:flutter/material.dart';
import 'package:lernplatform/menu/my_left_drawer.dart';
import 'package:lernplatform/print_colors.dart';
import 'menu/mok_user_model.dart';
import 'menu/my_appBar.dart';
import 'menu/punkte_widget.dart';

class Session {
  static final Session _instance = Session._internal();

  late MyLeftDrawer drawer;
  late MyAppBar appBar;
  late Widget pageHeader;
  late UserModel user;
  PunkteAnzeige punkteAnzeige = PunkteAnzeige(punkte: 345);

  Session._internal();

  factory Session({void Function(ThemeMode)? setThemeMode}) {
    print_Blue("Session factory aufgerufen");
    if(setThemeMode != null)
      _instance._initialize(setThemeMode);

    return _instance;
  }

  void _initialize(void Function(ThemeMode) setThemeMode) {
    drawer = MyLeftDrawer();
    appBar = MyAppBar(setThemeMode: setThemeMode);
    pageHeader = Text("Wiederholung ist die Mutter des Lernens");
    user = UserModel();
  }
}

