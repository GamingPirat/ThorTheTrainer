import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/quiz_model.dart';
import 'package:lernplatform/Quiz/quiz_teilnehmer.dart';
import 'package:lernplatform/Quiz/Frage_Widget.dart';
import 'package:lernplatform/Quiz/speicher_fortschritt_anzeige.dart';
import 'package:lernplatform/a_only_for_demonstration.dart';
import 'package:lernplatform/user_session.dart';
import 'package:provider/provider.dart';
import '../pages/progress_bar.dart';

class Quiz_Screen extends StatelessWidget {
  final QuizModel viewModel = QuizModel(
      quizTeilnehmer: QuizTeilnehmer(teilnehmer: mok_teilnehmer));

  Quiz_Screen({super.key}) {

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<QuizModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: UserSession().appBar,
            drawer: UserSession().drawer,
            body: Stack(
              children: [
                Column(
                  children: [
                    ProgressBar(logThema: vm.aktuellesThema,),
                    Expanded(
                      child: Frage_Widget(
                          viewModel: vm.currentQuestioin)
                    ),

                    vm.isLocked
                        ? IconButton(
                      icon: const Icon(Icons.arrow_downward, color: Colors.white),
                      onPressed: () {
                        vm.nextTapped(); // Setzt isLocked auf false
                        // Slide die Column nach oben
                      },
                    )
                        : ElevatedButton(
                      onPressed: vm.lockTapped, // Setzt isLocked auf true
                      child: const Text("lock"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(DemonstrationApp(home: Quiz_Screen()));
}
