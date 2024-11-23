import 'package:flutter/material.dart';
import 'package:lernplatform/pages/QuizStarter/QuizzStarter_Screen.dart';
import 'package:lernplatform/globals/session.dart';

// List<QuizThema> mok_QuizThemen() {
//   List<QuizThema> list = [];
//   for (LogLernfeld loglernfeld in Session().user.teilnehmer.meineLernfelder) {
//     for (LogSubThema logThema in loglernfeld.meineThemen) {
//       list.add(QuizThema(logThema: logThema));
//     }
//   }
//   return list;
// } todo mokdaten löschen

class MyLeftDrawer extends StatefulWidget {
  @override
  _MyLeftDrawerState createState() => _MyLeftDrawerState();
}

class _MyLeftDrawerState extends State<MyLeftDrawer> {
  // Speichere den Expanded-Zustand für jedes Lernfeld
  Map<int, bool> expandedStates = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => QuizStarter_Screen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
            child: const Row(
              children: [
                Icon(Icons.emoji_events),
                Spacer(),
                Text("Fortschritte"),
                Spacer(),
              ],
            ),
          ),
        ),
        Builder(
          builder: (context) {
            if (Session().user.lernfelder.isEmpty) {
              return Center(child: Text("Keine Lernfelder verfügbar"));
            }

            return Expanded(
              child: ListView(
                children: Session().user.lernfelder.map((lernfeld) {
                  expandedStates.putIfAbsent(lernfeld.id, () => false);

                  return ExpansionTile(
                    title: Text(lernfeld.name),
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
                    children: lernfeld.usersKompetenzbereiche.map((thema) {
                      bool isThemaExpanded = expandedStates[thema.id] ?? false;

                      return ExpansionTile(
                        title: Center(child: Text(thema.name)),
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
                        children: thema.usersInhalte.map((subThema) {
                          return InkWell(
                            onTap: () {
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
                                  title: Text(subThema.name)
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
        ),
      ],
    );
  }
}

