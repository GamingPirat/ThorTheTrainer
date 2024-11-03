import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/pages/Quiz/quiz_frage_model.dart';
import 'package:lernplatform/print_colors.dart';

class UsersSubThema extends UsersContentModel {
  final LogSubThema logSubThema;
  final SubThema subThema;
  final Function parentCallBack_CheckChilds;
  late List<QuizFrageModel> users_fragen;

  UsersSubThema({
    required this.logSubThema,
    required this.subThema,
    required this.parentCallBack_CheckChilds,
  })
    : super(id: subThema.id, name: subThema.name){
      effect_color = Colors.greenAccent;
      updateProgress();
  }


  @override
  updateProgress() {
    print_Green("logsubThema");
    print_Green("richtigBeantworteteFragen ${logSubThema.richtigBeantworteteFragen.length}");
    print_Green("falschBeantworteteFragen ${logSubThema.falschBeantworteteFragen.length}");
    if(logSubThema.richtigBeantworteteFragen.length > 0){
      print_Green("richtigBeantworteteFragen[0] ${logSubThema.richtigBeantworteteFragen[0]}");
      print_Green("richtigBeantworteteFragen[0].split('_') ${logSubThema.richtigBeantworteteFragen[0].split('_').last}");
    }


    // Berechne den Fortschritt anhand der richtig beantworteten Fragen
    int richtigbeantwortete = logSubThema.richtigBeantworteteFragen
        .where((frage) => frage.split('_').last == '1')
        .length;

    print_Green("subThema.getTrueLengthOfFragen() ${subThema.getTrueLengthOfFragen()}");

    if(subThema.getTrueLengthOfFragen() > 0)
      progress = 100 / subThema.getTrueLengthOfFragen() * richtigbeantwortete;
    else
      progress = 0.0;
    notifyListeners();
    print_Green("UsersSubThema updateProgress = $progress");
    print_Green("logsubThema new Values Are");
    print_Green("richtigBeantworteteFragen${logSubThema.richtigBeantworteteFragen.length}");
    print_Green("falschBeantworteteFragen ${logSubThema.falschBeantworteteFragen.length}");
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
