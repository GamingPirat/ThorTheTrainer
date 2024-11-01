import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/print_colors.dart';

class QuizSubThema with ChangeNotifier {
  late final List<String> geseheneFragen;
  final UsersSubThema usersSubThema;
  final random = Random();
  bool _isloading = true;
  bool get isloading => _isloading;

  QuizSubThema({required this.usersSubThema}){
      geseheneFragen =[
        ...usersSubThema.logSubThema.richtigBeantworteteFragen,
        ...usersSubThema.logSubThema.falschBeantworteteFragen
      ];
  }

  userHatRichtigGeantwortet(String value){
    usersSubThema.logSubThema.richtigBeantworteteFragen.add(value);
  }
  userHatFalschGeantwortet(String value){
    usersSubThema.logSubThema.falschBeantworteteFragen.add(value);
  }

  DB_Frage getRandomFrage(int counter) {
    print_Magenta("QuizSubThema getRandomFrage(int counter) geseheneFragen.length = ${geseheneFragen.length}");

    // Alle 3 Aufrufe `getRandomFrage` soll eine falsch beantwortete Frage zurückgeben, wenn vorhanden
    if (counter == 3 && usersSubThema.logSubThema.falschBeantworteteFragen.isNotEmpty) {
      return _getFalschbeantworteteFrage();
    }

    // Sucht eine ungesehene Frage
    for (DB_Frage frage in usersSubThema.subThema.fragen) {
      if (!geseheneFragen.contains(frage.id)) {
        return frage;
      }
    }

    // Falls alle Fragen gesehen wurden, gibt eine falsch beantwortete Frage zurück
    return _getFalschbeantworteteFrage();
  }

  DB_Frage _getFalschbeantworteteFrage() {
    if (usersSubThema.logSubThema.falschBeantworteteFragen.isEmpty) {
      // Falls keine falsch beantworteten Fragen mehr verfügbar sind, gib eine zufällige Frage zurück
      print_Magenta("QuizSubThema _getFalschbeantworteteFrage usersSubThema.subThema.fragen.length = ${usersSubThema.subThema.fragen.length}"); // todo print
      return usersSubThema.subThema.fragen[random.nextInt(usersSubThema.subThema.fragen.length)];
    }

    // Durchsucht die falsch beantworteten Fragen nach einer alternativen Version
    for (String falschFrage in usersSubThema.logSubThema.falschBeantworteteFragen) {
      for (DB_Frage frage in usersSubThema.subThema.fragen) {
        if (frage.id.split('_')[1] == falschFrage.split('_')[1] &&
            frage.id.split('_')[2] != falschFrage.split('_')[2]) {
          return frage;
        }
      }
    }

    // Setzt die falsch beantworteten Fragen zurück, falls keine alternative Version gefunden wurde
    usersSubThema.logSubThema.falschBeantworteteFragen.clear();
    geseheneFragen = [...usersSubThema.logSubThema.richtigBeantworteteFragen];

    // Gibt eine zufällige Frage zurück, da keine Alternative verfügbar ist
    return usersSubThema.subThema.fragen[random.nextInt(usersSubThema.subThema.fragen.length)];
  }


}
