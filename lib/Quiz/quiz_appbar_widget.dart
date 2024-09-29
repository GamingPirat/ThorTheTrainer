import 'package:flutter/material.dart';

class QuizAppbarWidget extends StatefulWidget {
  QuizAppbarWidget({Key? key}) : super(key: key);

  // Öffentliche Methode, um den Wert von bars zu erhöhen
  void incrementBars() {
    final state = key?.currentState as _QuizAppbarWidgetState?;
    state?.incrementBars();
  }

  @override
  _QuizAppbarWidgetState createState() => _QuizAppbarWidgetState();
}

class _QuizAppbarWidgetState extends State<QuizAppbarWidget> {
  int _bars = 0;

  // Interne Methode zur Erhöhung von bars
  void incrementBars() {
    setState(() {
      _bars++;
      if (_bars == 11) {
        _bars = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Bars: $_bars"),
        ElevatedButton(
          onPressed: () {
            incrementBars(); // Beispiel zur Aktualisierung
          },
          child: Text("Erhöhe Bars"),
        ),
      ],
    );
  }
}

// GlobalKey, um auf den spezifischen State (_QuizAppbarWidgetState) zuzugreifen
final GlobalKey<_QuizAppbarWidgetState> quizfortschrittKey = GlobalKey<_QuizAppbarWidgetState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Quiz App"),
        ),
        body: Center(
          child: QuizAppbarWidget(key: quizfortschrittKey), // Das Widget erhält den GlobalKey
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Greife auf den Setter 'bars' über den GlobalKey zu
            quizfortschrittKey.currentState?.bars = 5; // Beispiel: Setze Bars auf 5
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
