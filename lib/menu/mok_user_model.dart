import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/mokdaten.dart';
import '../datenklassen/log_teilnehmer.dart';



class UserModel with ChangeNotifier {

  late Teilnehmer teilnehmer;
  List<Lernfeld> usersLernfelder = [];
  bool _isLoading = true;

  UserModel(){_load;}

  get isLoading => _isLoading;

  Future<void>_load() async {
    _isLoading = true; notifyListeners();
    teilnehmer = await ladeOderErzeugeTeilnehmer();
    for(LogLernfeld logLernfeld in teilnehmer.meineLernfelder)
      for(Lernfeld lernfeld in mok_lernfelder)
        if(logLernfeld.id == lernfeld.id)
          usersLernfelder.add(lernfeld);
    _isLoading = false; notifyListeners();
  }


  Future<void>speichern() async {
    speichereTeilnehmer(teilnehmer);
  }
}