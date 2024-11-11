import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/menu/punkte_widget.dart';
import 'package:lernplatform/pages/Quiz/quiz_subthema_model.dart';
import 'package:lernplatform/pages/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';

class Quizmaster with ChangeNotifier{

  late List<UsersSubThema> selected_subthemen;
  late NewQuizsubthemaModel aktuelles_subthema;
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
      for(UsersThema thema in lernfeld.usersThemen)
        for(UsersSubThema subthema in thema.meineSubThemen)
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
    aktuelles_subthema = NewQuizsubthemaModel(
      selected_subthema: selected_subthemen[Random().nextInt(selected_subthemen.length)],
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

    if(aktuelles_subthema.random_question.somethingIsSelected) _evaluate();
    else aktuelles_subthema.random_question.blink();

  }

  void _evaluate(){
    int erreichte_punkte = aktuelles_subthema.random_question.erreichtePunkte_after_LockTapped;
    _fortschrittSpeicherAnzeiger.fortschritt = ++_bei_10_wird_gespeichert;
    _erreichtePunkteAnzeiger.punkte += erreichte_punkte;

    if(erreichte_punkte == aktuelles_subthema.random_question.frage.punkte)
      aktuelles_subthema.selected_subthema.logSubThema.richtigBeantworteteFragen.add(aktuelles_subthema.random_question.frage.id);
    else
      aktuelles_subthema.selected_subthema.logSubThema.falschBeantworteteFragen.add(aktuelles_subthema.random_question.frage.id);


    if(_bei_10_wird_gespeichert == 10){
      Session().gesamtSterne += _erreichtePunkteAnzeiger.punkte;
      _erreichtePunkteAnzeiger.punkte = 0;
      _bei_10_wird_gespeichert = 0;
      Session().user.speichern();
      aktuelles_subthema.selected_subthema.updateProgress(updateParent: true);
    } else
      aktuelles_subthema.selected_subthema.updateProgress(updateParent: false);

    _is_locked = true;
    notifyListeners();
    // print_Yellow("Quizmaster _evaluated"); // todo print
  }
}