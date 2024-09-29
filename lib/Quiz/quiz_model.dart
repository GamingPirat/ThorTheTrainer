import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/Frage_Model.dart';
import 'package:lernplatform/Quiz/quiz_appbar_widget.dart';
import 'package:lernplatform/Quiz/quiz_teilnehmer.dart';
import 'package:lernplatform/datenklassen/log_lernfeld_u_frage.dart';
import 'package:lernplatform/log_and_content-converter.dart';
import 'package:lernplatform/user_session.dart';
import '../datenklassen/thema.dart';
import '../datenklassen/view_builder.dart';

class QuizModel with ChangeNotifier {

  QuizTeilnehmer quizTeilnehmer;
  bool _isLocked = false;
  List<Frage_Model> historie = [];
  Random rnd = Random();
  late LogThema _aktuellesThema;
  late Frage_Model _currentQuestioin;

  QuizModel({required this.quizTeilnehmer}){
    nextTapped();
  }

  void lockTapped() {
    _isLocked = true;
    // Suche das Objekt, dessen id mit der aktuellen Frage übereinstimmt
    LogFrage removed = _aktuellesThema.offeneFragen.firstWhere(
          (frage) => frage.id == _currentQuestioin.frage!.id,
    );
    _aktuellesThema.offeneFragen.remove(removed);

    if (_currentQuestioin.frage.punkte > _currentQuestioin.evaluate())
      _aktuellesThema.falschBeantworteteFragen.add(removed);
    else
      _aktuellesThema.richtigBeantworteteFragen.add(removed);

    quizfortschritt.currentState?.incrementBars();
    ;

    notifyListeners();
  }

  void nextTapped(){
    _aktuellesThema = quizTeilnehmer.nextThema();
    _isLocked = false;
    List<Frage> randomFragen = convertToFragen(logFragen: _aktuellesThema.offeneFragen);
    _currentQuestioin = Frage_Model(frage: randomFragen[rnd.nextInt(randomFragen.length)]);
    notifyListeners();
  }


  LogThema get aktuellesThema => _aktuellesThema;
  Frage_Model get currentQuestioin => _currentQuestioin;
  bool get isLocked => _isLocked;

}




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
