import 'package:flutter/material.dart';
import 'package:lernplatform/pages/Quiz/Frage_Widget.dart';
import 'package:lernplatform/pages/Quiz/new_quizsubthema_model.dart';
import 'package:lernplatform/pages/progress_bar_widget.dart';
import 'package:provider/provider.dart';

class NewQuizSubthemaWidget extends StatelessWidget {
  NewQuizsubthemaModel viewModel;

  NewQuizSubthemaWidget({required this.viewModel, super.key});

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
                FrageWidget(viewModel: vm.random_question,),
              ],
                        ),
            );
        }
      ),
    );
  }
}