import 'dart:convert';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/d_users_view_models/log_teilnehmer.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LogTeilnehmer> ladeOderErzeugeTeilnehmer(List<Lernfeld> firestoreLernfelder) async {
  // print_Yellow("ladeOderErzeugeTeilnehmer firestoreLernfelder $firestoreLernfelder");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  // print_Yellow("ladeOderErzeugeTeilnehmer Gespeicherte Daten: ${prefs.getString('ThorTheTrainer')}");
  String storageKey = "ThorTheTrainer";  // Der Key für das LocalStorage

  // Lade den Teilnehmer aus dem LocalStorage
  String? gespeicherterTeilnehmer = prefs.getString(storageKey);

  // Wenn der Teilnehmer gefunden wurde, lese die Daten und gleiche ab
  if (gespeicherterTeilnehmer != null) {
    Map<String, dynamic> data = jsonDecode(gespeicherterTeilnehmer);
    LogTeilnehmer returnvalue = LogTeilnehmer.fromJson(data);
    print("Typ von 'meineLernfelder': ${data['meineLernfelder'].runtimeType}");

    // print_Yellow("ladeOderErzeugeTeilnehmer() Teilnehmer gefunden: $gespeicherterTeilnehmer");

    // Abgleich: Fehlende Lernfelder hinzufügen
    for (Lernfeld lernfeld in firestoreLernfelder) {
      bool lernfeldExists = returnvalue.logLernfelder.any((logLernfeld) => logLernfeld.id == lernfeld.id);

      if (!lernfeldExists) {
        LogLernfeld neuesLernfeld = LogLernfeld(
          lernfeld.id,
          lernfeld.kompetenzbereiche.map((thema) {
            return LogKompetenzbereich(
              id: thema.id,
              logInhalte: thema.inhalte.map((subthema) {
                return LogInhalt(
                  id: subthema.id,
                  falschBeantworteteFragen: Set<String>(),
                  richtigBeantworteteFragen: Set<String>(),
                );
              }).toList(),
            );
          }).toList(),
        );
        returnvalue.logLernfelder.add(neuesLernfeld);
        // print_Yellow("Neues Lernfeld hinzugefügt: ${neuesLernfeld.id}");
      }
    }

    // Speichere den aktualisierten Teilnehmer zurück im LocalStorage
    await prefs.setString(storageKey, jsonEncode(returnvalue.toJson()));
    print_Yellow("LadeOderErzeugeTeilnehmer vorhandener Teilnehmer");
    print_Yellow("$returnvalue");
    return returnvalue;
  }

  // Falls kein Teilnehmer existiert, neuen Teilnehmer mit allen Firestore-Daten erstellen
  List<LogLernfeld> logLernfelder = firestoreLernfelder.map((lernfeld) {
    return LogLernfeld(
      lernfeld.id,
      lernfeld.kompetenzbereiche.map((thema) {
        return LogKompetenzbereich(
          id: thema.id,
          logInhalte: thema.inhalte.map((subthema) {
            return LogInhalt(
              id: subthema.id,
              falschBeantworteteFragen: Set<String>(),
              richtigBeantworteteFragen: Set<String>(),
            );
          }).toList(),
        );
      }).toList(),
    );
  }).toList();

  LogTeilnehmer neuerTeilnehmer = LogTeilnehmer(sterne: 0, logLernfelder: logLernfelder);

  // Speichere den neuen Teilnehmer im LocalStorage
  await prefs.setString(storageKey, jsonEncode(neuerTeilnehmer.toJson()));
  print_Yellow("LadeOderErzeugeTeilnehmer neuer Teilnehmer erstellt");
  print_Yellow("$neuerTeilnehmer");

  return neuerTeilnehmer;
}





Future<void> speichereTeilnehmer(LogTeilnehmer teilnehmer) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String teilnehmerKey = "ThorTheTrainer";

  // Erstelle eine JSON-Repräsentation des Teilnehmers
  Map<String, dynamic> teilnehmerData = {
    'sterne': teilnehmer.sterne,
    'meineLernfelder': teilnehmer.logLernfelder.map((lernfeld) {
      return {
        'id': lernfeld.id,
        'meineThemen': lernfeld.logKompetenzbereiche.map((kompetenzbereich) {
          return {
            'id': kompetenzbereich.id,
            'logSubthemen': kompetenzbereich.logInhalte.map((inhalt) {
              return {
                'id': inhalt.id,
                'richtigBeantworteteFragen': inhalt.richtigBeantworteteFragen,
                'falschBeantworteteFragen': inhalt.falschBeantworteteFragen,
              };
            }).toList(),
          };
        }).toList(),
      };
    }).toList(),
  };

  // Speichere die Daten als JSON-String
  String teilnehmerJson = jsonEncode(teilnehmerData);
  await prefs.setString(teilnehmerKey, teilnehmerJson);

  // Print den gesamten Inhalt des LocalStorage
  print_Magenta("aktueller Lokalstorage:");
  Map<String, dynamic> allPrefs = prefs.getKeys().fold<Map<String, dynamic>>(
    {},
        (map, key) {
      map[key] = prefs.get(key);
      return map;
    },
  );
  print_Magenta(jsonEncode(allPrefs));

  ladeOderErzeugeTeilnehmer(Session().user.firestoreLernfelder);
}




Future<void> reseteTeilnehmer() async {
  for(LogLernfeld lernfeld in Session().user.logTeilnehmer.logLernfelder)
    for(LogKompetenzbereich tehma in lernfeld.logKompetenzbereiche)
      for(LogInhalt subTehma in tehma.logInhalte){
        subTehma.falschBeantworteteFragen = Set<String>();
        subTehma.richtigBeantworteteFragen = Set<String>();
      }

  await speichereTeilnehmer(Session().user.logTeilnehmer);
}

Future<void> clearAllLocalData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  print_Yellow("Alle lokalen Daten wurden gelöscht.");
}