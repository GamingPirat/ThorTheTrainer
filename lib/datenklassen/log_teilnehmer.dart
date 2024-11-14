

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
    return "${cyan}Teilnehmer{ sterne: $sterne, meineLernfelder:\n$lernfelderString\n ${cyan}}$resetColor";
  }
}

class LogLernfeld {
  int id;
  List<LogKompetenzbereich> meineThemen;

  LogLernfeld(this.id, this.meineThemen);

  Map<String, dynamic> toJson() => {
    'id': id,
    'kompetenzbereiche': meineThemen.map((kompetenzbereich) => kompetenzbereich.toJson()).toList(),
  };

  factory LogLernfeld.fromJson(Map<String, dynamic> json) => LogLernfeld(
    json['id'],
    (json['kompetenzbereiche'] as List).map((item) => LogKompetenzbereich.fromJson(item)).toList(),
  );

  @override
  String toString() {
    final kompetenzbereiche_ = meineThemen.map((thema) => thema.toString()).join("\n");
    return "${green}  LogLernfeld{ id: $id, kompetenzbereiche:\n$kompetenzbereiche_\n   ${green}}$resetColor";
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

  factory LogKompetenzbereich.fromJson(Map<String, dynamic> json) => LogKompetenzbereich(
    id: json['id'],
    logInhalte: (json['logInhalte'] as List)
        .map((item) => LogInhalt.fromJson(item))
        .toList(),
  );

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

  factory LogInhalt.fromJson(Map<String, dynamic> json) => LogInhalt(
    id: json['id'],
    falschBeantworteteFragen: List<String>.from(json['falschBeantworteteFragen']),
    richtigBeantworteteFragen: List<String>.from(json['richtigBeantworteteFragen']),
  );

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