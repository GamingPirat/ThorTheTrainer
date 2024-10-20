import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart'; // Stelle sicher, dass du die richtigen Firebase-Optionen hast


// todo README!!!!
// todo die eingefügte Datei muss eine Liste an Lernfeldern inklusive ihrer Theman haben

class LernfeldInserter extends StatefulWidget {
  @override
  _LernfeldInserterState createState() => _LernfeldInserterState();
}

class _LernfeldInserterState extends State<LernfeldInserter> {
  TextEditingController _controller = TextEditingController();

  void _insertData() {
    try {
      Map<String, dynamic> jsonData = json.decode(_controller.text);
      jsonData.forEach((key, value) {
        FirebaseFirestore.instance.collection('PV_WISO').add({
          'name': key,
          'details': value,
        });
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Daten erfolgreich eingefügt!")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Fehler beim Verarbeiten der Daten!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lernfeld Inserter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Füge hier den JSON-Code ein...',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _insertData,
              child: Text('Daten einfügen'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: LernfeldInserter(),
  ));
}
