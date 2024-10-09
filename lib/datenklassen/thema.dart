import 'dart:convert';
import 'dart:io';

import 'package:lernplatform/datenklassen/thema_dbs.dart';
import 'package:lernplatform/datenklassen/log_lernfeld_u_frage.dart';
import 'package:lernplatform/datenklassen/frage.dart';
import '../log_and_content-converter.dart';
import 'folder_types.dart';



class Thema extends ContentContainer {
  final List<int> tags; // Id's von Lernfeldern
  final List<Frage> fragen;

  Thema({
    required int id,
    required String name,
    required this.tags,
    required this.fragen,
  }) : super(id: id, name: name);

  factory Thema.fromJson(Map<String, dynamic> json) {
    return Thema(
      id: json['id'],
      name: json['name'],
      tags: List<int>.from(json['tags'] ?? []), // Sicherheit hinzufügen, um leere Tags zu vermeiden
      fragen: (json['fragen'] as List<dynamic>?)?.map((frageJson) => Frage.fromJson(frageJson)).toList() ?? [], // Fragen korrekt dekodieren
    );
  }

  static Future<Thema> fromJsonFile(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    return Thema.fromJson(json);
  }

  int getTrueLengthOfFragen() {
    int counter = 0;
    for (Frage frage in fragen) {
      if (frage.version == 1) counter++;
    }
    return counter;
  }
}


class LogThema {
  int id;
  List<String> falschBeantworteteFragen;
  List<String> richtigBeantworteteFragen;

  LogThema({
    required this.id,
    required this.falschBeantworteteFragen,
    required this.richtigBeantworteteFragen,
  });

  double getProgress(){
    // zähle wie viele richtig beantwortet sind
    int erreichteZahl = 0;
    for(String frage in richtigBeantworteteFragen){
      if (frage.split('_').last == '1')
        erreichteZahl++;
    }

    // finde heraus wie viele richtig sein könnten
    int gesamtZahl = convertToThema(logthema: this).getTrueLengthOfFragen();

    // bilde fortschritt
    double progress = erreichteZahl / gesamtZahl;

    // stelle sicher das fortschritt nicht größer als 1 ist
    progress = progress.clamp(0.0, 1.0);

    return progress;
  }

  String get name => convertToThema(logthema: this).name;
}



List<Thema> mok_themen = [
  Thema(id: 1, name: "LF 1 T1", tags: [1], fragen: []),
  Thema(id: 2, name: "LF 1 T2", tags: [1], fragen: []),
  Thema(id: 3, name: "LF 1,2 T3", tags: [1,2], fragen: []),
  Thema(id: 4, name: "LF 1,2 T4", tags: [1,2], fragen: []),
];

List<LogThema> mok_lokThemen =[
  LogThema(
      id: 1,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 2,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 3,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 4,
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
];