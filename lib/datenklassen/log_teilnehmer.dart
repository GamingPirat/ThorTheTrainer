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

class LogTeilnehmer {
  List<LogLernfeld> meineLernfelder;
  int sterne;

  LogTeilnehmer({required this.sterne, required this.meineLernfelder});

  Map<String, dynamic> toJson() => {
    'sterne': sterne,
    'meineLernfelder': meineLernfelder.map((lernfeld) => lernfeld.toJson()).toList(),
  };

  factory LogTeilnehmer.fromJson(Map<String, dynamic> json) => LogTeilnehmer(
    sterne: json['sterne'],
    meineLernfelder: (json['meineLernfelder'] as List)
        .map((item) => LogLernfeld.fromJson(item))
        .toList(),
  );

  @override
  String toString() {
    final lernfelderString = meineLernfelder.map((lernfeld) => lernfeld.toString()).join("\n");
    return "${cyan}Teilnehmer{ key: $sterne, meineLernfelder:\n$lernfelderString\n ${cyan}}$resetColor";
  }
}

class LogLernfeld {
  int id;
  List<LogThema> meineThemen;

  LogLernfeld(this.id, this.meineThemen);

  Map<String, dynamic> toJson() => {
    'id': id,
    'meineThemen': meineThemen.map((thema) => thema.toJson()).toList(),
  };

  factory LogLernfeld.fromJson(Map<String, dynamic> json) => LogLernfeld(
    json['id'],
    (json['meineThemen'] as List).map((item) => LogThema.fromJson(item)).toList(),
  );

  @override
  String toString() {
    final themenString = meineThemen.map((thema) => thema.toString()).join("\n");
    return "${green}  LogLernfeld{ id: $id, meineThemen:\n$themenString\n  ${green}}$resetColor";
  }
}

class LogThema {
  int id;
  List<LogSubThema> logSubthemen;

  LogThema({
    required this.id,
    required this.logSubthemen,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'logSubthemen': logSubthemen.map((subThema) => subThema.toJson()).toList(),
  };

  factory LogThema.fromJson(Map<String, dynamic> json) => LogThema(
    id: json['id'],
    logSubthemen: (json['logSubthemen'] as List)
        .map((item) => LogSubThema.fromJson(item))
        .toList(),
  );

  @override
  String toString() {
    final subthemenString = logSubthemen.map((subThema) => subThema.toString()).join("\n");
    return "${yellow}    LogThema{ id: $id, logSubthemen:\n$subthemenString\n    ${yellow}}$resetColor";
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'falschBeantworteteFragen': falschBeantworteteFragen,
    'richtigBeantworteteFragen': richtigBeantworteteFragen,
  };

  factory LogSubThema.fromJson(Map<String, dynamic> json) => LogSubThema(
    id: json['id'],
    falschBeantworteteFragen: List<String>.from(json['falschBeantworteteFragen']),
    richtigBeantworteteFragen: List<String>.from(json['richtigBeantworteteFragen']),
  );

  @override
  String toString() {
    return "${magenta}      LogSubThema{ id: $id, falschBeantworteteFragen: ${falschBeantworteteFragen.length}, richtigBeantworteteFragen: ${richtigBeantworteteFragen.length}      ${magenta}}$resetColor";
  }
}
