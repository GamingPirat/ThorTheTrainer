import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/new_Quizscreen.dart';
import 'package:lernplatform/Quiz/quiz_thema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/session.dart';
import '../Quiz/Quiz_Screen.dart';
import 'folder_widget.dart';

List<QuizThema> mok_QuizThemen() {
  List<QuizThema> list = [];
  for (LogLernfeld loglernfeld in Session().user.teilnehmer.meineLernfelder) {
    for (LogThema logThema in loglernfeld.meineThemen) {
      list.add(QuizThema(logThema: logThema));
    }
  }
  return list;
}

class MyLeftDrawer extends StatefulWidget {

  @override
  State<MyLeftDrawer> createState() => _MyLeftDrawerState();
}

class _MyLeftDrawerState extends State<MyLeftDrawer> {

  @override
  Widget build(BuildContext context) {
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
                        builder: (context) => NewQuizScreen(quizThemen: mok_QuizThemen(),),
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
            ),
            buildFolderList(),
          ],
        ),
      ),
    );
  }

  Widget buildFolderList() {
    return Expanded(
      child: ListView(
        children: Session().user.usersLernfelder.map((lernfeld) {
          return LernfeldWidget(lernfeld: lernfeld,);
        }).toList(),
      ),
    );
  }
}