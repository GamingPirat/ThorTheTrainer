import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SammlungToJson extends StatefulWidget {
  @override
  _SammlungToJsonState createState() => _SammlungToJsonState();
}

class _SammlungToJsonState extends State<SammlungToJson> {
  final TextEditingController _controller = TextEditingController();
  String _jsonData = '';
  bool _isLoading = false;

  Future<void> fetchCollectionData() async {
    setState(() {
      _isLoading = true;
      _jsonData = '';
    });

    final collectionName = _controller.text.trim();
    if (collectionName.isEmpty) {
      setState(() {
        _isLoading = false;
        _jsonData = 'Bitte gib einen Sammlungsnamen ein.';
      });
      return;
    }

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();
      setState(() {
        _jsonData = jsonEncode(data);
      });
    } catch (e) {
      setState(() {
        _jsonData = 'Fehler beim Abrufen der Daten: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sammlung als JSON anzeigen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Sammlungsname eingeben',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchCollectionData,
              child: Text('Daten abrufen'),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    _jsonData,
                    style: TextStyle(fontFamily: 'Courier', fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
