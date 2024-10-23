
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
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: vm.isSelected ? Colors.blue : Colors.transparent,
                  spreadRadius: 5,
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(16), // Eckenabrundung
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),  // Gleiche Eckenabrundung für Hover-Effekt
              child: Container(
                padding: EdgeInsets.all(4),
                color: vm.isSelected ? Color(0xFF101010) : Colors.transparent,
                child: InkWell(
                  onTap: () => vm.isSelected = !vm.isSelected,
                  hoverColor: Colors.blue.withOpacity(0.2),
                  child: Center(child: Text(vm.name)),
                ),
              ),
            ),
          );


        },
      ),
    );
  }
}