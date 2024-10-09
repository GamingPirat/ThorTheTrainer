import 'dart:math';

import '../datenklassen/log_lernfeld_u_frage.dart';
import '../datenklassen/log_teilnehmer.dart';
import '../datenklassen/thema.dart';
import '../datenklassen/thema_dbs.dart';
import '../session.dart';

class QuizTeilnehmer {
  late List<Thema> ausgewaehlteThemen;
  late List<LogThema> ausgewaehlteLogThemen;
  late LogThema _aktuellesLogThema;
  int _alle10RundenwirdGespeichert = 0;
  final random = Random();

  QuizTeilnehmer({required this.ausgewaehlteLogThemen});

  LogThema nextThema() {
    if (ausgewaehlteLogThemen.isEmpty) {
      throw Exception("Keine LogThemen verfügbar, um fortzufahren."); // Fehler ausgeben, falls keine LogThemen gefunden wurden
    }

    ++alle10RundenWirdGespeichert;
    _aktuellesLogThema = ausgewaehlteLogThemen[random.nextInt(ausgewaehlteLogThemen.length)]; // Korrekte Länge verwenden
    return aktuellesLogThema;
  }

  LogThema get aktuellesLogThema => _aktuellesLogThema;
  int get alle10RundenWirdGespeichert => _alle10RundenwirdGespeichert;

  set alle10RundenWirdGespeichert(int value) {
    _alle10RundenwirdGespeichert = value;
    if (_alle10RundenwirdGespeichert == 10) {
      Session().derEingeloggteUser_Model.teilnehmer.save();
      _alle10RundenwirdGespeichert = 0;
    }
  }
}

QuizTeilnehmer mok_quizTeilnehmer = QuizTeilnehmer(
    ausgewaehlteLogThemen: [
    Session().derEingeloggteUser_Model.teilnehmer.meineLernfelder[0].meineThemen[0]
    ]
);
