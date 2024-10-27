import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/menu/punkte_widget.dart';
import 'package:lernplatform/pages/Quiz/Frage_Model.dart';
import 'package:lernplatform/pages/Quiz/quiz_subthema.dart';
import 'package:lernplatform/pages/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/print_colors.dart';
import 'package:lernplatform/session.dart';

class QuizModel with ChangeNotifier {
  late final List<QuizSubThema> quizThemen;
  late QuizSubThema _aktuellesThema;
  bool _isLocked = false;
  Random _rnd = Random();
  int _bei3gibtsNeFalscheFrage = 0;
  int __bei10wirdGespeichert = 0;
  late Frage_Model _currentQuestioin;
  FortschrittSpeicherAnzeiger _fortschrittSpeicherAnzeiger = FortschrittSpeicherAnzeiger(fortschritt: 1);
  PunkteAnzeige _erreichtePunkte = PunkteAnzeige(punkte: 0,);

  QuizModel(){
    Session().pageHeader = Row(
      children: [
        Spacer(),
        _fortschrittSpeicherAnzeiger,
        Spacer(),
        Icon(Icons.military_tech),
        _erreichtePunkte,
        Spacer(),
      ],
    );
    _getUsersSelection();
    nextTapped();  // Initialisiere die erste Frage
  }

  // hole was der USer ausgewählt hat
  void _getUsersSelection(){
    print_Magenta("QuizModel _getUsersSelection()"); // todo print
    List<QuizSubThema> selctedThemen = [];
    for(UsersLernfeld lernfeld in Session().user.usersLernfelder)
      for(UsersThema thema in lernfeld.usersThemen)
        for(UsersSubThema subThema in thema.meineSubThemen)
          if(subThema.isSelected)
            selctedThemen.add(QuizSubThema(usersSubThema: subThema));
    print_Magenta("QuizModel _getUsersSelection() selctedThemen.length = ${selctedThemen.length}"); // todo print
    quizThemen = selctedThemen;
  }

  void lockTapped({required int erreichtePunkte}) {

    _isLocked = true;

    // Berechne die Punkte und aktualisiere sie im Punkteanzeige-Modell
    _erreichtePunkte.punkte += erreichtePunkte;

    // Stecke aktuelle Frage in richtig- oder falsch-beantwortete Liste
    if (_currentQuestioin.frage.punkte == erreichtePunkte) {
      _aktuellesThema.userHatRichtigGeantwortet(_currentQuestioin.frage.id);
    } else {
      _aktuellesThema.userHatFalschGeantwortet(_currentQuestioin.frage.id);
    }
    _bei10wirdGespeichert++;

    notifyListeners();
  }

  void nextTapped() {
    print_Magenta("QuizModel nextTapped()"); // todo print
    _isLocked = false;

    // Überprüfe, ob die Liste leer ist, bevor du versuchst, darauf zuzugreifen
    if (quizThemen.isNotEmpty) {
      _aktuellesThema = quizThemen[_rnd.nextInt(quizThemen.length)];
      print_Magenta("QuizModel nextTapped() _aktuellesThema = $_aktuellesThema");
      _currentQuestioin = Frage_Model(
          frage: _aktuellesThema.getRandomFrage(++_bei3gibtsNeFalscheFrage),
          lockTapped: (int erreichtePunkte) => lockTapped(erreichtePunkte: erreichtePunkte)
      );
      print_Magenta("QuizModel nextTapped() _currentQuestioin = $_currentQuestioin"); // todo print
    } else {
      print("Keine Quiz-Themen vorhanden");
      // Hier kannst du eine alternative Logik einfügen, falls keine Themen vorhanden sind
      _currentQuestioin = Frage_Model(
          frage: DB_Frage( text: 'Keine Quiz-Themen vorhanden', nummer: 1, version: 1, themaID: 1, punkte: 1, antworten: []),
          lockTapped: (int erreichtePunkte) => lockTapped(erreichtePunkte: erreichtePunkte)
      );
    }

    if (_bei3gibtsNeFalscheFrage == 3) _bei3gibtsNeFalscheFrage = 0;
  }


  QuizSubThema get aktuellesThema => _aktuellesThema;
  Frage_Model get currentQuestioin => _currentQuestioin;
  bool get isLocked => _isLocked;
  int get _bei10wirdGespeichert => __bei10wirdGespeichert;
  set _bei10wirdGespeichert(int value) {
    __bei10wirdGespeichert = value;
    if (__bei10wirdGespeichert == 10) {
      Session().punkteAnzeige.punkte += _erreichtePunkte.punkte;
      _erreichtePunkte.punkte = 0;  // Reset the points
      _fortschrittSpeicherAnzeiger.updateFilledContainers(__bei10wirdGespeichert);  // Update the progress indicator to full
      __bei10wirdGespeichert = 0;  // Reset the counter after saving
    } else {
      _fortschrittSpeicherAnzeiger.updateFilledContainers(__bei10wirdGespeichert);  // Update with current value
    }
  }
}
