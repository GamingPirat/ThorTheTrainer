import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/FrageDBService.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_antwort.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/pages/Quiz/quiz_frage_model.dart';
import 'package:lernplatform/print_colors.dart';

class NewQuizsubthemaModel with ChangeNotifier{

  UsersSubThema selected_subthema;
  late QuizFrageModel random_question;

  NewQuizsubthemaModel({
    required this.selected_subthema,
    required Function() onLockTapped,
  }){
    _load(onLockTapped);
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void _load(Function() onLockTapped) async{
    //
    // //***************************************************************
    // // lade die users_fragen
    // //***************************************************************
    // FrageDBService dbService = FrageDBService(datei_name: "PV_WISO_Fragen");
    // selected_subthema.subThema.fragen = await dbService.getByThemaID(selected_subthema.id);
    // print_Cyan("NewQuizsubthemaModel selected_subthema.subThema.fragen.length = ${selected_subthema.subThema.fragen.length}");// todo print


    //***************************************************************
    // wähle random Frage
    //***************************************************************
    try{
      random_question = QuizFrageModel(
        frage: selected_subthema.subThema.fragen[Random().nextInt(selected_subthema.subThema.fragen.length)],
        lockTapped: ()=> onLockTapped(),
      );
    } catch (RangeError){       // wenn keine Fragen geladen wurden
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
        lockTapped: () => onLockTapped(),
      );
    }
    _isLoading = false;
    notifyListeners();
    print_Cyan("NewQuizsubthemaModel _load beendet");
  }


}