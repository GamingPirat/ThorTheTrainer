import 'dart:convert';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LogTeilnehmer> ladeOderErzeugeTeilnehmer(List<Lernfeld> firestoreLernfelder) async {
  // print_Yellow("ladeOderErzeugeTeilnehmer firestoreLernfelder $firestoreLernfelder");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String storageKey = "ThorTheTrainer";  // Der Key für das LocalStorage

  // Lade den Teilnehmer aus dem LocalStorage
  String? gespeicherterTeilnehmer = prefs.getString(storageKey);

  // Wenn der Teilnehmer gefunden wurde, lese die Daten und gleiche ab
  if (gespeicherterTeilnehmer != null) {
    Map<String, dynamic> data = jsonDecode(gespeicherterTeilnehmer);
    LogTeilnehmer returnvalue = LogTeilnehmer.fromJson(data);

    // print_Yellow("ladeOderErzeugeTeilnehmer() Teilnehmer gefunden: $gespeicherterTeilnehmer");

    // Abgleich: Fehlende Lernfelder hinzufügen
    for (Lernfeld lernfeld in firestoreLernfelder) {
      bool lernfeldExists = returnvalue.meineLernfelder.any((logLernfeld) => logLernfeld.id == lernfeld.id);

      if (!lernfeldExists) {
        LogLernfeld neuesLernfeld = LogLernfeld(
          lernfeld.id,
          lernfeld.kompetenzbereiche.map((thema) {
            return LogKompetenzbereich(
              id: thema.id,
              logInhalte: thema.inhalte.map((subthema) {
                return LogInhalt(
                  id: subthema.id,
                  falschBeantworteteFragen: [],
                  richtigBeantworteteFragen: [],
                );
              }).toList(),
            );
          }).toList(),
        );
        returnvalue.meineLernfelder.add(neuesLernfeld);
        // print_Yellow("Neues Lernfeld hinzugefügt: ${neuesLernfeld.id}");
      }
    }

    // Speichere den aktualisierten Teilnehmer zurück im LocalStorage
    await prefs.setString(storageKey, jsonEncode(returnvalue.toJson()));
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
              falschBeantworteteFragen: [],
              richtigBeantworteteFragen: [],
            );
          }).toList(),
        );
      }).toList(),
    );
  }).toList();

  LogTeilnehmer neuerTeilnehmer = LogTeilnehmer(sterne: 0, meineLernfelder: logLernfelder);

  // Speichere den neuen Teilnehmer im LocalStorage
  await prefs.setString(storageKey, jsonEncode(neuerTeilnehmer.toJson()));
  // print_Yellow("ladeOderErzeugeTeilnehmer() Teilnehmer Erstellt: $neuerTeilnehmer");

  return neuerTeilnehmer;
}





Future<void> speichereTeilnehmer(LogTeilnehmer teilnehmer) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String teilnehmerKey = "ThorTheTrainer";

  // Erstelle eine JSON-Repräsentation des Teilnehmers
  Map<String, dynamic> teilnehmerData = {
    'sterne': teilnehmer.sterne,
    'meineLernfelder': teilnehmer.meineLernfelder.map((lernfeld) {
      return {
        'id': lernfeld.id,
        'meineThemen': lernfeld.meineThemen.map((thema) {
          return {
            'id': thema.id,
            'logSubthemen': thema.logInhalte.map((subthema) {
              return {
                'id': subthema.id,
                'falschBeantworteteFragen': subthema.falschBeantworteteFragen,
                'richtigBeantworteteFragen': subthema.richtigBeantworteteFragen,
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


  // print_Yellow("speichereTeilnehmer() Teilnehmer gespeichert in Cookies gefunden: \n"
  //     ""+teilnehmerJson);
  // print_Green("Teilnehmer gespeichert. LokalStorage sieht jetzt so aus:");
  // LogTeilnehmer debugghelper = await ladeOderErzeugeTeilnehmer(firestoreLernfelder);
  // print(debugghelper);
}




Future<void> reseteTeilnehmer() async {
  for(LogLernfeld lernfeld in Session().user.logTeilnehmer.meineLernfelder)
    for(LogKompetenzbereich tehma in lernfeld.meineThemen)
      for(LogInhalt subTehma in tehma.logInhalte){
        subTehma.falschBeantworteteFragen = [];
        subTehma.richtigBeantworteteFragen = [];
      }

  await speichereTeilnehmer(Session().user.logTeilnehmer);
}

Future<void> clearAllLocalData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  print_Yellow("Alle lokalen Daten wurden gelöscht.");
}