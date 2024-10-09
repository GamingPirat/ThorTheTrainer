import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/quiz_model.dart';
import 'package:lernplatform/Quiz/quiz_teilnehmer.dart';
import 'package:lernplatform/Quiz/Frage_Widget.dart';
import 'package:lernplatform/Quiz/right_drawer.dart';
import 'package:lernplatform/menu/my_static_menu.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';
import '../pages/progress_bar.dart';

class Quiz_Screen extends StatelessWidget {
  late final QuizModel viewModel;

  Quiz_Screen({required QuizTeilnehmer quizTeilnehmer}){
    viewModel = QuizModel(quizTeilnehmer: quizTeilnehmer);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<QuizModel>(
        builder: (context, vm, child) {
          return MyStaticMenu(
            content: vm.isLoading
              ? CircularProgressIndicator()
              : Stack(
              children: [
                Column(
                  children: [
                    ProgressBar(logThema: vm.aktuellesThema),
                    Expanded(
                      child: Frage_Widget(viewModel: vm.currentQuestioin),
                    ),
                    vm.isLocked
                        ? IconButton(
                      icon: const Icon(Icons.arrow_downward, color: Colors.white),
                      onPressed: () {
                        vm.nextTapped();
                      },
                    )
                        : ElevatedButton(
                      onPressed: () {
                        // vm.lockTapped();
                      },
                      child: const Text("lock"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),

                // Der nicht blockierende Drawer
                RightDrawer(isVisible: vm.isLocked,),

              ],
            ),
          );
        },
      ),
    );
  }
}
