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

    return ListView.builder(
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
                childAspectRatio: 4,
              ),
              itemCount: lernfeld.meineThemen.length,
              itemBuilder: (context, index) {
                Thema_Personal thema = lernfeld.meineThemen[index];
                return QuizstarterThemaWidget(viewModel: thema);
              },
            ),
          ],
        );
      },
    );
  }
}

