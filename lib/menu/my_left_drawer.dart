import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/new_Quizscreen.dart';
import 'package:lernplatform/Quiz/quiz_thema.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/db_thema.dart';
import 'package:lernplatform/menu/foldercontainer_widget.dart';
import 'package:lernplatform/pages/progress_bar.dart';
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
  @override
  _MyLeftDrawerState createState() => _MyLeftDrawerState();
}

class _MyLeftDrawerState extends State<MyLeftDrawer> {
  // Speichere den Expanded-Zustand für jedes Lernfeld
  Map<int, bool> expandedStates = {};

  @override
  Widget build(BuildContext context) {
    print("build MyLeftDrawer");

    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
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
                  SizedBox(width: 32),
                  Text("Quiz"),
                ],
              ),
            ),
          ),
          buildFolderList(),
        ],
      ),
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
          // Initialisiere den Zustand, falls noch nicht vorhanden
          expandedStates.putIfAbsent(lernfeld.id, () => false);

          return ExpansionTile(
            title: ProgressWidget(viewModel: lernfeld,),
            // Icon links anzeigen: Geschlossenes oder geöffnetes Ordner-Icon je nach Zustand
            leading: Icon(
              expandedStates[lernfeld.id] == true
                  ? Icons.folder_open  // Offener Ordner wenn expanded
                  : Icons.folder,  // Geschlossener Ordner wenn collapsed
            ),
            // Pfeil-Icon ausblenden
            trailing: SizedBox.shrink(),
            // Übergebe den gespeicherten Expanded-Zustand für das Lernfeld
            initiallyExpanded: expandedStates[lernfeld.id] ?? false,
            onExpansionChanged: (bool expanded) {
              setState(() {
                expandedStates[lernfeld.id] = expanded;
              });
            },
            // ExpansionTile für jedes Thema innerhalb des Lernfeldes
            children: lernfeld.meineThemen.map((thema) {
              // Ein zusätzlicher Map für Themen-Expanded-Zustände
              bool isThemaExpanded = expandedStates[thema.id] ?? false;

              return ExpansionTile(
                title: ProgressWidget(viewModel: thema,),
                // Pfeil-Icon rechts anzeigen
                trailing: Icon(
                  isThemaExpanded
                      ? Icons.arrow_drop_down  // Pfeil nach unten, wenn expanded
                      : Icons.arrow_right,  // Pfeil nach rechts, wenn collapsed
                ),
                // Übergebe den gespeicherten Expanded-Zustand für das Thema
                initiallyExpanded: isThemaExpanded,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    expandedStates[thema.id] = expanded;  // Zustand für das Thema speichern
                  });
                },
                // Jedes Thema hat seine Subthemen als Kinder
                children: thema.meineSubThemen.map((subThema) {
                  return InkWell(
                    onTap: () {
                      // Handle tap on SubThema
                      print("Tapped on SubThema: \${subThema.name}");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          Future.delayed(Duration(seconds: 3), () {
                            Navigator.of(context).pop(); // Schließt das Popup nach 3 Sekunden
                          });
                          return AlertDialog(
                            title: Text("Dieses Feature befindet sich noch in Arbeit"),
                            // content: Text("Dieses Feature befindet sich noch in Arbeit"),
                          );
                        },
                      );
                    },
                    hoverColor: Colors.blue.withOpacity(0.2),  // Leichter Hover-Effekt
                    child: ListTile(
                      title: ProgressWidget(viewModel: subThema,),
                      // Optional: Du kannst auch hier Icons oder andere Interaktionen hinzufügen
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
