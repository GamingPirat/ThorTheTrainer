import 'package:flutter/material.dart';
import 'package:lernplatform/pages/Quiz/quiz_frage_widget.dart';
import 'package:lernplatform/pages/Quiz/quiz_subthema_model.dart';
import 'package:lernplatform/pages/progress_bar_widget.dart';
import 'package:provider/provider.dart';

class QuizSubthemaWidget extends StatelessWidget {
  NewQuizsubthemaModel viewModel;

  QuizSubthemaWidget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<NewQuizsubthemaModel>(
          builder: (context, vm, child) {
            return Container(
              child: vm.isLoading
                  ? CircularProgressIndicator()
                  : Column(
              children: [
                Center(
                  child: ProgressWidget(viewModel: viewModel.selected_subthema)
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