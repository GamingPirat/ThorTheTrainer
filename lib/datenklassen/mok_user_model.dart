import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/mokdaten.dart';
import 'package:lernplatform/print_colors.dart';
import 'log_teilnehmer.dart';



class UserModel with ChangeNotifier {

  late Teilnehmer teilnehmer;
  List<UsersLernfeld> usersLernfelder = [];
  bool _isLoading = true;

  UserModel(){_load();}

  get isLoading => _isLoading;
  // todo später wenn Teilnehmer nur begrenzte Lernfelder haben muss die firstore Abfrage konkreter werden. Sprich ich muss was mit der Datenbank machen das Teilnehmer.key x nur zugriff auf x hat

  Future<void> _load() async {
    // print_Green("UserModel: _load()");// todo
    _isLoading = true;
    notifyListeners();  // Setzt den Ladezustand und benachrichtigt alle Listener

    List<Lernfeld_DB> firestoreLernfelder = [];

    try {
      // Lade das EINZIGE Lernfeld-Dokument aus der gesamten Sammlung
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('PV_WISO')
          .get();
      // print_Green("Konvertiere Firestore-Dokument in ein Lernfeld-Objekt"); // todo

      // Überprüfe, ob überhaupt Dokumente vorhanden sind
      if (snapshot.docs.isNotEmpty) {
        // Nehme das erste Dokument aus der Sammlung
        DocumentSnapshot<Map<String, dynamic>> doc = snapshot.docs.first;
        Map<String, dynamic> data = doc.data()!;
        // print_Red("Firestore Dokument-Daten: $data"); // todo

        // Konvertiere das Dokument direkt in ein Lernfeld-Objekt
        Lernfeld_DB lernfeld = Lernfeld_DB.fromJson(data, "Prüfungsvorbereitung WISO");

        firestoreLernfelder.add(lernfeld);  // Füge das Lernfeld zur Liste hinzu
      } else {
        print_Red('UserModel Keine Dokumente in der Sammlung vorhanden');
      }

      // print_Green("UserModel Lernfelder erfolgreich konvertiert."); // todo
    } catch (e) {
      print_Red('UserModel hat Fehler beim Laden der Daten: $e');  // Fehlerbehandlung, falls etwas schiefgeht
    }

    // Initialisiere den Teilnehmer basierend auf den geladenen Daten
    teilnehmer = await ladeOderErzeugeTeilnehmer(firestoreLernfelder);  // Teilnehmer wird jetzt korrekt initialisiert
    // print_Green("UserModel teilnehmer geladen. $teilnehmer"); // todo


    // Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers
    usersLernfelder.clear();  // Leere die Liste, bevor du neue Einträge hinzufügst
    for (LogLernfeld logLernfeld in teilnehmer.meineLernfelder) {
      for (Lernfeld_DB lernfeld in firestoreLernfelder) {
        // print('Vergleiche: logLernfeld.id = ${logLernfeld.id}, lernfeld.id = ${lernfeld.id}'); // todo
        if (logLernfeld.id == lernfeld.id) {
          usersLernfelder.add(UsersLernfeld(logLernfeld: logLernfeld, lernfeld: lernfeld));
          // print_Yellow("Geladenes Lernfeld: ${lernfeld.name}, Themen: ${lernfeld.themen.length}"); // todo
        }
      }
    }
    // print_Green("Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers abgeschlossen"); // todo

    _isLoading = false;
    notifyListeners();  // Ladezustand auf "false" setzen und Listener benachrichtigen
  }

  // double getProgress(ContentCarrier cc) {
  //
  //   if (cc is Lernfeld_DB)
  //     for(LogLernfeld lernfeld in teilnehmer.meineLernfelder)
  //       if(lernfeld.id == cc.id)
  //         return lernfeld.getProgress();
  //
  //   else if (cc is Thema)
  //       for(LogLernfeld lernfeld in teilnehmer.meineLernfelder)
  //         for(LogThema thema in lernfeld.meineThemen)
  //           if(thema.id == cc.id)
  //             return thema.getProgress();
  //
  //   else if (cc is SubThema)
  //       for(LogLernfeld lernfeld in teilnehmer.meineLernfelder)
  //         for(LogThema thema in lernfeld.meineThemen)
  //           for(LogSubThema subTthema in thema.logSubthemen)
  //             if(subTthema.id == cc.id)
  //               return subTthema.getProgress();
  //
  //   return -1.0;
  // }
}