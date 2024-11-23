import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_kompetenzbereich_viewmodel.dart';
import 'package:lernplatform/datenklassen/a_db_service_fragen.dart';
import 'package:lernplatform/datenklassen/db_antwort.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/pages/Quiz/quiz_frage_model.dart';

class QuizInhaltController with ChangeNotifier{

  UsersInhalt selected_inhalt;
  Function() onLockTapped;
  late QuizFrageController random_question;
  late List<DB_Frage> _ungesehene_fragen;
  bool isLoading = true;
  Random rnd = Random();

  QuizInhaltController({
    required this.selected_inhalt,
    required this.onLockTapped,
    required int runde,
  }){
    _load(runde);
  }

  void _load(int runde) async{
    if (selected_inhalt.inhalt.fragen!.length == 0);
      selected_inhalt.inhalt.fragen =
         await FrageDBService().getByInhaltID(selected_inhalt.inhalt.id);

      _update_ungesehene_fragen();
      _get_randomQuestion(runde);
      print_Blue("${random_question.frage}");
      isLoading = false;
      notifyListeners();
  }

  void _get_randomQuestion(int runde) {
    try {
      if(runde == 3)
        random_question = _falschbeantwortete_frage_in_neuer_version;
      else
        random_question = _random_ungesehene_frage;
    }
    catch (RangeError){       // wenn keine Fragen geladen wurden
      random_question = QuizFrageController(
        frage: DB_Frage(
            nummer: 9999,
            version: 9999,
            inhalt_id: 9999,
            punkte: 0,
            text: "Ach! Jetzt ist's mir wieder eingefallen. Hat sich erledigt",
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

  QuizFrageController get _falschbeantwortete_frage_in_neuer_version{
    List<String> falsch_beantwortete_fragen_shuffled = selected_inhalt.logInhalt.falschBeantworteteFragen;
    falsch_beantwortete_fragen_shuffled.shuffle();

    // *********************************************************************************
    // wenn die frage.nummer die Selbe ist aber eine andere frage.version verfügbar ist
    // *********************************************************************************
    for (String falsch_beantwortete_frage in falsch_beantwortete_fragen_shuffled) {
      for(DB_Frage db_frage in _ungesehene_fragen){
        if(db_frage.id.split("_")[1] == falsch_beantwortete_frage.split("_")[1]
        && ! (db_frage.id.split("_")[2] == falsch_beantwortete_frage.split("_")[2]))
          return QuizFrageController(frage: db_frage, onLockTapped: ()=> onLockTapped());
      }
    }

    // *********************************************************************************
    // returniere Frage die der User schonmal gesehen hat.
    // *********************************************************************************
    return _random_falschbeantwortete_frage;
  }


  QuizFrageController get _random_falschbeantwortete_frage {
    List<String> falsch_beantwortete_fragen = selected_inhalt.logInhalt.falschBeantworteteFragen;
    falsch_beantwortete_fragen.shuffle();

    List<DB_Frage> matching_fragen = _ungesehene_fragen.where((frage) =>
        falsch_beantwortete_fragen.contains(frage.id)).toList();

    if (matching_fragen.isNotEmpty) {
      return QuizFrageController(
          frage: matching_fragen[rnd.nextInt(matching_fragen.length)],
          onLockTapped: ()=> onLockTapped());
    }
    // *********************************************************************************
    // Falls keine passende Frage gefunden wurde, wähle eine zufällige ungesehene Frage
    // *********************************************************************************
    return _random_ungesehene_frage;
  }


  QuizFrageController get _random_ungesehene_frage {
    return QuizFrageController(
        frage: _ungesehene_fragen[rnd.nextInt(_ungesehene_fragen.length)],
        onLockTapped: ()=> onLockTapped());
  }


  void _update_ungesehene_fragen() {

    print_Red("_update_ungesehene_fragen");
    _ungesehene_fragen = [];
    List<String> gesehene_logfragen = [
      ...selected_inhalt.logInhalt.richtigBeantworteteFragen,
      ...selected_inhalt.logInhalt.falschBeantworteteFragen
    ];
    for (DB_Frage db_frage in selected_inhalt.inhalt.fragen!) {
      // Vergleiche die Frage-ID mit den gesehenen Fragen
      if (!gesehene_logfragen.contains(db_frage.id)) {
        _ungesehene_fragen.add(db_frage);
      }
    }
    print_Blue("gesehene Fragen : $gesehene_logfragen");
    print_Blue("_ungesehene_fragen : $_ungesehene_fragen");
  }
}