import 'package:flutter/material.dart';
import 'package:lernplatform/pages/Quiz/new_quizsubthema_model.dart';
import 'package:lernplatform/pages/progress_bar_widget.dart';

class NewQuizSubthemaWidget extends StatelessWidget {
  NewQuizsubthemaModel viewmodel;

  NewQuizSubthemaWidget({required this.viewmodel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: ProgressWidget(viewModel: viewmodel.selected_subthema)),
      ],
    );
  }
}