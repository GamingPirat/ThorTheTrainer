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

  UsersThema({
    required this.logThema,
    required Thema thema,
    required this.parentCallBack_CheckChilds,
  }) : super(id: thema.id, name: thema.name) {
    effect_color = Colors.blueAccent;
    for (SubThema subThema in thema.subthemen) {
      for (LogSubThema logSubThema in logThema.logSubthemen) {
        if (subThema.id == logSubThema.id) {
          meineSubThemen.add(
            UsersSubThema(
              logSubThema: logSubThema,
              subThema: subThema,
              parentCallBack_CheckChilds: () => checkIfAllChildrenAreSelected(),
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
  double get progress {
    double erreichteZahl = meineSubThemen.fold(0.0, (sum, subThema) => sum + subThema.progress);
    return erreichteZahl.clamp(0.0, 1.0);
  }
}
