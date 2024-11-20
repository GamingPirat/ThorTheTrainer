

import 'package:lernplatform/globals/print_colors.dart';

class LogTeilnehmer {
  List<LogLernfeld> logLernfelder;
  int sterne;

  LogTeilnehmer({required this.sterne, required this.logLernfelder});

  Map<String, dynamic> toJson() => {
    'sterne': sterne,
    'logLernfelder': logLernfelder.map((lernfeld) => lernfeld.toJson()).toList(),
  };

  factory LogTeilnehmer.fromJson(Map<String, dynamic> json) {
    print_Blue("LogTeilnehmer.fromJson: Eingangsdaten: $json");
    print_Blue("LogTeilnehmer.fromJson:Typ von meineLernfelder: ${json['meineLernfelder']?.runtimeType}");
    print_Blue("LogTeilnehmer.fromJson: Inhalt von meineLernfelder: ${json['meineLernfelder']}");

    try {
      return LogTeilnehmer(
        sterne: json['sterne'] ?? 0,
        logLernfelder: ((json['logLernfelder'] as List?) ?? [])
            .map((item) => LogLernfeld.fromJson(item))
            .toList(),
      );
    } catch (e, stackTrace) {
      print_Red("LogTeilnehmer.fromJson: Fehler: $e");
      print_Red("StackTrace: $stackTrace");
      rethrow;
    }
  }


  @override
  String toString() {
    final lernfelderString = logLernfelder.map((lernfeld) => lernfeld.toString()).join("\n");
    return "${cyan}Teilnehmer{ sterne: $sterne, logLernfelder:\n$lernfelderString\n ${cyan}}$resetColor";
  }
}

class LogLernfeld {
  int id;
  List<LogKompetenzbereich> logKompetenzbereiche;

  LogLernfeld(this.id, this.logKompetenzbereiche);

  Map<String, dynamic> toJson() => {
    'id': id,
    'logKompetenzbereiche': logKompetenzbereiche.map((kompetenzbereich) => kompetenzbereich.toJson()).toList(),
  };

  factory LogLernfeld.fromJson(Map<String, dynamic> json) {
    print("LogLernfeld.fromJson: Eingangsdaten: $json");
    print("LogLernfeld.fromJson: Typ von meineThemen: ${json['meineThemen']?.runtimeType}");
    print("LogLernfeld.fromJson: Inhalt von meineThemen: ${json['meineThemen']}");

    return LogLernfeld(
      json['id'],
      (json['logKompetenzbereiche'] as List).map((item) => LogKompetenzbereich.fromJson(item)).toList(),
    );
  }


  @override
  String toString() {
    final kompetenzbereiche_ = logKompetenzbereiche.map((thema) => thema.toString()).join("\n");
    return "${green}  LogLernfeld{ id: $id, logKompetenzbereiche:\n$kompetenzbereiche_\n   ${green}}$resetColor";
  }
}

class LogKompetenzbereich {
  int id;
  List<LogInhalt> logInhalte;

  LogKompetenzbereich({
    required this.id,
    required this.logInhalte,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'logInhalte': logInhalte.map((logInhalt) => logInhalt.toJson()).toList(),
  };

  factory LogKompetenzbereich.fromJson(Map<String, dynamic> json) {
    print("LogKompetenzbereich.fromJson: Eingangsdaten: $json");
    print("Typ von logInhalte: ${json['logInhalte']?.runtimeType}");
    print("Inhalt von logInhalte: ${json['logInhalte']}");

    return LogKompetenzbereich(
      id: json['id'],
      logInhalte: (json['logInhalte'] as List).map((item) => LogInhalt.fromJson(item)).toList(),
    );
  }


  @override
  String toString() {
    final subthemenString = logInhalte.map((subThema) => subThema.toString()).join("\n");
    return "${yellow}    LogKompetenzbereich{ id: $id, logInhalte:\n$subthemenString\n    ${yellow}}$resetColor";
  }
}

class LogInhalt {
  int id;
  List<String> falschBeantworteteFragen;
  List<String> richtigBeantworteteFragen;

  LogInhalt({
    required this.id,
    required this.falschBeantworteteFragen,
    required this.richtigBeantworteteFragen,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'falschBeantworteteFragen': falschBeantworteteFragen,
    'richtigBeantworteteFragen': richtigBeantworteteFragen,
  };

  factory LogInhalt.fromJson(Map<String, dynamic> json) {
    print("LogInhalt.fromJson: Eingangsdaten: $json");
    print("Typ von falschBeantworteteFragen: ${json['falschBeantworteteFragen']?.runtimeType}");
    print("Inhalt von falschBeantworteteFragen: ${json['falschBeantworteteFragen']}");
    print("Typ von richtigBeantworteteFragen: ${json['richtigBeantworteteFragen']?.runtimeType}");
    print("Inhalt von richtigBeantworteteFragen: ${json['richtigBeantworteteFragen']}");

    return LogInhalt(
      id: json['id'],
      falschBeantworteteFragen: List<String>.from(json['falschBeantworteteFragen'] ?? []),
      richtigBeantworteteFragen: List<String>.from(json['richtigBeantworteteFragen'] ?? []),
    );
  }


  @override
  String toString() {
    return "${magenta}      LogInhalt{ id: $id, falschBeantworteteFragen: ${falschBeantworteteFragen.length}, richtigBeantworteteFragen: ${richtigBeantworteteFragen.length} ${magenta}}$resetColor";
  }
}


// ANSI Escape Codes für Farben
const String resetColor = "\x1B[0m";
const String black = "\x1B[30m";
const String red = "\x1B[31m";
const String green = "\x1B[32m";
const String yellow = "\x1B[33m";
const String blue = "\x1B[34m";
const String magenta = "\x1B[35m";
const String cyan = "\x1B[36m";
const String white = "\x1B[37m";