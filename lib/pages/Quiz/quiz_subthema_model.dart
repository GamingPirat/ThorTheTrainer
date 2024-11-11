import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_antwort.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/pages/Quiz/quiz_frage_model.dart';

class NewQuizsubthemaModel with ChangeNotifier{

  UsersSubThema selected_subthema;
  Function() onLockTapped;
  late QuizFrageModel random_question;
  late List<DB_Frage> _ungesehene_fragen;
  Random rnd = Random();

  NewQuizsubthemaModel({
    required this.selected_subthema,
    required this.onLockTapped,
    required int runde,
  }){
    _update_ungesehene_fragen();
    _get_randomQuestion(runde);
  }

  void _get_randomQuestion(int runde) {
    try {
      if(runde == 3)
        random_question = _falschbeantwortete_frage_in_neuer_version;
      else
        random_question = _random_ungesehene_frage;
    }
    catch (RangeError){       // wenn keine Fragen geladen wurden
      random_question = QuizFrageModel(
        frage: DB_Frage(
            nummer: 9999,
            version: 9999,
            themaID: 9999,
            punkte: 0,
            text: "keine Fragen vorhanden",
            antworten: [
              Antwort(text: 'weiter', erklaerung: '', isKorrekt: true),
            ]
        ),
        onLockTapped: () => onLockTapped(),
      );
    }
    notifyListeners();
    // print_Cyan("NewQuizsubthemaModel _load beendet"); // todo print
  }

  QuizFrageModel get _falschbeantwortete_frage_in_neuer_version{
    List<DB_Frage> ungesehene_fragen = _ungesehene_fragen;
    List<String> falsch_beantwortete_fragen_shuffled = selected_subthema.logSubThema.falschBeantworteteFragen;
    falsch_beantwortete_fragen_shuffled.shuffle();

    // *********************************************************************************
    // wenn die frage.nummer die Selbe ist aber eine andere frage.version verfügbar ist
    // *********************************************************************************
    for (String falsch_beantwortete_frage in falsch_beantwortete_fragen_shuffled) {
      for(DB_Frage db_frage in ungesehene_fragen){
        if(db_frage.id.split("_")[1] == falsch_beantwortete_frage.split("_")[1]
        && ! (db_frage.id.split("_")[2] == falsch_beantwortete_frage.split("_")[2]))
          return QuizFrageModel(frage: db_frage, onLockTapped: ()=> onLockTapped());
      }
    }

    // *********************************************************************************
    // returniere Frage die der User schonmal gesehen hat.
    // *********************************************************************************
    return _random_falschbeantwortete_frage;
  }


  QuizFrageModel get _random_falschbeantwortete_frage {
    List<String> falsch_beantwortete_fragen = selected_subthema.logSubThema.falschBeantworteteFragen;
    falsch_beantwortete_fragen.shuffle();

    List<DB_Frage> matching_fragen = _ungesehene_fragen.where((frage) =>
        falsch_beantwortete_fragen.contains(frage.id)).toList();

    if (matching_fragen.isNotEmpty) {
      return QuizFrageModel(
          frage: matching_fragen[rnd.nextInt(matching_fragen.length)],
          onLockTapped: ()=> onLockTapped());
    }
    // *********************************************************************************
    // Falls keine passende Frage gefunden wurde, wähle eine zufällige ungesehene Frage
    // *********************************************************************************
    return _random_ungesehene_frage;
  }


  QuizFrageModel get _random_ungesehene_frage {
    return QuizFrageModel(
        frage: _ungesehene_fragen[rnd.nextInt(_ungesehene_fragen.length)],
        onLockTapped: ()=> onLockTapped());
  }


  void _update_ungesehene_fragen() {
    _ungesehene_fragen = [];
    List<String> gesehene_logfragen = [
      ...selected_subthema.logSubThema.richtigBeantworteteFragen,
      ...selected_subthema.logSubThema.falschBeantworteteFragen
    ];
    for (DB_Frage db_frage in selected_subthema.subThema.fragen) {
      // Vergleiche die Frage-ID mit den gesehenen Fragen
      if (!gesehene_logfragen.contains(db_frage.id)) {
        _ungesehene_fragen.add(db_frage);
      }
    }
  }
}