import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/db_antwort.dart';

import '../Quiz/Antwort_Model.dart';
import '../datenklassen/db_frage.dart';


class Frage_Model with ChangeNotifier {
  final DB_Frage frage;
  final Function lockTapped;
  late List<Antwort_Model> antwortenViewModel;

  bool _locked = false;

  Frage_Model({
    required this.frage,
    required this.lockTapped,
  }) {
    antwortenViewModel = [];
    bool isMultipleChoice = _isMultipleChoice(frage.antworten);
    _initializeAntwortenViewModel(frage.antworten, isMultipleChoice);
    antwortenViewModel.shuffle(Random());
  }

  // Prüft, ob es sich um eine Multiple-Choice-Frage handelt
  bool _isMultipleChoice(List<Antwort> antworten) {
    int korrekteAntwortenCount = antworten.where((antwort) => antwort.isKorrekt).length;
    return korrekteAntwortenCount > 1;
  }

  // Initialisiert die Liste der Antwort-ViewModels
  void _initializeAntwortenViewModel(List<Antwort> antworten, bool isMultipleChoice) {
    for (var antwort in antworten) {
      antwortenViewModel.add(Antwort_Model(
        antwort: antwort,
        unselectAntworten: unselectAntworten,
        isMultipleChoice: isMultipleChoice,
      ));
    }
  }


  void evaluate() {
    if(isSomthingSelected()){
      double punkte = 0;
      int richtigeAntworten = 0;

      for (Antwort_Model antwort in antwortenViewModel)
        if (antwort.antwort.isKorrekt) richtigeAntworten++;

      double antwortwert = frage.punkte / richtigeAntworten;

      for (Antwort_Model antwort in antwortenViewModel)
        punkte += antwort.evaluate(antwortwert);

      print("${frage.punkte} $punkte $antwortwert");

      _locked = true;
      notifyListeners();

      lockTapped(punkte.ceil());

      // sag der Session.PunkteStand, den neuen Punktestand
      // aktualisiere das Fortscchritt Widget
    }

  }




  void unselectAntworten(Antwort_Model model) {
    for (Antwort_Model antwort in antworten) {
      if (antwort != model) {
        antwort.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool isSomthingSelected(){
    for (Antwort_Model antwort in antworten)
      if(antwort.isSelected)
        return true;

    for (Antwort_Model antwort in antworten)
      antwort.blink();
    return false;
  }


  String get titel => frage.text;
  bool get locked => _locked;
  List<Antwort_Model> get antworten => antwortenViewModel;
}
