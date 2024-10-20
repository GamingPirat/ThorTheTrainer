import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/mokdaten.dart';
import '../datenklassen/log_teilnehmer.dart';
import '../print_colors.dart';



class UserModel with ChangeNotifier {

  late Teilnehmer teilnehmer;
  List<Lernfeld> usersLernfelder = [];
  bool _isLoading = true;

  UserModel(){_load();}

  get isLoading => _isLoading;
  // todo später wenn Teilnehmer nur begrenzte Lernfelder haben muss die firstore Abfrage konkreter werden. Sprich ich muss was mit der Datenbank machen das Teilnehmer.key x nur zugriff auf x hat

  Future<void> _load() async {
    print_Green("UserModel: _load()");
    _isLoading = true;
    notifyListeners();  // Setzt den Ladezustand und benachrichtigt alle Listener

    List<Lernfeld> firestoreLernfelder = [];

    try {
      // Lade das EINZIGE Lernfeld-Dokument aus der gesamten Sammlung
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('PV_WISO')
          .get();
      print_Green("Konvertiere Firestore-Dokument in ein Lernfeld-Objekt");

      // Überprüfe, ob überhaupt Dokumente vorhanden sind
      if (snapshot.docs.isNotEmpty) {
        // Nehme das erste Dokument aus der Sammlung
        DocumentSnapshot<Map<String, dynamic>> doc = snapshot.docs.first;
        Map<String, dynamic> data = doc.data()!;
        print_Red("Firestore Dokument-Daten: $data");

        // Konvertiere das Dokument direkt in ein Lernfeld-Objekt
        Lernfeld lernfeld = Lernfeld.fromJson(data);

        // Überprüfe, ob alle Themen und Subthemen korrekt geladen wurden
        for (var thema in lernfeld.themen) {
          print_Green("Thema: ${thema.name}, Anzahl Subthemen: ${thema.subthemen.length}");
          for (var subThema in thema.subthemen) {
            print_Green("SubThema: ${subThema.name}, Anzahl Fragen: ${subThema.fragen.length}");
          }
        }

        firestoreLernfelder.add(lernfeld);  // Füge das Lernfeld zur Liste hinzu
      } else {
        print('Keine Dokumente in der Sammlung vorhanden');
      }

      print_Green("Lernfelder erfolgreich konvertiert.");
    } catch (e) {
      print('Fehler beim Laden der Daten: $e');  // Fehlerbehandlung, falls etwas schiefgeht
    }

    // Initialisiere den Teilnehmer basierend auf den geladenen Daten
    teilnehmer = await ladeOderErzeugeTeilnehmer(firestoreLernfelder);  // Teilnehmer wird jetzt korrekt initialisiert


    // Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers
    usersLernfelder.clear();  // Leere die Liste, bevor du neue Einträge hinzufügst
    for (LogLernfeld logLernfeld in teilnehmer.meineLernfelder) {
      for (Lernfeld lernfeld in firestoreLernfelder) {
        print('Vergleiche: logLernfeld.id = ${logLernfeld.id}, lernfeld.id = ${lernfeld.id}');
        if (logLernfeld.id == lernfeld.id) {
          usersLernfelder.add(lernfeld);
          print("Geladenes Lernfeld: ${lernfeld.name}, Themen: ${lernfeld.themen.length}");
        }
      }
    }
    print_Green("Vergleiche die geladenen Lernfelder mit den Lernfeldern des Teilnehmers abgeschlossen");

    _isLoading = false;
    notifyListeners();  // Ladezustand auf "false" setzen und Listener benachrichtigen
  }










// Future<void>speichern() async {
  //   speichereTeilnehmer(teilnehmer);
  // }
}