import 'package:lernplatform/datenklassen/log_lernfeld_u_frage.dart';
import 'package:lernplatform/datenklassen/view_builder.dart';
import '../log_and_content-converter.dart';
import 'folder_types.dart';

class Thema extends ContentContainer {
  final List<int> tags; // Id's von Lerfeldern
  final List<Frage> fragen;

  Thema({
    required int id,
    required String name,
    required this.tags,
    required this.fragen,
  }) : super(id: id, name: name);

  int getTrueLengthOfFragen(){
    int counter = 0;
    for(Frage frage in fragen){
      if(frage.version == 1)
        counter++;
    }
    return counter;
  }
}

class LogThema {
  int id;
  List<LogFrage> offeneFragen;
  List<LogFrage> falschBeantworteteFragen;
  List<LogFrage> richtigBeantworteteFragen;

  LogThema({
    required this.id,
    required this.offeneFragen,
    required this.falschBeantworteteFragen,
    required this.richtigBeantworteteFragen,
  });

  double getProgress(){
    // zähle wie viele richtig beantwortet sind
    int erreichteZahl = 0;
    for(LogFrage frage in richtigBeantworteteFragen){
      if (frage.id.split('_').last == '1')
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
  Thema(id: 1, name: "LF 1 T1", tags: [1], fragen: mok_fragen_zuThema1),
  Thema(id: 2, name: "LF 1 T2", tags: [1], fragen: mok_fragen_zuThema2),
  Thema(id: 3, name: "LF 1,2 T3", tags: [1,2], fragen: mok_fragen_zuThema3),
  Thema(id: 4, name: "LF 1,2 T4", tags: [1,2], fragen: mok_fragen_zuThema4),
];

List<LogThema> mok_lokThemen =[
  LogThema(
      id: 1,
      offeneFragen: convertToLogFragen(fragen: mok_fragen_zuThema1),
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 2,
      offeneFragen: convertToLogFragen(fragen: mok_fragen_zuThema2),
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 3,
      offeneFragen: convertToLogFragen(fragen: mok_fragen_zuThema3),
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
  LogThema(
      id: 4,
      offeneFragen: convertToLogFragen(fragen: mok_fragen_zuThema4),
      falschBeantworteteFragen: [],
      richtigBeantworteteFragen: []
  ),
];