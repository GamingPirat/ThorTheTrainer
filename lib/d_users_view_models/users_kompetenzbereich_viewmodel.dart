import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_inhalt.dart';
import 'package:lernplatform/d_users_view_models/log_teilnehmer.dart';
import 'package:lernplatform/globals/print_colors.dart';

class UsersInhalt extends UsersContentModel {
  final LogInhalt logInhalt;
  final Inhalt inhalt;
  final Function parentCallBack_areChildsSelected;
  final Function parentCallBack_updateProgress;

  UsersInhalt({
    required this.logInhalt,
    required this.inhalt,
    required this.parentCallBack_areChildsSelected,
    required this.parentCallBack_updateProgress,
  })
    : super(id: inhalt.id, name: inhalt.name){
      effect_color = Colors.greenAccent;
  }


  @override
  updateProgress({required bool updateParent}) {
    if(updateParent) parentCallBack_updateProgress(updateParent);
    // Berechne den Fortschritt anhand der richtig beantworteten Fragen

    Set<String> einzigartige = Set();
    for(String frageid in logInhalt.richtigBeantworteteFragen){
      einzigartige.add(frageid.substring(0, frageid.lastIndexOf('_')));
    }
    int richtigbeantwortete = einzigartige.length;

    if(inhalt.getTrueLengthOfFragen() > 0)
      progress = 100 / inhalt.getTrueLengthOfFragen() * richtigbeantwortete;
    else
      progress = 0.0;
    notifyListeners();
  }


  @override
  set isSelected(bool value) {
    Protected_isSelected = value;
    parentCallBack_areChildsSelected(); // Ruft Eltern-Callback auf
    notifyListeners();
  }

  set parentsSelectStatus(bool value) {
    Protected_isSelected = value;
    notifyListeners();
  }

  @override
  set ishovered(bool value) {
    throw UnimplementedError("UsersSubthema ishovered ist noch nicht implementiert.");
  }
}
