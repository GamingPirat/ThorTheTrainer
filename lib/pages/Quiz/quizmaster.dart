import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/menu/punkte_widget.dart';
import 'package:lernplatform/pages/Quiz/quiz_subthema_model.dart';
import 'package:lernplatform/pages/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/session.dart';

class Quizmaster with ChangeNotifier{

  late List<UsersSubThema> selected_subthemen;
  late NewQuizsubthemaModel aktuelles_subthema;
  int bei_dritter_frage = 0;
  bool _is_locked = false;
  FortschrittSpeicherAnzeiger _fortschrittSpeicherAnzeiger = FortschrittSpeicherAnzeiger(fortschritt: 1);
  PunkteAnzeige _erreichtePunkteAnzeiger = PunkteAnzeige(punkte: 0,);

  Quizmaster(){
    // ***************************************************************
    // hol dir die Subthemen die der User ausgewählt hat
    // ***************************************************************
    selected_subthemen = [];
    for(UsersLernfeld lernfeld in Session().user.usersLernfelder)
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
    ++bei_dritter_frage;
      aktuelles_subthema = NewQuizsubthemaModel(
        selected_subthema: selected_subthemen[Random().nextInt(selected_subthemen.length)],
        onLockTapped: ()=> onLockTapped(),
      );
    // print_Yellow("Quizmaster.nextTapped"); // todo print
    notifyListeners();
  }

  void onLockTapped(){
    // print_Yellow("Quizmaster.onLockTapped"); // todo print

    if(aktuelles_subthema.random_question.somethingIsSelected) _evaluate();
    else aktuelles_subthema.random_question.blink();

  }

  void _evaluate(){
    _erreichtePunkteAnzeiger.punkte += aktuelles_subthema.random_question.evaluate();
    _fortschrittSpeicherAnzeiger.fortschritt++;
    _is_locked = true;
    notifyListeners();
    // print_Yellow("Quizmaster _evaluate $_is_locked"); // todo print
  }
}