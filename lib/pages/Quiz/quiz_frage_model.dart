import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/db_antwort.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'quiz_antwort_model.dart';

class QuizFrageController with ChangeNotifier {
  final DB_Frage frage;
  final Function() onLockTapped;
  late List<QuizAntwortModel> antwortenViewModel;
  late String imagePath;

  bool _locked = false;

  QuizFrageController({
    required this.frage,
    required this.onLockTapped,
  }) {
    antwortenViewModel = [];
    bool isMultipleChoice = _isMultipleChoice(frage.antworten);
    _initializeAntwortenViewModel(frage.antworten, isMultipleChoice);
    antwortenViewModel.shuffle(Random());
    List<String> imagePaths = [
      "assets/characters/emotionslos.webp",
      "assets/characters/humorvoll_sarkastisch.webp",
      "assets/characters/kumpel.webp",
      "assets/characters/philosoph.webp",
      "assets/characters/professional.webp",
      "assets/characters/provokant.webp",
      "assets/characters/technisch.webp",
      "assets/characters/vereinfachte_sprache.webp",
    ];
    imagePath = imagePaths[Random().nextInt(imagePaths.length)];
  }

  // Prüft, ob es sich um eine Multiple-Choice-Frage handelt
  bool _isMultipleChoice(List<Antwort> antworten) {
    int korrekteAntwortenCount = antworten.where((antwort) => antwort.isKorrekt).length;
    return korrekteAntwortenCount > 1;
  }


  // Initialisiert die Liste der Antwort-ViewModels
  void _initializeAntwortenViewModel(List<Antwort> antworten, bool isMultipleChoice) {
    for (var antwort in antworten) {
      antwortenViewModel.add(QuizAntwortModel(
        antwort: antwort,
        unselectAntworten: unselectAntworten,
        isMultipleChoice: isMultipleChoice,
      ));
    }
  }

  void unselectAntworten(QuizAntwortModel model) {
    for (QuizAntwortModel antwort in antworten) {
      if (antwort != model) {
        antwort.isSelected = false;
      }
    }
    notifyListeners();
  }

  void blink(){
    for(QuizAntwortModel antwort_model in antwortenViewModel)
      antwort_model.blink();
  }

  bool get somethingIsSelected {
    for (QuizAntwortModel antwort in antworten)
      if(antwort.isSelected)
        return true;

    for (QuizAntwortModel antwort in antworten)
      antwort.blink();
    return false;
  }
  int get erreichtePunkte_after_LockTapped {
    int max_richtige_antworten = 0;
    int richtige_antworten = 0;
    for (QuizAntwortModel antwort in antwortenViewModel) {
      antwort.evaluate();
      if (antwort.antwort.isKorrekt){
        max_richtige_antworten++;
        if(antwort.isSelected)
          richtige_antworten++;
      }
    }
    double richtige_antworten_wert = frage.punkte / max_richtige_antworten;
    int erreichte_punkte = (richtige_antworten * richtige_antworten_wert).ceilToDouble().toInt();
    // print_Magenta("QuizFrageModel erreichtePunkte_after_LockTapped $erreichte_punkte Frage.punkte = ${frage.punkte}"); // todo print
    _locked = true;
    notifyListeners();
    return erreichte_punkte;
  }
  String get titel => frage.text;
  bool get locked => _locked;
  List<QuizAntwortModel> get antworten => antwortenViewModel;
}
