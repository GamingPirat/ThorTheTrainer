// import 'dart:math';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:login/datenbank/frage_und_antwort.dart';
// import 'Antwort_Model.dart';
//
// class Frage_Model with ChangeNotifier {
//   final Frage frage;
//   late List<Antwort_Model> antwortenViewModel;
//
//   bool _locked = false;
//
//   Frage_Model({
//     required this.frage,
//   }) {
//     antwortenViewModel = [];
//     bool isMultipleChoice = _isMultipleChoice(frage.antworten);
//
//     _initializeAntwortenViewModel(frage.antworten, isMultipleChoice);
//
//     antwortenViewModel.shuffle(Random());
//   }
//
//   // Prüft, ob es sich um eine Multiple-Choice-Frage handelt
//   bool _isMultipleChoice(List<Antwort> antworten) {
//     int korrekteAntwortenCount = antworten.where((antwort) => antwort.isKorrekt).length;
//     return korrekteAntwortenCount > 1;
//   }
//
//   // Initialisiert die Liste der Antwort-ViewModels
//   void _initializeAntwortenViewModel(List<Antwort> antworten, bool isMultipleChoice) {
//     for (var antwort in antworten) {
//       antwortenViewModel.add(Antwort_Model(
//         antwort: antwort,
//         unselectAntworten: unselectAntworten,
//         isMultipleChoice: isMultipleChoice,
//       ));
//     }
//   }
//
//   String get titel => frage.text;
//   bool get locked => _locked;
//
//   Map<String, dynamic> evaluate(){
//     Map<String, dynamic> map = {"erreichtePunkte":0, "maxPunkte":0};
//     _locked = true;
//     for (var antwortVM in antwortenViewModel) {
//       map["erreichtePunkte"] += antwortVM.evaluate()["erreichtePunkte"];
//       map["maxPunkte"] += antwortVM.evaluate()["maxPunkte"];
//     }
//     notifyListeners();
//     return {
//       "erreichtePunkte":map["erreichtePunkte"],
//       "answeredCorrect":(map["maxPunkte"] == map["erreichtePunkte"])};
//   }
//
//     List<Antwort_Model> get antworten => antwortenViewModel;
//
//   void unselectAntworten(Antwort_Model model) {
//     print("unselectAntworten");
//     for (Antwort_Model antwort in antworten) {
//       if (antwort != model) {
//         antwort.isSelected = false;
//       }
//     }
//     notifyListeners();
//   }
// }
