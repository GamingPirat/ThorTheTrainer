import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/pages/QuizStarter/QuizzStarter_Screen.dart';
import 'package:lernplatform/pages/my_navigator.dart';
import 'package:lernplatform/pages/Quiz/quiz_subthema.dart';
import 'package:lernplatform/menu/progress_bar.dart';
import 'package:lernplatform/print_colors.dart';
import 'package:lernplatform/session.dart';

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
  @override
  _MyLeftDrawerState createState() => _MyLeftDrawerState();
}

class _MyLeftDrawerState extends State<MyLeftDrawer> {
  // Speichere den Expanded-Zustand für jedes Lernfeld
  Map<int, bool> expandedStates = {};

  @override
  Widget build(BuildContext context) {
    print("build MyLeftDrawer");

    return Column(
          children: [
    SizedBox(height: 32),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          List<QuizSubThema> quizThemen = [];
          for (LogLernfeld lernfeld in Session().user.teilnehmer.meineLernfelder) {
            for (LogThema thema in lernfeld.meineThemen) {
              for (LogSubThema subThema in thema.logSubthemen) {
                quizThemen.add(QuizSubThema(logSubThema: subThema));
              }
            }
          }
          MyNavigator(
              context: context,
              header: Text("Welche Fragen sollen im Quiz sein?"),
              body: QuizStarter_Screen()
          );
        },
        child: const Row(
          children: [
            Icon(Icons.emoji_events),
            Spacer(),
            Text("Quiz"),
            Spacer(),
          ],
        ),
      ),
    ),
    buildFolderList(),
          ],
        );
  }

  Widget buildFolderList() {
    print_Yellow("buildFolderList()");

    if (Session().user.usersLernfelder.isEmpty) {
      return Center(child: Text("Keine Lernfelder verfügbar"));
    }

    return Expanded(
      child: ListView(
        children: Session().user.usersLernfelder.map((lernfeld) {
          expandedStates.putIfAbsent(lernfeld.id, () => false);

          return ExpansionTile(
            title: ProgressWidget(viewModel: lernfeld),
            leading: Icon(
              expandedStates[lernfeld.id] == true
                  ? Icons.folder_open  // Offener Ordner wenn expanded
                  : Icons.folder,  // Geschlossener Ordner wenn collapsed
            ),
            trailing: SizedBox.shrink(),
            initiallyExpanded: expandedStates[lernfeld.id] ?? false,
            onExpansionChanged: (bool expanded) {
              setState(() {
                expandedStates[lernfeld.id] = expanded;
              });
            },
            children: lernfeld.meineThemen.map((thema) {
              bool isThemaExpanded = expandedStates[thema.id] ?? false;

              return ExpansionTile(
                title: ProgressWidget(viewModel: thema),
                trailing: Icon(
                  isThemaExpanded
                      ? Icons.arrow_drop_down
                      : Icons.arrow_right,
                ),
                initiallyExpanded: isThemaExpanded,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    expandedStates[thema.id] = expanded;
                  });
                },
                children: thema.meineSubThemen.map((subThema) {
                  return InkWell(
                    onTap: () {
                      print("Tapped on SubThema: ${subThema.name}");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.of(context).pop();
                          });
                          return AlertDialog(
                            title: Text("Dieses Feature befindet sich noch in Arbeit"),
                          );
                        },
                      );
                    },
                    hoverColor: Colors.blue.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 56, 0),
                      child: ListTile(
                        title: ProgressWidget(viewModel: subThema),
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

