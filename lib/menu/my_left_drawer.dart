import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/new_Quizscreen.dart';
import 'package:lernplatform/Quiz/quiz_thema.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/print_colors.dart';
import 'package:lernplatform/session.dart';
import '../Quiz/Quiz_Screen.dart';
import 'folder_widget.dart';

// List<QuizThema> mok_QuizThemen() {
//   List<QuizThema> list = [];
//   for (LogLernfeld loglernfeld in Session().user.teilnehmer.meineLernfelder) {
//     for (LogSubThema logThema in loglernfeld.meineThemen) {
//       list.add(QuizThema(logThema: logThema));
//     }
//   }
//   return list;
// } todo

class MyLeftDrawer extends StatefulWidget {

  MyLeftDrawer() {
    print_Magenta("build MyLeftDrawer"); // Ausgabe im Konstruktor
  }

  @override
  State<MyLeftDrawer> createState() => _MyLeftDrawerState();
}

class _MyLeftDrawerState extends State<MyLeftDrawer> {

  @override
  Widget build(BuildContext context) {
    print_Magenta("build MyLeftDrawer");  // Prüfen, ob der Build überhaupt aufgerufen wird

    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          children: [
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // Iteriere durch alle Lernfelder und sammle die Quizthemen
                          List<QuizSubThema> quizThemen = [];

                          // Gehe durch jedes Lernfeld des Nutzers und extrahiere die Themen
                          for (LogLernfeld lernfeld in Session().user.teilnehmer.meineLernfelder) {
                            for (LogThema thema in lernfeld.meineThemen) {
                              // Gehe durch die Subthemen des Themas und füge sie der Quizthemenliste hinzu
                              for (LogSubThema subThema in thema.logSubthemen) {
                                quizThemen.add(QuizSubThema(logSubThema: subThema));
                              }
                            }
                          }


                          // Übergib die gesammelten Quiz-Themen an NewQuizScreen
                          return NewQuizScreen(quizThemen: quizThemen);
                        },
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.emoji_events),
                      SizedBox(width: 32,),
                      Text("Quiz"),
                    ],
                  ),
                ),
              ),
            ),  // Dieser Print sollte erscheinen
            buildFolderList(),  // Hier sollte buildFolderList() aufgerufen werden
          ],
        ),
      ),
    );
  }


  Widget buildFolderList() {
    print_Magenta("buildFolderList() wurde aufgerufen");
    print_Magenta("Lernfelder in der Liste: ${Session().user.usersLernfelder.length}");

    // if (Session().user.usersLernfelder.isEmpty) {
    //   return Center(child: Text("Keine Lernfelder verfügbar"));  // Keine Lernfelder vorhanden
    // }

    return Expanded(
      child: ListView(
        children: Session().user.usersLernfelder.map((lernfeld) {
          return LernfeldWidget(lernfeld: lernfeld);
        }).toList(),
      ),
    );
  }


}