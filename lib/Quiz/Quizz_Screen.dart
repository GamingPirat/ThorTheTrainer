import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datenbank/frage_und_antwort.dart';
import 'Frage_Model.dart';
import 'Frage_Widget.dart';
import 'Jett.dart';
import 'Quizz_Model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Quizz_Screen(),
      theme: ThemeData.dark(),
    );
  }
}

class Quizz_Screen extends StatelessWidget {
  final Quizz_Model viewModel = Quizz_Model();

  Quizz_Screen({super.key});

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