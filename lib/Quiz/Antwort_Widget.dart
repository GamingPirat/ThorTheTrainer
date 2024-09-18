import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Antwort_Model.dart';
import 'Frage_Model.dart';

class Antworten_Widget extends StatelessWidget {
  final List<Antwort_Model> viewModels;

  const Antworten_Widget({required this.viewModels, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: viewModels.length,
      itemBuilder: (context, index) {
        final model = viewModels[index];
        return ChangeNotifierProvider.value(
          value: model,
          child: Consumer<Antwort_Model>(
              builder: (context, vm, child) {
                return GestureDetector(
                  onTap: () {
                    vm.clicked();
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
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
                          vm.antwort.titel,
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
