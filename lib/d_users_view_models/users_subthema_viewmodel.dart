import 'package:flutter/material.dart';
import 'package:lernplatform/FrageDBService.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/pages/Quiz/Frage_Model.dart';
import 'package:lernplatform/session.dart';

class UsersSubThema extends UsersContentModel {
  final LogSubThema logSubThema;
  final SubThema subThema;
  final Function parentCallBack_CheckChilds;
  late List<Frage_Model> users_fragen;

  UsersSubThema({
    required this.logSubThema,
    required this.subThema,
    required this.parentCallBack_CheckChilds,
  })
    : super(id: subThema.id, name: subThema.name){
      effect_color = Colors.greenAccent;
      _load();
  }

  void _load() async{
    //***************************************************************
    // wisse in welcher Firestore Sammlung du liegst
    //***************************************************************
    late String wo_bin_ich_gespeichert;
    for (UsersLernfeld lernfeld in Session().user.usersLernfelder)
      for (UsersThema thema in lernfeld.usersThemen)
        for (UsersSubThema subThema in thema.meineSubThemen)
          if (subThema.id == this.subThema.id)
            wo_bin_ich_gespeichert = lernfeld.name;
    wo_bin_ich_gespeichert = wo_bin_ich_gespeichert ?? "Datei nicht vorhanden";

    //***************************************************************
    // lade die users_fragen
    //***************************************************************
    FrageDBService dbService = FrageDBService(dateiname: wo_bin_ich_gespeichert);
    users_fragen = [];
    List<DB_Frage> fragen = await dbService.getByThemaID(subThema.id);
    for(DB_Frage frage in fragen)
      users_fragen.add(Frage_Model(frage: frage, lockTapped: (){}));
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
