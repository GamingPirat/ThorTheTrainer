import 'package:flutter/material.dart';

class MyWidget<T> extends StatelessWidget {
  final Widget tchild;
  final Future<T> future;

  MyWidget({required this.tchild, required this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future, // Übergebe das Future-Objekt
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Ladeindikator
        } else if (snapshot.hasError) {
          return Text('Fehler: ${snapshot.error}'); // Fehleranzeige
        } else if (snapshot.hasData) {
          final data = snapshot.data; // Daten vorhanden, zeige Widget
          return Text('Daten: ${data.toString()}'); // Hier kann ein anderes Widget verwendet werden
        } else {
          return tchild; // Widget, das angezeigt wird, wenn keine Daten vorhanden sind
        }
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: MyWidget<String>(
          tchild: Text('Kein Inhalt verfügbar'),
          future: Future.delayed(
            Duration(seconds: 2),
                () => 'Lade Daten erfolgreich!',
          ), // Simuliertes Future für das Testen
        ),
      ),
    ),
  );
}
