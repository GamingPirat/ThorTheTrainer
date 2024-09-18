import 'package:lernplatform/datenklassen/thema_page.dart';

import 'LernfeldPage.dart';
import 'folder_types.dart';







class Frage {
  final int nummer;
  final int version;
  final int themaID;
  final int punkte;
  final String text;
  final List<Antwort> antworten;

  Frage({
    required this.nummer,
    required this.version,
    required this.themaID,
    required this.punkte,
    required this.text,
    required this.antworten,
  });

  String get id => "${themaID}_${nummer}_$version";
}

class Antwort {
  final String text;
  final String erklaerung;
  final bool isKorrekt;

  Antwort({
    required this.text,
    required this.erklaerung,
    required this.isKorrekt,
  });
}

