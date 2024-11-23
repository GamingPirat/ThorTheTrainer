import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_kompetenzbereich_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_inhalt_viewmodel.dart';
import 'package:lernplatform/menu/punkte_widget.dart';
import 'package:lernplatform/pages/Quiz/quiz_inhalt_controller.dart';
import 'package:lernplatform/pages/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';

class Quizmaster with ChangeNotifier{

  late List<UsersInhalt> selected_subthemen;
  late QuizInhaltController aktueller_inhalt;
  int runde = 0;
  int _bei_10_wird_gespeichert = 0;
  bool _is_locked = false;
  FortschrittSpeicherAnzeiger _fortschrittSpeicherAnzeiger = FortschrittSpeicherAnzeiger(fortschritt: 1);
  PunkteAnzeige _erreichtePunkteAnzeiger = PunkteAnzeige(punkte: 0,);

  Quizmaster(){
    // ***************************************************************
    // hol dir die Subthemen die der User ausgewählt hat
    // ***************************************************************
    selected_subthemen = [];
    for(UsersLernfeld lernfeld in Session().user.lernfelder)
      for(UsersKompetenzbereich thema in lernfeld.usersKompetenzbereiche)
        for(UsersInhalt subthema in thema.usersInhalte)
          if(subthema.isSelected)
            selected_subthemen.add(subthema);


    // ***************************************************************
    // Platziere Header
    // ***************************************************************
    Session().pageHeader = Row(
      children: [
        Spacer(),
        _fortschrittSpeicherAnzeiger,
        Spacer(),
        Icon(Icons.military_tech),
        _erreichtePunkteAnzeiger,
        Spacer(),
      ],
    );
    nextQuestion();
  }

  bool get is_locked => _is_locked;

  void nextQuestion(){
    _is_locked = false;
    aktueller_inhalt = QuizInhaltController(
      selected_inhalt: selected_subthemen[Random().nextInt(selected_subthemen.length)],
      onLockTapped: ()=> onLockTapped(),
      runde: ++runde
    );
    if(runde == 3)
      runde = 0;

    // print_Yellow("Quizmaster.nextTapped"); // todo print
    notifyListeners();
  }

  void onLockTapped(){
    // print_Yellow("Quizmaster.onLockTapped"); // todo print

    if(aktueller_inhalt.random_question.somethingIsSelected) _evaluate();
    else aktueller_inhalt.random_question.blink();

  }

  void _evaluate(){
    int erreichte_punkte = aktueller_inhalt.random_question.erreichtePunkte_after_LockTapped;
    _fortschrittSpeicherAnzeiger.fortschritt = ++_bei_10_wird_gespeichert;
    _erreichtePunkteAnzeiger.punkte += erreichte_punkte;

    if(erreichte_punkte == aktueller_inhalt.random_question.frage.punkte)
      aktueller_inhalt.selected_inhalt.logInhalt.richtigBeantworteteFragen.add(aktueller_inhalt.random_question.frage.id);
    else
      aktueller_inhalt.selected_inhalt.logInhalt.falschBeantworteteFragen.add(aktueller_inhalt.random_question.frage.id);


    if(_bei_10_wird_gespeichert == 10){
      Session().gesamtSterne += _erreichtePunkteAnzeiger.punkte;
      _erreichtePunkteAnzeiger.punkte = 0;
      _bei_10_wird_gespeichert = 0;
      Session().user.speichern();
      aktueller_inhalt.selected_inhalt.updateProgress(updateParent: true);
    } else
      aktueller_inhalt.selected_inhalt.updateProgress(updateParent: false);

    _is_locked = true;
    notifyListeners();
    // print_Yellow("Quizmaster _evaluated"); // todo print
  }
}