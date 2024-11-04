import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/db_thema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';

class UsersThema extends UsersContentModel {
  final LogThema logThema;
  late final List<UsersSubThema> meineSubThemen = [];
  final Function parentCallBack_CheckChilds;
  final Function parentCallBack_updateProgress;

  UsersThema({
    required this.logThema,
    required Thema thema,
    required this.parentCallBack_CheckChilds,
    required this.parentCallBack_updateProgress,
  }) : super(id: thema.id, name: thema.name) {
    effect_color = Colors.blueAccent;
    for (SubThema subThema in thema.subthemen) {
      for (LogSubThema logSubThema in logThema.logSubthemen) {
        if (subThema.id == logSubThema.id) {
          meineSubThemen.add(
            UsersSubThema(
              logSubThema: logSubThema,
              subThema: subThema,
              parentCallBack_areChildsSelected: () => checkIfAllChildrenAreSelected(),
              parentCallBack_updateProgress: (bool updateParent) => updateProgress(updateParent: updateParent),
            ),
          );
        }
      }
    }
  }

  @override
  set isSelected(bool value) {
    Protected_isSelected = value;
    for (var subthema in meineSubThemen) {
      subthema.isSelected = value;  // Setze jeden einzelnen subthema.isSelected
    }
    parentCallBack_CheckChilds();  // Callback zum übergeordneten Lernfeld aufrufen
    notifyListeners();
  }


  set parentsSelectStatus(bool value) {
    Protected_isSelected = value;
    for (UsersSubThema subthema in meineSubThemen) {
      subthema.parentsSelectStatus = isSelected;
    }
    notifyListeners();
  }

  void checkIfAllChildrenAreSelected() {
    // Prüft, ob alle Subthemen ausgewählt sind
    if (meineSubThemen.every((subthema) => subthema.isSelected)) {
      Protected_isSelected = true;
    } else {
      Protected_isSelected = false;
    }
    updateSelectionStatus();
  }

  void updateSelectionStatus() {
    Protected_isSelected = meineSubThemen.every((subthema) => subthema.isSelected);
    parentCallBack_CheckChilds(); // ruft Eltern-Callback auf, um den Lernfeld-Status zu prüfen
    notifyListeners();
  }



  @override
  updateProgress({required bool updateParent}) {
    if(updateParent) parentCallBack_updateProgress(updateParent);
    double max_progress = 100.0 * meineSubThemen.length; // Korrigiert: max_progress entspricht der Anzahl der Subthemen mal 100
    double current_progress = 0;
    for(UsersSubThema u_subThema in meineSubThemen){
      u_subThema.updateProgress(updateParent: false);
      current_progress += u_subThema.progress;
    }
    progress = max_progress > 0 ? (current_progress / max_progress) * 100 : 0.0; // Berechnet den Fortschritt in Prozent
    notifyListeners();
  }
}
