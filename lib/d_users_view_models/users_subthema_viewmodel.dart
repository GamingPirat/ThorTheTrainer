import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';

class UsersSubThema extends UsersContentModel {
  final LogSubThema logSubThema;
  final SubThema subThema;
  final Function parentCallBack_CheckChilds;

  UsersSubThema({
    required this.logSubThema,
    required this.subThema,
    required this.parentCallBack_CheckChilds,
  })
    : super(id: subThema.id, name: subThema.name){
      effect_color = Colors.greenAccent;
  }

  @override
  double get progress {
    // Berechne den Fortschritt anhand der richtig beantworteten Fragen
    int richtigbeantwortete = logSubThema.richtigBeantworteteFragen
        .where((frage) => frage.split('_').last == '1')
        .length;
    double progress = richtigbeantwortete / subThema.getTrueLengthOfFragen();
    return progress.clamp(0.0, 1.0);
  }

  @override
  set isSelected(bool value) {
    Protected_isSelected = value;
    parentCallBack_CheckChilds(); // Ruft Eltern-Callback auf
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
