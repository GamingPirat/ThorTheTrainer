import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:lernplatform/globals/print_colors.dart';

class SammlungErstellen extends StatefulWidget {
  @override
  _SammlungErstellenState createState() => _SammlungErstellenState();
}

class _SammlungErstellenState extends State<SammlungErstellen> {
  final TextEditingController _collectionNameController = TextEditingController();
  final TextEditingController _jsonContentController = TextEditingController();

  // Methode zum Hochladen der JSON-Daten in Firestore
  void _uploadJsonData() async {
    if (_collectionNameController.text.isEmpty || _jsonContentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bitte geben Sie einen Sammlungsnamen und JSON-Daten ein.')),
      );
      return;
    }

    try {
      Map<String, dynamic> jsonData = json.decode(_jsonContentController.text);
      String collectionName = _collectionNameController.text;

      // Die JSON-Daten in die angegebene Sammlung einfügen
      await FirebaseFirestore.instance.collection(collectionName).doc("$collectionName").set(jsonData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Daten erfolgreich in Sammlung "$collectionName" eingefügt!')),
      );
    } catch (e) {
      print_Cyan("$e");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Fehler beim Einfügen der Daten: $e')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SammlungsStarterApp für Firebase')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _collectionNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sammlungsname eingeben',
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _jsonContentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'JSON-Daten hier einfügen',
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadJsonData,
              child: Text('Daten einfügen'),
            ),
          ],
        ),
      ),
    );
  }
}
