import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class FragenInserter extends StatefulWidget {
  @override
  _FragenInserterState createState() => _FragenInserterState();
}

class _FragenInserterState extends State<FragenInserter> {
  final TextEditingController _jsonController = TextEditingController();

  Future<void> _addQuestions(String documentId) async {
    String subcollectionName = '$documentId Fragen';
    CollectionReference questionsCollection = FirebaseFirestore.instance
        .collection('Lernfelder')
        .doc(documentId)
        .collection(subcollectionName);

    try {
      // Parse JSON from the TextEntry
      List<dynamic> questions = jsonDecode(_jsonController.text);

      for (var question in questions) {
        await questionsCollection.add(question);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fragen zur Sammlung $subcollectionName hinzugefügt.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ungültiges JSON-Format: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lernfelder Dokument-IDs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _jsonController,
              decoration: InputDecoration(
                labelText: 'JSON-Daten eingeben',
                border: OutlineInputBorder(),
                hintText: 'Füge hier die JSON-Daten ein',
              ),
              maxLines: 10,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Lernfelder').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var documents = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var doc = documents[index];
                    return ListTile(
                      title: Text(doc.id),
                      trailing: ElevatedButton(
                        onPressed: () => _addQuestions(doc.id),
                        child: Text("Fragen hinzufügen"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
