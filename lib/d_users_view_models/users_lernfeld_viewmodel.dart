import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_kompetenzbereich_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_inhalt_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/db_kompetenzbereich.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/globals/print_colors.dart';

class UsersLernfeld extends UsersContentModel {
  final LogLernfeld logLernfeld;
  late final List<UsersKompetenzbereich> usersKompetenzbereiche = [];


  UsersLernfeld({
    required this.logLernfeld,
    required Lernfeld lernfeld,
  })
      : super(id: lernfeld.id, name: lernfeld.name) {
    effect_color = Colors.purpleAccent;
    for (KompetenzBereich kompetenzbereich in lernfeld.kompetenzbereiche) {
      for (LogKompetenzbereich logKompetenzbereich in logLernfeld.logKompetenzbereiche) {
        if (kompetenzbereich.id == logKompetenzbereich.id) {
          usersKompetenzbereiche.add(
            UsersKompetenzbereich(
              logKompetenzbereich: logKompetenzbereich,
              kompetenzbereich: kompetenzbereich,
              parentCallBack_CheckChilds: () => checkIfAllChildrenAreSelected(),
              parentCallBack_updateProgress: (bool updateParent) => updateProgress(updateParent: updateParent),
            ),
          );
        }
      }
    }
    print_Yellow("UsersLernfeld created. lernfeld.id = ${lernfeld.id} loglernfeld.id = ${logLernfeld.id}");
  }

  @override
  set isSelected(bool value) {
    Protected_isSelected = value;
    // print_Yellow("UsersLernfeld isSelected = ${isSelected}"); // todo print
    for (var thema in usersKompetenzbereiche) {
      thema.isSelected = value;  // Setze jeden einzelnen thema.isSelected
    }
    notifyListeners();
  }


  void checkIfAllChildrenAreSelected() {
    // Prüft, ob alle Themen ausgewählt sind
    if (usersKompetenzbereiche.every((thema) => thema.isSelected)) {
      Protected_isSelected = true;
    } else {
      Protected_isSelected = false;
    }
    updateSelectionStatus();
  }

  void updateSelectionStatus() {
    Protected_isSelected = usersKompetenzbereiche.every((thema) => thema.isSelected);
    notifyListeners();
  }


  @override
  updateProgress({required bool updateParent}) {
    double max_progress = 100.0 * usersKompetenzbereiche.length;
    double current_progress = 0;
    for(UsersKompetenzbereich u_Thema in usersKompetenzbereiche){
      u_Thema.updateProgress(updateParent: false);
      current_progress += u_Thema.progress;
    }
    progress = max_progress > 0 ? (current_progress / max_progress) * 100 : 0.0;
    notifyListeners();
  }
}
