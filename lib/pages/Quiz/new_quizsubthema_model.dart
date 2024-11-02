import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lernplatform/FrageDBService.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_antwort.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/pages/Quiz/Frage_Model.dart';
import 'package:lernplatform/print_colors.dart';
import 'package:lernplatform/session.dart';

class NewQuizsubthemaModel with ChangeNotifier{

  UsersSubThema selected_subthema;
  late Frage_Model random_question;

  NewQuizsubthemaModel({
    required this.selected_subthema,
    required Function(int) onLockTapped,
  }){
    _load(onLockTapped);
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void _load(Function(int) onLockTapped) async{

    //***************************************************************
    // lade die users_fragen
    //***************************************************************
    FrageDBService dbService = FrageDBService(dateiname: "PV_WISO_Fragen");
    List<DB_Frage> fragen = await dbService.getByThemaID(selected_subthema.id);
    print_Cyan("NewQuizsubthemaModel dbService.fragen.length = ${fragen.length}");


    //***************************************************************
    // wähle random Frage
    //***************************************************************
    try{
      random_question = Frage_Model(
        frage: fragen[Random().nextInt(fragen.length)],
        lockTapped: (int erreichtePunkte)=> onLockTapped(erreichtePunkte),
      );
    } catch (RangeError){       // wenn keine Fragen geladen wurden
      random_question = Frage_Model(
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
        lockTapped: (int erreichtePunkte)=> onLockTapped(erreichtePunkte),
      );
    }
    _isLoading = false;
    notifyListeners();
    print_Cyan("NewQuizsubthemaModel _load beendet");
  }

}