import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/datenklassen/thema_dbs.dart';

import '../log_and_content-converter.dart';
import 'log_lernfeld_u_frage.dart';

class Teilnehmer {
  late List<LogLernfeld> meineLernfelder;
  final String key;

  // Privater Konstruktor
  Teilnehmer._private({required this.key});

  Future<void> load() async {
    List<LogThema> pseudDaten = [];
    final themaService = await Thema_JSONService.getInstance('assets/test_thema.json');

    for (Thema thema in themaService.themen) {
      pseudDaten.add(
          LogThema(
              id: thema.id,
              falschBeantworteteFragen: [],
              richtigBeantworteteFragen: []
          )
      );
    }

    meineLernfelder = [LogLernfeld(1, pseudDaten)];
  }

  Future<void> save() async {
    // Speichern, falls benötigt
  }

  // Statische Methode zum Erstellen eines Teilnehmers
  static Future<Teilnehmer> loadTeilnehmer(String key) async {
    Teilnehmer teilnehmer = Teilnehmer._private(key: key);
    await teilnehmer.load(); // Teilnehmerdaten laden
    return teilnehmer;
  }
}



