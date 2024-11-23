import 'package:flutter/material.dart';
import 'package:lernplatform/pages/Quiz/quiz_frage_widget.dart';
import 'package:lernplatform/pages/Quiz/quiz_inhalt_controller.dart';
import 'package:lernplatform/pages/progress_bar_widget.dart';
import 'package:provider/provider.dart';

class QuizInhaltWidget extends StatelessWidget {
  QuizInhaltController viewModel;

  QuizInhaltWidget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<QuizInhaltController>(
          builder: (context, vm, child) {
            return Container(
              child: Column(
              children: [
                Center(
                  child: ProgressWidget(viewModel: viewModel.selected_inhalt)
                ),
                QuizFrageWidget(viewModel: vm.random_question,),
              ],
                        ),
            );
        }
      ),
    );
  }
}