import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/Quiz_Screen.dart';
import 'package:lernplatform/Testbereich.dart';
import 'package:lernplatform/a_only_for_demonstration.dart';
import 'package:lernplatform/user_session.dart';
import 'package:provider/provider.dart';
import 'Frage_Model.dart';
import 'Frage_Widget.dart';
import 'Jett.dart';
import 'Quizz_Model.dart';

class Quizz_Screen extends StatelessWidget {
  final Quizz_Model viewModel = Quizz_Model();

  Quizz_Screen({super.key}) {
    UserSession().pageHeader = QuizAppbarWidget(key: viewModel.quizfortschritt,);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<Quizz_Model>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                AnimatedProgressBar(width: vm.width),
                Frage_Widget(
                  viewModel: vm.frageModel,
                ),
                ElevatedButton(
                    onPressed: vm.btn_clicked,
                    child: Text(vm.isLocked ? "next" : "lock")
                )
              ],
            )
          );
        },
      ),
    );
  }
}




void main() {
  runApp(DemonstrationApp(home: Quiz_Screen()));
}