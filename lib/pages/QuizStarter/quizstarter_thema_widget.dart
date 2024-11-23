import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_kompetenzbereich_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_inhalt_viewmodel.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_selecter_widget.dart';

class QuizstarterThemaWidget extends StatelessWidget {
  UsersKompetenzbereich viewModel;
  QuizstarterThemaWidget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
          Expanded(child: Center(child: QuizStarterSelecterWidget(viewModel: viewModel,))),

      Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,        // Anzahl der Spalten
            crossAxisSpacing: 4,     // Abstand zwischen den Spalten
            mainAxisSpacing: 4,      // Abstand zwischen den Reihen
            childAspectRatio: 4,    // Seitenverhältnis der Kinder (Breite zu Höhe)
          ),
          itemCount: viewModel.usersInhalte.length,
          itemBuilder: (context, index) {
            UsersInhalt subthema = viewModel.usersInhalte[index];
            return QuizStarterSelecterWidget(viewModel: subthema);
          },
        ),
      ),
    ],
              );
  }
}
