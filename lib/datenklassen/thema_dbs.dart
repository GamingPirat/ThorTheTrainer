import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'frage.dart';
import 'thema.dart';

class Thema_JSONService {
  static Thema_JSONService? _instance;

  late List<Thema> _themen;
  get themen => _themen;

  // Privater Konstruktor
  Thema_JSONService._internal();

  // Singleton-Instanz laden oder zurückgeben
  static Future<Thema_JSONService> getInstance(String path) async {
    if (_instance == null) {
      _instance = Thema_JSONService._internal();
      await _instance!.load(path);
    }
    return _instance!;
  }

  // JSON-Daten laden und parsen
  Future<void> load(String path) async {
    try {
      // Lade die JSON-Datei aus dem übergebenen Pfad
      String jsonString = await rootBundle.loadString(path);
      print('JSON-Datei erfolgreich geladen: $jsonString'); // Debug-Ausgabe

      // JSON-Daten in ein Map umwandeln
      final data = json.decode(jsonString);
      print('Dekodierte JSON-Daten: $data'); // Debug-Ausgabe

      // Falls die JSON-Datei gültige Daten enthält
      if (data != null) {
        Thema thema = Thema.fromJson(data);
        _themen = [thema];  // Wir speichern das eine Thema in einer Liste
      } else {
        print("Keine Themen in der JSON-Datei gefunden");
        _themen = [];
      }
    } catch (e) {
      print("Fehler beim Laden der Themen: $e");
      _themen = [];
    }
  }
  // Beispielmethode: Hole eine zufällige Frage
  Frage getRandomFrage(LogThema logThema) {
    for (Thema thema in _themen) {
      if (thema.id == logThema.id) {
        for (Frage frage in thema.fragen) {
          if (!logThema.richtigBeantworteteFragen.contains(frage.id) &&
              !logThema.falschBeantworteteFragen.contains(frage.id)) {
            return frage;
          }
        }
      }
    }
    return Frage(
      nummer: 999999,
      version: 999999,
      themaID: 999999,
      punkte: 0,
      text: "Keine neuen Fragen mehr übrig",
      antworten: [],
    );
  }
}




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Thema_JSONService mit dem Pfad initialisieren
  final themaService = await Thema_JSONService.getInstance('assets/test_thema.json');

  runApp(DemonstrationApp(themaService: themaService));
}

class DemonstrationApp extends StatelessWidget {
  final Thema_JSONService themaService;

  DemonstrationApp({required this.themaService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Themenliste'),
        ),
        body: ThemaListWidget(themen: themaService.themen),
      ),
    );
  }
}

class ThemaListWidget extends StatelessWidget {
  final List<Thema> themen;

  ThemaListWidget({required this.themen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: themen.length,
      itemBuilder: (context, index) {
        var thema = themen[index];
        return ListTile(
          title: Text(thema.name),
          subtitle: Text('ID: ${thema.id} - Tags: ${thema.tags.join(', ')}'),
        );
      },
    );
  }
}
