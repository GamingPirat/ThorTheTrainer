import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/personal_content_controllers.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_subThemaWidget.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_thema_widget.dart';
import 'package:lernplatform/session.dart';

class QuizStarter_Screen extends StatelessWidget {
  const QuizStarter_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    Session().pageHeader = const Text("Welche Fragen sollen im Quiz sein?");

    return Scaffold(
      appBar: Session().appBar,
      drawer: Session().drawer,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: Session().user.usersLernfelder.length,
          itemBuilder: (context, index) {
            Lernfeld_Personal lernfeld = Session().user.usersLernfelder[index];

            return Column(
              children: [
                QuizStarterSelecterWidget(viewModel: lernfeld),
                GridView.builder(
                  shrinkWrap: true,  // GridView nimmt nur so viel Platz ein, wie es benötigt
                  physics: const NeverScrollableScrollPhysics(),  // Kein eigenes Scrollen
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 2.4,
                  ),
                  itemCount: lernfeld.meineThemen.length,
                  itemBuilder: (context, index) {
                    Thema_Personal thema = lernfeld.meineThemen[index];

                    return Column(
                      children: [
                        QuizStarterSelecterWidget(viewModel: thema),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,        // Anzahl der Spalten
                            crossAxisSpacing: 4,     // Abstand zwischen den Spalten
                            mainAxisSpacing: 4,      // Abstand zwischen den Reihen
                            childAspectRatio: 2,    // Seitenverhältnis der Kinder (Breite zu Höhe)
                          ),
                          itemCount: thema.meineSubThemen.length,
                          itemBuilder: (context, index) {
                            SubThema_Personal subthema = thema.meineSubThemen[index];

                            return QuizStarterSelecterWidget(viewModel: subthema);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

