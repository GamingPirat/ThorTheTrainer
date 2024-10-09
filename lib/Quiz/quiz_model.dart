import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/Frage_Model.dart';
import 'package:lernplatform/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/Quiz/quiz_teilnehmer.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/session.dart';
import '../menu/punkte_widget.dart';

class QuizModel with ChangeNotifier {

  late QuizThema quizTeilnehmer;
  bool _isLocked = false;
  bool _isLoading= true;
  List<Frage_Model> historie = [];
  Random rnd = Random();
  late LogThema _aktuellesThema;
  late Frage_Model _currentQuestioin;
  FortschrittSpeicherAnzeiger fortschrittSpeicherAnzeiger = FortschrittSpeicherAnzeiger(fortschritt: 1);
  PunkteAnzeige erreichtePunkte = PunkteAnzeige(punkte: 0,);
  Drawer rightDrawer = Drawer(
    child: Container(
      color: Colors.white,
      child: Text("Blah!"),
    ),
  );

  QuizModel({required this.quizTeilnehmer}){
    Session().pageHeader = Row(
      children: [
        Spacer(),
        fortschrittSpeicherAnzeiger,
        Spacer(),
        Icon(Icons.military_tech),
        erreichtePunkte,
        Spacer(),
      ],
    );
    nextTapped();
  }


  void lockTapped() {
    if(_currentQuestioin.isSomthingSelected()){
      _isLocked = true;
      // schreibe Punkte gut
      int erreichte_punkte = currentQuestioin.evaluate();
      erreichtePunkte.punkte += erreichte_punkte;

      // stecke aktuelle Frage in richtig- oder falsch -beantwortete
      if (_currentQuestioin.frage.punkte > erreichte_punkte)
        _aktuellesThema.falschBeantworteteFragen.add(_currentQuestioin.frage.id.toString());
      else
        _aktuellesThema.richtigBeantworteteFragen.add(_currentQuestioin.frage.id.toString());

      // erhöhe Fortschritt
      bei10wirdGespeichert++;
      notifyListeners();
    }
  }

  void nextTapped() {
    _isLocked = false;
    _aktuellesThema = quizTeilnehmer.nextThema();
    _currentQuestioin = Frage_Model(frage: Session().themenService.getRandomFrage(_aktuellesThema));
    notifyListeners();

  }

  LogThema get aktuellesThema => _aktuellesThema;
  Frage_Model get currentQuestioin => _currentQuestioin;
  bool get isLocked => _isLocked;
  bool get isLoading => _isLoading;
  int get bei10wirdGespeichert => quizTeilnehmer.alle10RundenWirdGespeichert;
  set bei10wirdGespeichert(int value){
    quizTeilnehmer.alle10RundenWirdGespeichert = value;
    if(quizTeilnehmer.alle10RundenWirdGespeichert == 10){
      erreichtePunkte.punkte = 0;
      Session().punkteAnzeige.punkte +=15; // todo
    fortschrittSpeicherAnzeiger.updateFilledContainers(quizTeilnehmer.alle10RundenWirdGespeichert);
    }

  }
}
