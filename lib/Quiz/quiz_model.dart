import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/Frage_Model.dart';
import 'package:lernplatform/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/Quiz/quiz_teilnehmer.dart';
import 'package:lernplatform/datenklassen/log_lernfeld_u_frage.dart';
import 'package:lernplatform/log_and_content-converter.dart';
import 'package:lernplatform/user_session.dart';
import '../datenklassen/thema.dart';
import '../datenklassen/view_builder.dart';

class QuizModel with ChangeNotifier {

  QuizTeilnehmer quizTeilnehmer;
  bool _isLocked = false;
  List<Frage_Model> historie = [];
  int _bei10wirdGespeichert = 1;
  Random rnd = Random();
  late LogThema _aktuellesThema;
  late Frage_Model _currentQuestioin;
  FortschrittSpeicherAnzeiger fortschrittSpeicherAnzeiger = FortschrittSpeicherAnzeiger(fortschritt: 1);

  QuizModel({required this.quizTeilnehmer}){
    UserSession().pageHeader = Row(
      children: [
        fortschrittSpeicherAnzeiger,
      ],
    );
    nextTapped();
  }

  void lockTapped() {
    _isLocked = true;
    // Suche das Objekt, dessen id mit der aktuellen Frage übereinstimmt
    LogFrage removed = _aktuellesThema.offeneFragen.firstWhere(
          (frage) => frage.id == _currentQuestioin.frage!.id,
    );
    _aktuellesThema.offeneFragen.remove(removed);

    if (_currentQuestioin.frage.punkte > _currentQuestioin.evaluate())
      _aktuellesThema.falschBeantworteteFragen.add(removed);
    else
      _aktuellesThema.richtigBeantworteteFragen.add(removed);

    bei10wirdGespeichert++;

    notifyListeners();
  }

  void nextTapped(){
    _aktuellesThema = quizTeilnehmer.nextThema();
    _isLocked = false;
    List<Frage> randomFragen = convertToFragen(logFragen: _aktuellesThema.offeneFragen);
    _currentQuestioin = Frage_Model(frage: randomFragen[rnd.nextInt(randomFragen.length)]);
    notifyListeners();
  }


  LogThema get aktuellesThema => _aktuellesThema;
  Frage_Model get currentQuestioin => _currentQuestioin;
  bool get isLocked => _isLocked;
  int get bei10wirdGespeichert => _bei10wirdGespeichert;
  set bei10wirdGespeichert(int value){
    _bei10wirdGespeichert = value;
    if(_bei10wirdGespeichert == 10){
      // quizTeilnehmer.speichern();  todo
    } else if (_bei10wirdGespeichert == 11)
      _bei10wirdGespeichert = 1;
    fortschrittSpeicherAnzeiger.updateFilledContainers(_bei10wirdGespeichert);
  }

}




