import 'package:lernplatform/globals/print_colors.dart';

class LogTeilnehmer {
  List<LogLernfeld> logLernfelder;
  int sterne;

  LogTeilnehmer({required this.sterne, required this.logLernfelder});

  Map<String, dynamic> toJson() => {
    'sterne': sterne,
    'meineLernfelder': logLernfelder.map((lernfeld) => lernfeld.toJson()).toList(),
  };

  factory LogTeilnehmer.fromJson(Map<String, dynamic> json) {
    print_Blue("LogTeilnehmer.fromJson: Eingangsdaten: $json");

    try {
      return LogTeilnehmer(
        sterne: json['sterne'] ?? 0,
        logLernfelder: (json['meineLernfelder'] as List<dynamic>? ?? [])
            .map((lernfeldJson) => LogLernfeld.fromJson(lernfeldJson))
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
    'meineThemen': logKompetenzbereiche.map((kompetenzbereich) => kompetenzbereich.toJson()).toList(),
  };

  factory LogLernfeld.fromJson(Map<String, dynamic> json) {
    print_Blue("LogLernfeld.fromJson: Eingangsdaten: $json");

    return LogLernfeld(
      json['id'] ?? 0,
      (json['meineThemen'] as List<dynamic>? ?? [])
          .map((kompetenzbereichJson) => LogKompetenzbereich.fromJson(kompetenzbereichJson))
          .toList(),
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
    'logSubthemen': logInhalte.map((logInhalt) => logInhalt.toJson()).toList(),
  };

  factory LogKompetenzbereich.fromJson(Map<String, dynamic> json) {
    print_Blue("LogKompetenzbereich.fromJson: Eingangsdaten: $json");

    return LogKompetenzbereich(
      id: json['id'] ?? 0,
      logInhalte: (json['logSubthemen'] as List<dynamic>? ?? [])
          .map((inhaltJson) => LogInhalt.fromJson(inhaltJson))
          .toList(),
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
  Set<String> falschBeantworteteFragen;
  Set<String> richtigBeantworteteFragen;

  LogInhalt({
    required this.id,
    required this.falschBeantworteteFragen,
    required this.richtigBeantworteteFragen,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'falschBeantworteteFragen': falschBeantworteteFragen.toList(),
    'richtigBeantworteteFragen': richtigBeantworteteFragen.toList(),
  };

  factory LogInhalt.fromJson(Map<String, dynamic> json) {
    print_Yellow("LogInhalt.fromJson hat folgende Daten erhalten: $json");

    return LogInhalt(
      id: json['id'] ?? 0,
      falschBeantworteteFragen: (json['falschBeantworteteFragen'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toSet() ?? // List in Set umwandeln
          {},
      richtigBeantworteteFragen: (json['richtigBeantworteteFragen'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toSet() ?? // List in Set umwandeln
          {},
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
