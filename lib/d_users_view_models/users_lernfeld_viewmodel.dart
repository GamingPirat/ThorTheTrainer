import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/db_kompetenzbereich.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/globals/print_colors.dart';

class UsersLernfeld extends UsersContentModel {
  final LogLernfeld logLernfeld;
  late final List<UsersThema> usersThemen = [];


  UsersLernfeld({
    required this.logLernfeld,
    required Lernfeld lernfeld,
  })
      : super(id: lernfeld.id, name: lernfeld.name) {
    effect_color = Colors.purpleAccent;
    for (KompetenzBereich thema in lernfeld.kompetenzbereiche) {
      for (LogKompetenzbereich logThema in logLernfeld.meineThemen) {
        if (thema.id == logThema.id) {
          usersThemen.add(
            UsersThema(
              logThema: logThema,
              thema: thema,
              parentCallBack_CheckChilds: () => checkIfAllChildrenAreSelected(),
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
    // print_Yellow("UsersLernfeld isSelected = ${isSelected}"); // todo print
    for (var thema in usersThemen) {
      thema.isSelected = value;  // Setze jeden einzelnen thema.isSelected
    }
    notifyListeners();
  }


  void checkIfAllChildrenAreSelected() {
    // Prüft, ob alle Themen ausgewählt sind
    if (usersThemen.every((thema) => thema.isSelected)) {
      Protected_isSelected = true;
    } else {
      Protected_isSelected = false;
    }
    updateSelectionStatus();
  }

  void updateSelectionStatus() {
    Protected_isSelected = usersThemen.every((thema) => thema.isSelected);
    notifyListeners();
  }


  @override
  updateProgress({required bool updateParent}) {
    double max_progress = 100.0 * usersThemen.length;
    double current_progress = 0;
    for(UsersThema u_Thema in usersThemen){
      u_Thema.updateProgress(updateParent: false);
      current_progress += u_Thema.progress;
    }
    progress = max_progress > 0 ? (current_progress / max_progress) * 100 : 0.0;
    notifyListeners();
  }
}
