import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'quiz_antwort_model.dart';

class QuizAntwortenWidget extends StatelessWidget {
  final List<QuizAntwortModel> viewModels;

  const QuizAntwortenWidget({required this.viewModels, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModels.length,
      itemBuilder: (context, index) {
        final model = viewModels[index];
        return ChangeNotifierProvider.value(
          value: model,
          child: Consumer<QuizAntwortModel>(
              builder: (context, vm, child) {
                return GestureDetector(
                  onTap: () {
                    vm.clicked();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(
                          vm.isMultipleChoice ? 0 : 100),
                      boxShadow: [
                        BoxShadow(
                          color: vm.color,
                          spreadRadius: 5,
                          blurRadius: 12,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Füge diese Zeile hinzu
                      children: [
                        Text(
                          vm.antwort.text,
                        ),
                        Visibility(
                          visible: vm.erklaerungVisible,
                          child: Text(
                            vm.antwort.erklaerung,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        );
      },
    );
  }
}
