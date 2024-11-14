import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';

class UsersSubThema extends UsersContentModel {
  final LogInhalt logSubThema;
  final Inhalt subThema;
  final Function parentCallBack_areChildsSelected;
  final Function parentCallBack_updateProgress;

  UsersSubThema({
    required this.logSubThema,
    required this.subThema,
    required this.parentCallBack_areChildsSelected,
    required this.parentCallBack_updateProgress,
  })
    : super(id: subThema.id, name: subThema.name){
      effect_color = Colors.greenAccent;
      updateProgress(updateParent: false);
  }


  @override
  updateProgress({required bool updateParent}) {
    if(updateParent) parentCallBack_updateProgress(updateParent);
    // Berechne den Fortschritt anhand der richtig beantworteten Fragen
    int richtigbeantwortete = logSubThema.richtigBeantworteteFragen
        .where((frage) => frage.split('_').last == '1')
        .length;

    if(subThema.getTrueLengthOfFragen() > 0)
      progress = 100 / subThema.getTrueLengthOfFragen() * richtigbeantwortete;
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
