import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/thema_dbs.dart';
import 'datenklassen/thema.dart';
import 'menu/mok_user_model.dart';
import 'menu/my_appBar.dart';
import 'menu/my_left_drawer.dart';
import 'menu/punkte_widget.dart';

class Session {
  static final Session _instance = Session._internal();

  late MyLeftDrawer drawer;
  late MyAppBar appBar;
  late Widget pageHeader;
  late MokUserModel derEingeloggteUser_Model;
  PunkteAnzeige punkteAnzeige = PunkteAnzeige(punkte: 345);
  late Thema_JSONService themenService;
  get themen => themenService.themen;

  Session._internal();

  factory Session({void Function(ThemeMode)? setThemeMode}) {
    if(setThemeMode != null)
      _instance._initialize(setThemeMode);
    return _instance;
  }

  void _initialize(void Function(ThemeMode) setThemeMode) {
    _loadThemen();
    drawer = MyLeftDrawer();
    appBar = MyAppBar(setThemeMode: setThemeMode);
    pageHeader = Text("Wiederholung ist die Mutter des Lernens");
    derEingeloggteUser_Model = MokUserModel();
  }

  void _loadThemen() async {
    await Thema_JSONService.getInstance('assets/test_thema.json');
  }
}

