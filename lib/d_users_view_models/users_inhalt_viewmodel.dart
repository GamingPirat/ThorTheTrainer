import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_kompetenzbereich_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_inhalt.dart';
import 'package:lernplatform/datenklassen/db_kompetenzbereich.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/globals/print_colors.dart';

class UsersKompetenzbereich extends UsersContentModel {
  final LogKompetenzbereich logKompetenzbereich;
  late final List<UsersInhalt> usersInhalte = [];
  final Function parentCallBack_CheckChilds;
  final Function parentCallBack_updateProgress;

  UsersKompetenzbereich({
    required this.logKompetenzbereich,
    required KompetenzBereich kompetenzbereich,
    required this.parentCallBack_CheckChilds,
    required this.parentCallBack_updateProgress,
  }) : super(id: kompetenzbereich.id, name: kompetenzbereich.name) {
    effect_color = Colors.blueAccent;
    for (Inhalt subThema in kompetenzbereich.inhalte) {
      for (LogInhalt logSubThema in logKompetenzbereich.logInhalte) {
        if (subThema.id == logSubThema.id) {
          usersInhalte.add(
            UsersInhalt(
              logInhalt: logSubThema,
              inhalt: subThema,
              parentCallBack_areChildsSelected: () => checkIfAllChildrenAreSelected(),
              parentCallBack_updateProgress: (bool updateParent) => updateProgress(updateParent: updateParent),
            ),
          );
        }
      }
    }
    print_Yellow("UsersKompetenzbereich created. kompetenzbereich.id = ${kompetenzbereich.id} logKompetenzbereich.id = ${logKompetenzbereich.id}");
  }

  @override
  set isSelected(bool value) {
    Protected_isSelected = value;
    for (var subthema in usersInhalte) {
      subthema.isSelected = value;  // Setze jeden einzelnen subthema.isSelected
    }
    parentCallBack_CheckChilds();  // Callback zum übergeordneten Lernfeld aufrufen
    notifyListeners();
  }


  set parentsSelectStatus(bool value) {
    Protected_isSelected = value;
    for (UsersInhalt subthema in usersInhalte) {
      subthema.parentsSelectStatus = isSelected;
    }
    notifyListeners();
  }

  void checkIfAllChildrenAreSelected() {
    // Prüft, ob alle Subthemen ausgewählt sind
    if (usersInhalte.every((subthema) => subthema.isSelected)) {
      Protected_isSelected = true;
    } else {
      Protected_isSelected = false;
    }
    updateSelectionStatus();
  }

  void updateSelectionStatus() {
    Protected_isSelected = usersInhalte.every((subthema) => subthema.isSelected);
    parentCallBack_CheckChilds(); // ruft Eltern-Callback auf, um den Lernfeld-Status zu prüfen
    notifyListeners();
  }



  @override
  updateProgress({required bool updateParent}) {
    if(updateParent) parentCallBack_updateProgress(updateParent);
    double max_progress = 100.0 * usersInhalte.length; // Korrigiert: max_progress entspricht der Anzahl der Subthemen mal 100
    double current_progress = 0;
    for(UsersInhalt u_subThema in usersInhalte){
      u_subThema.updateProgress(updateParent: false);
      current_progress += u_subThema.progress;
    }
    progress = max_progress > 0 ? (current_progress / max_progress) * 100 : 0.0; // Berechnet den Fortschritt in Prozent
    notifyListeners();
  }
}
