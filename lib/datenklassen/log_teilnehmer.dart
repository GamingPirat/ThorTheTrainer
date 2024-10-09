import 'package:lernplatform/datenklassen/log_and_content-converter.dart';

class Teilnehmer {
  List<LogLernfeld> meineLernfelder;
  final String key;

  Teilnehmer({required this.key, required this.meineLernfelder});
}


class LogLernfeld {
  int id;
  List<LogThema> meineThemen;
  LogLernfeld(this.id, this.meineThemen);
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
    int gesamtZahl = convertToThema(logthema: this).getTrueLengthOfFragen();

    // bilde fortschritt
    double progress = erreichteZahl / gesamtZahl;

    // stelle sicher das fortschritt nicht größer als 1 ist
    progress = progress.clamp(0.0, 1.0);

    return progress;
  }

  String get name => convertToThema(logthema: this).name;
}

