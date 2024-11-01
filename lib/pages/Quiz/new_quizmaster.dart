import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/pages/Quiz/Frage_Model.dart';
import 'package:lernplatform/pages/Quiz/new_quiz_subthema_widget.dart';
import 'package:lernplatform/pages/Quiz/new_quizsubthema_model.dart';
import 'package:lernplatform/session.dart';

class Quizmaster with ChangeNotifier{

  late List<UsersSubThema> selected_subthemen;
  late NewQuizsubthemaModel aktuelles_subthema;
  int bei_dritter_frage = 0;
  bool _is_locked = false;

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
    // hol dir die Subthemen die der User ausgewählt hat
    // ***************************************************************
    nextTapped();
  }

  bool get is_locked => _is_locked;

  void nextTapped(){
    ++bei_dritter_frage;
      aktuelles_subthema = NewQuizsubthemaModel(
          selected_subthema: selected_subthemen[Random().nextInt(selected_subthemen.length)]);
  }
}