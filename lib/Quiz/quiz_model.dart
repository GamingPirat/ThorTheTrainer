import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/Frage_Model.dart';
import 'package:lernplatform/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/Quiz/quiz_thema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/session.dart';
import '../menu/punkte_widget.dart';

class QuizModel with ChangeNotifier {
  final List<QuizThema> quizThemen;
  late QuizThema _aktuellesThema;
  bool _isLocked = false;
  Random _rnd = Random();
  int _bei3gibtsNeFalscheFrage = 0;
  int __bei10wirdGespeichert = 0;
  late Frage_Model _currentQuestioin;
  FortschrittSpeicherAnzeiger _fortschrittSpeicherAnzeiger = FortschrittSpeicherAnzeiger(fortschritt: 1);
  PunkteAnzeige _erreichtePunkte = PunkteAnzeige(punkte: 0,);

  QuizModel({required this.quizThemen}){
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
    nextTapped();  // Initialisiere die erste Frage
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
    _isLocked = false;
    _aktuellesThema = quizThemen[_rnd.nextInt(quizThemen.length)];
    _currentQuestioin = Frage_Model(
      frage: _aktuellesThema.getRandomFrage(++_bei3gibtsNeFalscheFrage),
      lockTapped: (int erreichtePunkte) => lockTapped(erreichtePunkte: erreichtePunkte)
    );
    if (_bei3gibtsNeFalscheFrage == 3) _bei3gibtsNeFalscheFrage = 0;
  }

  QuizThema get aktuellesThema => _aktuellesThema;
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
