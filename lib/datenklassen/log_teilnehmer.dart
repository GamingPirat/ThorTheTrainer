class Teilnehmer {
  List<LogLernfeld> meineLernfelder;
  final String key;

  Teilnehmer({required this.key, required this.meineLernfelder});

  String get getKey => key;

  @override
  String toString() {
    return "Teilnehmer{ key: $key meineLernfelder: ${meineLernfelder.length}";
  }
}

class LogLernfeld {
  int id;
  List<LogThema> meineThemen;
  LogLernfeld(this.id, this.meineThemen);
}


class LogThema {
  int id;
  List<LogSubThema> logSubthemen;

  LogThema({
    required this.id,
    required this.logSubthemen,
  });
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
}

