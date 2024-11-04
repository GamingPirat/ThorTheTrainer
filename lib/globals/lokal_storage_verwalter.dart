import 'dart:convert';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<LogTeilnehmer> ladeOderErzeugeTeilnehmer(List<Lernfeld_DB> firestoreLernfelder) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String teilnehmerKey = "ThorTheTrainer";  // Der Key für das LocalStorage

  // Lade den Teilnehmer aus dem LocalStorage
  String? gespeicherterTeilnehmer = prefs.getString(teilnehmerKey);

  // Wenn der Teilnehmer gefunden wurde, diesen zurückgeben
  if (gespeicherterTeilnehmer != null) {
    Map<String, dynamic> data = jsonDecode(gespeicherterTeilnehmer);
    LogTeilnehmer returnvalue = LogTeilnehmer.fromJson(data);  // Nutze die fromJson Methode von Teilnehmer
    print_Yellow(returnvalue.toString());
    return returnvalue;
  }

  // Wenn kein Teilnehmer gefunden wurde, erstelle einen neuen Teilnehmer basierend auf Firestore-Daten
  List<LogLernfeld> logLernfelder = firestoreLernfelder.map((lernfeld) {
    return LogLernfeld(
      lernfeld.id,
      lernfeld.themen.map((thema) {
        return LogThema(
          id: thema.id,
          logSubthemen: thema.subthemen.map((subthema) {
            return LogSubThema(
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
  await prefs.setString(teilnehmerKey, jsonEncode(neuerTeilnehmer.toJson()));  // Nutze die toJson Methode von Teilnehmer

  print_Green("Neuer Teilnehmer wurde erstellt und gespeichert:");
  print_Green(neuerTeilnehmer.toString());

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
            'logSubthemen': thema.logSubthemen.map((subthema) {
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

  // print_Green("Teilnehmer gespeichert. LokalStorage sieht jetzt so aus:");
  // LogTeilnehmer debugghelper = await ladeOderErzeugeTeilnehmer(firestoreLernfelder);
  // print(debugghelper);
}

Future<void> loescheTeilnehmer() async {
  for(LogLernfeld lernfeld in Session().user.teilnehmer.meineLernfelder)
    for(LogThema tehma in lernfeld.meineThemen)
      for(LogSubThema subTehma in tehma.logSubthemen){
        subTehma.falschBeantworteteFragen = [];
        subTehma.richtigBeantworteteFragen = [];
      }

  speichereTeilnehmer(Session().user.teilnehmer);
}

