import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/db_key.dart';
import 'package:lernplatform/globals/my_background.dart';
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
  late UserModel user;
  late final Function changeTemeMode;
  final PunkteAnzeige _sterneAnzeige = PunkteAnzeige(punkte: 0); // todo punkte sollten im User sein
  final Widget background = MyBackGround();
  final bool IS_IN_DEBUG_MODE = true;

  Session._internal();

  factory Session()=> _instance;

  Future<bool> enter(String key) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection("Keys")
        .where("key", isEqualTo: key)
        .get();

    // Prüfe, ob überhaupt ein Dokument gefunden wurde
    if (snapshot.docs.isNotEmpty) {
      // Greife direkt auf das erste Dokument zu
      var doc = snapshot.docs.first;
      print_Red("Dokument-ID: ${doc.id}, Daten: ${doc.data()}");

      try {
        Map<String, dynamic>? data = doc.data();
        print_Red("Session enter() Vergleich mit Schlüssel: $key");

        if (data != null && data.containsKey("key") && data["key"] == key) {
          user = UserModel(alpha_key: AlphaKey.fromJson(Map<String, dynamic>.from(data)));
          return true;
        }
      } catch (e) {
        print_Red("Fehler beim Zugriff auf Dokumentdaten: ${e.toString()}");
      }
    } else {
      print_Red("Kein Dokument mit dem angegebenen Schlüssel gefunden.");
    }

    return false;
  }




  void initializeAppBar(void Function(ThemeMode) setThemeMode) {
    appBar = MyAppBar(setThemeMode: setThemeMode);
  }

  bool _drawerIsOpen = false;
  bool get drawerIsOpen => _drawerIsOpen;
  PunkteAnzeige get sterneAnzeige =>_sterneAnzeige;
  int get gesamtSterne =>_sterneAnzeige.punkte;
  set gesamtSterne(int value){
    _sterneAnzeige.punkte = value;
    user.logTeilnehmer.sterne = value;
  }
  set drawerIsOpen(bool value){
    _drawerIsOpen = value;
  }
}
