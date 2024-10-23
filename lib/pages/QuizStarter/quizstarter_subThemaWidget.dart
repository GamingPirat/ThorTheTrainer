
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/personal_content_controllers.dart';
import 'package:provider/provider.dart';

class QuizStarterSubThemaWidget extends StatelessWidget {
  SubThema_Personal viewModel;
  QuizStarterSubThemaWidget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<SubThema_Personal>(
          builder: (context, vm, child) {
            return Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[850] : Colors.grey[300],
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: vm.isSelected ? Colors.blue : Colors.transparent,
                    spreadRadius: 5,
                    blurRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton(
              onPressed: () => vm.isSelected = !vm.isSelected,
              child: Text(vm.name),
            ),
          );
        }
      ),
    );
  }
}