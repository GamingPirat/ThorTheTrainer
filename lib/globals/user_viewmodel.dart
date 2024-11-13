import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
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
  List<Lernfeld_DB> firestoreLernfelder = [];
  bool _isLoading = true;

  UserModel({required this.alpha_key}) {_load();}

  get isLoading => _isLoading;
  // todo später wenn Teilnehmer nur begrenzte Lernfelder haben muss die firstore Abfrage konkreter werden. Sprich ich muss was mit der Datenbank machen das Teilnehmer.key x nur zugriff auf x hat

  Future<void> _load() async {

  for(String fireLernfeld in alpha_key.lernfelder){
    try {
      // Lade das EINZIGE Lernfeld-Dokument aus der gesamten Sammlung
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection(fireLernfeld)
          .get();

      // Überprüfe, ob überhaupt Dokumente vorhanden sind
      if (snapshot.docs.isNotEmpty) {
        // Nehme das erste Dokument aus der Sammlung
        DocumentSnapshot<Map<String, dynamic>> doc = snapshot.docs.first;
        Map<String, dynamic> data = doc.data()!;

        // Konvertiere das Dokument direkt in ein Lernfeld-Objekt
        Lernfeld_DB lernfeld = Lernfeld_DB.fromJson(data);

        firestoreLernfelder.add(lernfeld);  // Füge das Lernfeld zur Liste hinzu
      } else {
        print_Red('UserModel Keine Dokumente in der Sammlung vorhanden');
      }

      print_Green("UserModel _load()  Lernfelder erfolgreich konvertiert."); // todo print
    } catch (e) {
      print_Red('UserModel hat Fehler beim Laden der Daten: $e');  // Fehlerbehandlung, falls etwas schiefgeht
    }

    // Initialisiere den Teilnehmer basierend auf den geladenen Daten
    logTeilnehmer = await ladeOderErzeugeTeilnehmer(firestoreLernfelder);  // Teilnehmer wird jetzt korrekt initialisiert
    print_Green("UserModel _load() UserModel teilnehmer geladen. $logTeilnehmer"); // todo print


    // Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers
    for (LogLernfeld logLernfeld in logTeilnehmer.meineLernfelder) {
      for (Lernfeld_DB lernfeld in firestoreLernfelder) {
        print_Green("UserModel _load() Vergleiche: logLernfeld.id = ${logLernfeld.id}, lernfeld.id = ${lernfeld.id}"); // todo print
        if (logLernfeld.id == lernfeld.id) {
          lernfelder.add(UsersLernfeld(
            logLernfeld: logLernfeld,
            lernfeld: lernfeld,
          ));
          print_Green("UserModel _load() Geladenes Lernfeld: ${lernfeld.name}, Themen: ${lernfeld.themen.length}"); // todo print
        }
      }
    }
  }

  if(alpha_key.lernfelder.length == 0){
    alpha_key.lernfelder = await fire_all_lernfelder();
    _load();
  }


    print_Green("Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers abgeschlossen"); // todo print
    _isLoading = false;
    notifyListeners();
  }

  void speichern(){
    speichereTeilnehmer(logTeilnehmer);
  }

  void fortschritt_loeschen(){
    loescheTeilnehmer();
  }

  bool get childIsSelected {
    // print_Yellow("UserModel got called: childIsSelected"); // todo print
    for (UsersLernfeld lernfeld in lernfelder) {
      if (lernfeld.isSelected) {
        return true;
      }
      for (UsersThema thema in lernfeld.usersThemen) {
        if (thema.isSelected) {
          return true;
        }
        for (UsersSubThema subthema in thema.meineSubThemen) {
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
      for (UsersThema thema in lernfeld.usersThemen) {
        thema.glowColor = Colors.red;
        for (UsersSubThema subthema in thema.meineSubThemen) {
          subthema.glowColor = Colors.red;
        }
      }
    }
    // 3 Sekunden warten
    await Future.delayed(Duration(seconds: 1));
    for (UsersLernfeld lernfeld in lernfelder) {
      lernfeld.glowColor = Colors.transparent;
      for (UsersThema thema in lernfeld.usersThemen) {
        thema.glowColor = Colors.transparent;
        for (UsersSubThema subthema in thema.meineSubThemen) {
          subthema.glowColor = Colors.transparent;
        }
      }
    }
  }
}