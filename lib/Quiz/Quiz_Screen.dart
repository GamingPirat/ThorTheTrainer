import 'package:flutter/material.dart';
import 'package:lernplatform/Quiz/quiz_model.dart';
import 'package:lernplatform/Quiz/quiz_thema.dart';
import 'package:lernplatform/Quiz/Frage_Widget.dart';
import 'package:lernplatform/Quiz/right_drawer.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/menu/my_static_menu.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';
import '../pages/progress_bar.dart';

List<QuizThema> mok_QuizThemen() {
  List<QuizThema> list = [];
  for (LogLernfeld loglernfeld in Session().user.teilnehmer.meineLernfelder) {
    for (LogThema logThema in loglernfeld.meineThemen) {
      list.add(QuizThema(logThema: logThema));
    }
  }
  return list;
}

class Quiz_Screen extends StatefulWidget {
  final List<QuizThema> quizThemen;

  Quiz_Screen({required this.quizThemen});

  @override
  _Quiz_ScreenState createState() => _Quiz_ScreenState();
}

class _Quiz_ScreenState extends State<Quiz_Screen> {
  late QuizModel viewModel;

  @override
  void initState() {
    super.initState();
    // Initialisiere das ViewModel nur einmal beim Start
    viewModel = QuizModel(quizThemen: widget.quizThemen);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<QuizModel>(
        builder: (context, vm, child) {
          return MyStaticMenu(
            content: Stack(
              children: [
                Column(
                  children: [
                    // ProgressBar(logThema: vm.aktuellesThema),
                    Expanded(
                      child: Frage_Widget(viewModel: vm.currentQuestioin),
                    ),
                    vm.isLocked
                        ? IconButton(
                      icon: const Icon(Icons.arrow_downward, color: Colors.white),
                      onPressed: () {
                        vm.nextTapped();
                        print("Qzizscreen:    nextTaped");
                      },
                    )
                        : ElevatedButton(
                      onPressed: () {
                        vm.lockTapped();
                      },
                      child: const Text("lock"),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                // Der nicht blockierende Drawer
                RightDrawer(isVisible: vm.isLocked),
              ],
            ),
          );
        },
      ),
    );
  }
}


