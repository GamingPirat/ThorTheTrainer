import 'package:flutter/material.dart';
import 'package:lernplatform/a_only_for_demonstration.dart';
import 'package:lernplatform/datenklassen/view_builder.dart';
import 'package:provider/provider.dart';
import 'Antwort_Widget.dart';
import 'Frage_Model.dart';

class Frage_Widget extends StatelessWidget {
  late Frage_Model viewModel;

  Frage_Widget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<Frage_Model>(
          builder: (context, vm, child) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    vm.titel,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Antworten_Widget(viewModels: vm.antworten),
                  SizedBox(height: 36,),
                ],
              ),
            );
          }
      ),
    );
  }
}

void main(){
  runApp(
      DemonstrationApp(
          home: DemonstrationPage(
            testWidget: Frage_Widget(
                viewModel: Frage_Model(
                    frage: mok_fragen_zuThema1[2])
            ),
          )
      )
  );
}
