import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lernplatform/FrageDBService.dart';
import 'package:lernplatform/datenklassen/frage.dart';
import 'package:lernplatform/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings( // macht alles kostengünstiger
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FrageDBService Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FrageDBService _dbService = FrageDBService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FrageDBService Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _createFrage,
              child: Text('Create Frage'),
            ),
            ElevatedButton(
              onPressed: _getFrageById,
              child: Text('Get Frage by ID'),
            ),
            ElevatedButton(
              onPressed: _getByThemaID,
              child: Text('Get Fragen by ThemaID'),
            ),
            ElevatedButton(
              onPressed: _updateFrage,
              child: Text('Update Frage'),
            ),
            ElevatedButton(
              onPressed: _deleteFrage,
              child: Text('Delete Frage'),
            ),
          ],
        ),
      ),
    );
  }

  // Beispiel Methode für das Erstellen einer Frage
  void _createFrage() async {
    Frage newFrage = Frage(
      nummer: 1,
      version: 1,
      themaID: 1,
      punkte: 5,
      text: 'Was ist F?',
      antworten: [
        Antwort(text: 'Eine NoSQL-Datenbank', erklaerung: 'Firebase bietet mehrere Dienste.', isKorrekt: true),
        Antwort(text: 'Ein SQL-Server', erklaerung: 'Firebase bietet keinen SQL-Server.', isKorrekt: false),
      ],
    );
    await _dbService.createFrage(newFrage);
    print('Frage erstellt');
  }

  // Beispiel Methode für das Abrufen einer Frage anhand der ID
  void _getFrageById() async {
    List<Frage> frageList = await _dbService.getFragenById('deineFrageID');
    print('Frage geladen: ${frageList.first.text}');
  }

  // Beispiel Methode für das Abrufen aller Fragen mit einer bestimmten ThemaID
  void _getByThemaID() async {
    List<Frage> fragenList = await _dbService.getByThemaID(1);
    print('Fragen mit ThemaID 1: ${fragenList.length}');
  }

  // Beispiel Methode für das Aktualisieren einer Frage
  void _updateFrage() async {
    Frage updatedFrage = Frage(
      nummer: 1,
      version: 1,
      themaID: 123,
      punkte: 10, // Geänderte Punkte
      text: 'Was ist Firestore?',
      antworten: [
        Antwort(text: 'Eine NoSQL-Datenbank', erklaerung: 'Firestore ist NoSQL.', isKorrekt: true),
        Antwort(text: 'Ein SQL-Server', erklaerung: 'Firestore bietet keinen SQL-Server.', isKorrekt: false),
      ],
    );
    await _dbService.updateFrage('deineFrageID', updatedFrage);
    print('Frage aktualisiert');
  }

  // Beispiel Methode für das Löschen einer Frage
  void _deleteFrage() async {
    await _dbService.deleteFrage('deineFrageID');
    print('Frage gelöscht');
  }
}
