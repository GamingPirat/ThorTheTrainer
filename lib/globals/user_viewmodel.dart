import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_kompetenzbereich_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_inhalt_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_key.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/globals/lokal_storage_verwalter.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/pages/Startseiten/enter_service.dart';
import '../datenklassen/log_teilnehmer.dart';



class UserModel with ChangeNotifier {

  AlphaKey alpha_key;
  late LogTeilnehmer logTeilnehmer;
  List<UsersLernfeld> lernfelder = [];
  List<Lernfeld> firestoreLernfelder = [];
  bool _isLoading = true;

  UserModel({required this.alpha_key}) {
    // print("UserModel: AlphaKey empfangen: $alpha_key");
    _load();
  }

  get isLoading => _isLoading;
  // todo später wenn Teilnehmer nur begrenzte Lernfelder haben muss die firstore Abfrage konkreter werden. Sprich ich muss was mit der Datenbank machen das Teilnehmer.key x nur zugriff auf x hat

  Future<void> _load() async {
    try {
      // Lade alle Lernfeld-Dokumente aus der gesamten Sammlung
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection("Lernfelder")
          .get();

      // Überprüfe, ob Dokumente vorhanden sind
      if (snapshot.docs.isNotEmpty) {
        // Gehe alle Dokumente durch und füge sie zur Liste hinzu
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          Lernfeld lernfeld = Lernfeld.fromJson(data);
          firestoreLernfelder.add(lernfeld);
        }
        // print_Cyan("snapshot data: ${firestoreLernfelder.map((lf) => lf.name).toList()}");
      } else {
        // print_Red('UserModel Keine Dokumente in der Sammlung vorhanden');
      }
    } catch (e) {
      print_Red('UserModel hat Fehler beim Laden der Daten: $e');  // Fehlerbehandlung, falls etwas schiefgeht
    }

    // Initialisiere den Teilnehmer basierend auf den geladenen Daten
    logTeilnehmer = await ladeOderErzeugeTeilnehmer(firestoreLernfelder);

    // Fülle die lernfelder-Liste mit UsersLernfeld-Instanzen, wenn IDs übereinstimmen
    for (LogLernfeld logLernfeld in logTeilnehmer.logLernfelder) {
      for (Lernfeld lernfeld in firestoreLernfelder) {
        if (logLernfeld.id == lernfeld.id) {
          lernfelder.add(UsersLernfeld(
            logLernfeld: logLernfeld,
            lernfeld: lernfeld,
          ));
          // print_Cyan("UserModel _load() Geladenes Lernfeld: ${lernfeld.name}, Kompetenzbereiche: ${lernfeld.kompetenzbereiche.length}");
        }
      }
    }



    _isLoading = false;
    notifyListeners();
  }



  void speichern(){
    speichereTeilnehmer(logTeilnehmer);
  }

  void fortschritt_loeschen(){
    reseteTeilnehmer();
  }

  bool get childIsSelected {
    // print_Cyan("UserModel got called: childIsSelected"); // todo print
    for (UsersLernfeld lernfeld in lernfelder) {
      if (lernfeld.isSelected) {
        return true;
      }
      for (UsersKompetenzbereich thema in lernfeld.usersKompetenzbereiche) {
        if (thema.isSelected) {
          return true;
        }
        for (UsersInhalt subthema in thema.usersInhalte) {
          if (subthema.isSelected) {
            return true;
          }
        }
      }
    }
    _glowUp();
    return false;
  }

  void _glowUp() async{
    for (UsersLernfeld lernfeld in lernfelder) {
      lernfeld.glowColor = Colors.red;
      for (UsersKompetenzbereich thema in lernfeld.usersKompetenzbereiche) {
        thema.glowColor = Colors.red;
        for (UsersInhalt subthema in thema.usersInhalte) {
          subthema.glowColor = Colors.red;
        }
      }
    }
    // 3 Sekunden warten
    await Future.delayed(Duration(seconds: 1));
    for (UsersLernfeld lernfeld in lernfelder) {
      lernfeld.glowColor = Colors.transparent;
      for (UsersKompetenzbereich thema in lernfeld.usersKompetenzbereiche) {
        thema.glowColor = Colors.transparent;
        for (UsersInhalt subthema in thema.usersInhalte) {
          subthema.glowColor = Colors.transparent;
        }
      }
    }
  }
}