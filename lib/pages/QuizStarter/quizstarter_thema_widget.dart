import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_selecter_widget.dart';

class QuizstarterThemaWidget extends StatelessWidget {
  UsersThema viewModel;
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
          itemCount: viewModel.meineSubThemen.length,
          itemBuilder: (context, index) {
            UsersSubThema subthema = viewModel.meineSubThemen[index];
            return QuizStarterSelecterWidget(viewModel: subthema);
          },
        ),
      ),
    ],
              );
  }
}
