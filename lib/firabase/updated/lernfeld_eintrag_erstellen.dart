import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:lernplatform/globals/print_colors.dart';

class LernfeldEintragErstellen extends StatefulWidget {
  @override
  _LernfeldEintragErstellenState createState() => _LernfeldEintragErstellenState();
}

class _LernfeldEintragErstellenState extends State<LernfeldEintragErstellen> {
  final TextEditingController _documentNameController = TextEditingController();
  final TextEditingController _jsonContentController = TextEditingController();

  // Methode zum Hochladen der JSON-Daten in die Sammlung "Lernfelder"
  void _uploadJsonData() async {
    if (_documentNameController.text.isEmpty || _jsonContentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bitte geben Sie einen Dokumentnamen und JSON-Daten ein.')),
      );
      return;
    }

    try {
      Map<String, dynamic> jsonData = json.decode(_jsonContentController.text);
      String documentName = _documentNameController.text;

      // Die JSON-Daten als neues Dokument in die Sammlung "Lernfelder" einfügen
      await FirebaseFirestore.instance.collection("Lernfelder").doc(documentName).set(jsonData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Daten erfolgreich in Dokument "$documentName" der Sammlung "Lernfelder" eingefügt!')),
      );
    } catch (e) {
      print_Cyan("$e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Einfügen der Daten: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lernfelder Dokument hinzufügen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _documentNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dokumentname eingeben',
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
