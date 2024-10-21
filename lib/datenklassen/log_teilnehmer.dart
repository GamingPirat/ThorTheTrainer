import 'package:lernplatform/datenklassen/log_and_content-converter.dart';

import 'frage.dart';

class Teilnehmer {
  List<LogLernfeld> meineLernfelder;
  final String key;

  Teilnehmer({required this.key, required this.meineLernfelder});

  String get getKey => key;
}


class LogLernfeld {
  int id;
  List<LogThema> meineThemen;
  LogLernfeld(this.id, this.meineThemen);
}

class LogThema {
  int id;
  List<LogSubThema> logSubthemen;

  // String get name => convertToThema(logthema: this).name;

  LogThema({
    required this.id,
    required this.logSubthemen,
  });

  double getProgress(){
    // ittereiere durch deine subthemen und lass dir den progress geben

    double erreichteZahl = 0;
    for(LogSubThema subThema in logSubthemen){
      erreichteZahl += subThema.getProgress();
    }
    while (erreichteZahl > 1)
      erreichteZahl /= 10;

    return 1 - erreichteZahl;
  }

}





class LogSubThema {
  int id;
  List<String> falschBeantworteteFragen;
  List<String> richtigBeantworteteFragen;

  LogSubThema({
    required this.id,
    required this.falschBeantworteteFragen,
    required this.richtigBeantworteteFragen,
  });

  double getProgress(){
    // zähle wie viele richtig beantwortet sind
    int richtigbeantwortete = 0;
    for(String frage in richtigBeantworteteFragen){
      if (frage.split('_').last == '1')
        richtigbeantwortete++;
    }

    int trueLengthOfFragen = convertToSubThema(logthema: this).fragen.length;

    // bilde fortschritt
    double progress = richtigbeantwortete / trueLengthOfFragen;

    // stelle sicher das fortschritt nicht größer als 1 ist
    progress = progress.clamp(0.0, 1.0);

    return progress;
  }

  String get name => convertToSubThema(logthema: this).name;
}

