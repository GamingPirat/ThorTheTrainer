import 'dart:math';
import 'package:lernplatform/Quiz/speicher_fortschritt_anzeige.dart';

import '../datenklassen/log_lernfeld_u_frage.dart';
import '../datenklassen/thema.dart';
import '../session.dart';

class Teilnehmer {
  late List<LogLernfeld> meineLernfelder;

  Teilnehmer() {
    load();
  }

  Future<void> load() async {
    meineLernfelder = [

    ];
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? gespeicherteDaten = prefs.getString('ThorTheTrainerStudent');
    //
    // if (gespeicherteDaten != null) {
    //   List<dynamic> jsonList = jsonDecode(gespeicherteDaten);
    //   meineThemen = jsonList.map((item) => LogLernfeld.fromJson(item)).toList();
    // } else {
    //   meineThemen = [];
    // }
  }

  Future<void> save() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // List<Map<String, dynamic>> jsonList =
    // meineThemen.map((thema) => thema.toJson()).toList();
    // prefs.setString('ThorTheTrainerStudent', jsonEncode(jsonList));
  }
}

Teilnehmer mok_teilnehmer = Teilnehmer();


class QuizTeilnehmer{

  Teilnehmer teilnehmer;
  List<LogThema> ausgewaehlteThemen = mok_lokThemen;  // todo soll später vom QuizStarter übergeben werden
  int alle10RundenwirdGespeichert = 0;
  final random = Random();

  QuizTeilnehmer({required this.teilnehmer}){
    // UserSession().pageHeader = QuizAppbarWidget(0);
  }

  LogThema nextThema(){
    // UserSession().pageHeader = QuizAppbarWidget(++alle10RundenwirdGespeichert);
    if(alle10RundenwirdGespeichert == 10){
      teilnehmer.save();
      alle10RundenwirdGespeichert = 0;
    }
    return ausgewaehlteThemen[random.nextInt(ausgewaehlteThemen.length)];
  }
}