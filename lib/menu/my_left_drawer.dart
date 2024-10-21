import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/new_Quizscreen.dart';
import 'package:lernplatform/Quiz/quiz_thema.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/datenklassen/subthema.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/menu/foldercontainer_widget.dart';
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

          print_Yellow("Lernfeld: ${lernfeld.name}");
          for (Thema thema in lernfeld.themen) {
            print_Yellow("\tThema: ${thema.name}");
            for (SubThema subThema in thema.subthemen) {
              print_Yellow("\t\tSubThema: ${subThema.name}");
            }
          }

          return ExpansionTile(
            title: Text(lernfeld.name),
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
            children: lernfeld.themen.map((thema) {
              // Ein zusätzlicher Map für Themen-Expanded-Zustände
              bool isThemaExpanded = expandedStates[thema.id] ?? false;

              return Padding(
                padding: const EdgeInsets.only(left: 16.0),  // Themen eingerückt
                child: ExpansionTile(
                  title: Text(thema.name),
                  // Icon für Themen anzeigen: Geschlossener oder geöffneter Ordner, abhängig vom Zustand
                  leading: Icon(
                    isThemaExpanded
                        ? Icons.folder_open  // Geöffneter Ordner, wenn expanded
                        : Icons.folder,  // Geschlossener Ordner, wenn collapsed
                  ),
                  // Pfeil-Icon ausblenden
                  trailing: SizedBox.shrink(),
                  // Übergebe den gespeicherten Expanded-Zustand für das Thema
                  initiallyExpanded: isThemaExpanded,
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      expandedStates[thema.id] = expanded;  // Zustand für das Thema speichern
                    });
                  },
                  // Jedes Thema hat seine Subthemen als Kinder
                  children: thema.subthemen.map((subThema) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 32.0),  // Subthemen noch weiter eingerückt
                      child: InkWell(
                        onTap: () {
                          // Handle tap on SubThema
                          print("Tapped on SubThema: ${subThema.name}");
                          // Hier kannst du die gewünschte Navigation oder Aktion für das SubThema hinzufügen
                        },
                        hoverColor: Colors.blue.withOpacity(0.2),  // Leichter Hover-Effekt
                        child: ListTile(
                          title: Text(subThema.name),
                          // Optional: Du kannst auch hier Icons oder andere Interaktionen hinzufügen
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }


}
