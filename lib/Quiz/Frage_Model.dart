import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Quiz/Antwort_Model.dart';
import '../datenklassen/frage.dart';


class Frage_Model with ChangeNotifier {
  final Frage frage;
  late List<Antwort_Model> antwortenViewModel;

  bool _locked = false;

  Frage_Model({
    required this.frage,
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


  int evaluate() {
    // iteriere durch deine Antworten
    int richtige = 0;
    for (Antwort_Model antwort in antwortenViewModel) {
      if (antwort.evaluate() != null)
        if (antwort.evaluate() == true)
          richtige++;
        else
          richtige--;
    }
    return frage.punkte*richtige~/antwortenViewModel.length; // ~/ == intdivisionOperator
  }


  void unselectAntworten(Antwort_Model model) {
    print("unselectAntworten");
    for (Antwort_Model antwort in antworten) {
      if (antwort != model) {
        antwort.isSelected = false;
      }
    }
    notifyListeners();
  }

  bool isSomthingSelected(){
    bool flag = false;
    for (Antwort_Model antwort in antworten)
      if(antwort.isSelected){
        return true;
      }
    for (Antwort_Model antwort in antworten)
      antwort.blink();
    return false;
  }


  String get titel => frage.text;
  bool get locked => _locked;
  List<Antwort_Model> get antworten => antwortenViewModel;
}
