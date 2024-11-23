import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lernplatform/firabase/firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuchbareFragenScreen extends StatefulWidget {
  @override
  _SuchbareFragenScreenState createState() => _SuchbareFragenScreenState();
}

class _SuchbareFragenScreenState extends State<SuchbareFragenScreen> {
  TextEditingController suchController = TextEditingController();
  Map<String, dynamic>? aktuelleFrage;
  bool isLoading = false;

  /// Lädt ein Dokument basierend auf der eingegebenen Dokument-ID
  Future<void> ladeFrage(String dokumentId) async {
    setState(() {
      isLoading = true;
      aktuelleFrage = null;
    });

    // Verbindung zur Firestore-Subcollection
    CollectionReference fragenCollection =
    FirebaseFirestore.instance.collection('Lernfelder').doc('LF9')
        .collection('LF 9 Netzwerke und Dienste bereitstellen Fragen');

    try {
      DocumentSnapshot doc = await fragenCollection.doc(dokumentId).get();
      if (doc.exists) {
        setState(() {
          aktuelleFrage = {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Dokument mit ID $dokumentId nicht gefunden."),
        ));
      }
    } catch (e) {
      print("Fehler beim Abrufen der Frage: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Fehler beim Abrufen der Frage."),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// Aktualisiert die inhalt_id des Dokuments
  Future<void> aktualisiereFrage(String dokumentId, int neueInhaltId) async {
    CollectionReference fragenCollection =
    FirebaseFirestore.instance.collection('Lernfelder').doc('LF9')
        .collection('LF 9 Netzwerke und Dienste bereitstellen Fragen');

    try {
      await fragenCollection.doc(dokumentId).update({'inhalt_id': neueInhaltId});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("inhalt_id für Dokument $dokumentId aktualisiert."),
      ));
      ladeFrage(dokumentId); // Aktualisierte Frage neu laden
    } catch (e) {
      print("Fehler beim Aktualisieren der Frage: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Fehler beim Aktualisieren der Frage."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fragen-Suche"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Suchleiste
            TextField(
              controller: suchController,
              decoration: InputDecoration(
                labelText: "Dokument-ID eingeben",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ladeFrage(suchController.text.trim());
              },
              child: Text("Frage laden"),
            ),
            SizedBox(height: 16),
            // Ladeanzeige oder gefundene Frage
            if (isLoading)
              CircularProgressIndicator()
            else if (aktuelleFrage != null)
              KarteFrage(
                frage: aktuelleFrage!,
                onSave: aktualisiereFrage,
              )
            else
              Text("Keine Frage geladen."),
          ],
        ),
      ),
    );
  }
}

class KarteFrage extends StatelessWidget {
  final Map<String, dynamic> frage;
  final Function(String dokumentId, int neueInhaltId) onSave;

  KarteFrage({required this.frage, required this.onSave});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(
      text: frage['inhalt_id'].toString(),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Dokument-ID: ${frage['id']}"),
            SizedBox(height: 8),
            Text("Frage: ${frage['text'] ?? 'Keine Beschreibung'}"),
            SizedBox(height: 8),
            Text("Aktuelle inhalt_id: ${frage['inhalt_id']}"),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "inhalt_id bearbeiten",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    int neueId = int.tryParse(controller.text) ?? 0;
                    onSave(frage['id'], neueId);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData.dark(), // Dark Mode aktivieren
    home: SuchbareFragenScreen(),
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
  runApp(MyApp());
}
