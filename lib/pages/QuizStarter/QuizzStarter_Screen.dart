import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/personal_content_controllers.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_subThemaWidget.dart';
import 'package:lernplatform/session.dart';

class QuizStarter_Screen extends StatelessWidget {
  const QuizStarter_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    Session().pageHeader = Text("Welche Fragen sollen im Quiz sein?");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,        // Anzahl der Spalten
          crossAxisSpacing: 4,     // Abstand zwischen den Spalten
          mainAxisSpacing: 4,      // Abstand zwischen den Reihen
          childAspectRatio: 4,    // Seitenverhältnis der Kinder (Breite zu Höhe)
        ),
        itemCount: Session().user.usersLernfelder
            .expand((lernfeld) => lernfeld.meineThemen)
            .expand((thema) => thema.meineSubThemen)
            .length,
        itemBuilder: (context, index) {
          List<SubThema_Personal> subthemen = Session().user.usersLernfelder
              .expand((lernfeld) => lernfeld.meineThemen)
              .expand((thema) => thema.meineSubThemen)
              .toList();

          SubThema_Personal subthema = subthemen[index];

          return QuizStarterSubThemaWidget(viewModel: subthema);
        },
      ),
    );
  }
}
