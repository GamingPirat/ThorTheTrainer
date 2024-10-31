import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/mokdaten.dart';
import 'package:lernplatform/print_colors.dart';
import '../datenklassen/log_teilnehmer.dart';

class UserModel with ChangeNotifier {

  late Teilnehmer teilnehmer;
  List<UsersLernfeld> usersLernfelder = [];
  bool _isLoading = true;

  UserModel() {_load();}

  get isLoading => _isLoading;
  // todo später wenn Teilnehmer nur begrenzte Lernfelder haben muss die firstore Abfrage konkreter werden. Sprich ich muss was mit der Datenbank machen das Teilnehmer.key x nur zugriff auf x hat

  Future<void> _load() async {
    print_Green("UserModel: _load()");// todo print
    final Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    _isLoading = true;
    notifyListeners();  // Setzt den Ladezustand und benachrichtigt alle Listener

    List<Lernfeld_DB> firestoreLernfelder = [];

    try {
      // Lade das EINZIGE Lernfeld-Dokument aus der gesamten Sammlung
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('PV_WISO')
          .get();
      // print_Green("Konvertiere Firestore-Dokument in ein Lernfeld-Objekt"); // todo print

      // Überprüfe, ob überhaupt Dokumente vorhanden sind
      if (snapshot.docs.isNotEmpty) {
        // Nehme das erste Dokument aus der Sammlung
        DocumentSnapshot<Map<String, dynamic>> doc = snapshot.docs.first;
        Map<String, dynamic> data = doc.data()!;
        // print_Red("Firestore Dokument-Daten: $data"); // todo print

        // Konvertiere das Dokument direkt in ein Lernfeld-Objekt
        Lernfeld_DB lernfeld = Lernfeld_DB.fromJson(data, "Prüfungsvorbereitung WISO");

        firestoreLernfelder.add(lernfeld);  // Füge das Lernfeld zur Liste hinzu
      } else {
        print_Red('UserModel Keine Dokumente in der Sammlung vorhanden');
      }

      // print_Green("UserModel Lernfelder erfolgreich konvertiert."); // todo print
    } catch (e) {
      print_Red('UserModel hat Fehler beim Laden der Daten: $e');  // Fehlerbehandlung, falls etwas schiefgeht
    }

    // Initialisiere den Teilnehmer basierend auf den geladenen Daten
    teilnehmer = await ladeOderErzeugeTeilnehmer(firestoreLernfelder);  // Teilnehmer wird jetzt korrekt initialisiert
    // print_Green("UserModel teilnehmer geladen. $teilnehmer"); // todo print


    // Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers
    usersLernfelder.clear();  // Leere die Liste, bevor du neue Einträge hinzufügst
    for (LogLernfeld logLernfeld in teilnehmer.meineLernfelder) {
      for (Lernfeld_DB lernfeld in firestoreLernfelder) {
        // print('Vergleiche: logLernfeld.id = ${logLernfeld.id}, lernfeld.id = ${lernfeld.id}'); // todo print
        if (logLernfeld.id == lernfeld.id) {
          usersLernfelder.add(UsersLernfeld(
              logLernfeld: logLernfeld,
              lernfeld: lernfeld,
          ));
          // print_Yellow("Geladenes Lernfeld: ${lernfeld.name}, Themen: ${lernfeld.themen.length}"); // todo print
        }
      }
    }
    // print_Green("Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers abgeschlossen"); // todo print

    // while(stopwatch.elapsedMilliseconds < 5000){
    //   Future.delayed(Duration(milliseconds: 1));
    //   print_Yellow("stopwatch.elapsedMilliseconds = ${stopwatch.elapsedMilliseconds}"); // todo print ladezeit verlängern
    // }
    _isLoading = false;
    notifyListeners();
  }

  bool get childIsSelected {
    print_Yellow("UserModel got called: childIsSelected");
    for (UsersLernfeld lernfeld in usersLernfelder) {
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
    for (UsersLernfeld lernfeld in usersLernfelder) {
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
    for (UsersLernfeld lernfeld in usersLernfelder) {
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