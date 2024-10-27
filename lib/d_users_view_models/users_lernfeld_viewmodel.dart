import 'package:lernplatform/d_users_view_models/abstract_users_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/db_thema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';

class UsersLernfeld extends UsersViewModel {
  final LogLernfeld logLernfeld;
  late final List<UsersThema> usersThemen = [];

  UsersLernfeld({required this.logLernfeld, required Lernfeld_DB lernfeld})
      : super(id: lernfeld.id, name: lernfeld.name) {
    for (Thema thema in lernfeld.themen) {
      for (LogThema logThema in logLernfeld.meineThemen) {
        if (thema.id == logThema.id) {
          usersThemen.add(
            UsersThema(
              logThema: logThema,
              thema: thema,
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
  double get progress {
    double erreichteZahl = usersThemen.fold(0.0, (sum, thema) => sum + thema.progress);
    return erreichteZahl.clamp(0.0, 1.0);
  }
}
