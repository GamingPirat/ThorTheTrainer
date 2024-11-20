import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // Firebase initialisieren
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Update durchführen
  await FirebaseFirestore.instance
      .collection('Keys')
      .doc(r'Alpha_B8$kFm2@rW^bXe!4pZ*u&oR6%1HjLq#G7Nv?Td') // Beispiel-Dokument-ID
      .update({'lernfelder': []});

  print('Update erfolgreich: lernfelder auf [] gesetzt.');
}
