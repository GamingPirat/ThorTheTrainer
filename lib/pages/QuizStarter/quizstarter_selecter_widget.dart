
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:provider/provider.dart';

class QuizStarterSelecterWidget extends StatelessWidget {
  UsersContentModel viewModel;
  QuizStarterSelecterWidget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<UsersContentModel>(
        builder: (context, vm, child) {
          return Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: vm.glowColor,
                  spreadRadius: 5,
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(2), // Eckenabrundung
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),  // Gleiche Eckenabrundung für Hover-Effekt
              child: Container(
                padding: EdgeInsets.all(4),
                color: vm.isSelected
                    ? (Theme.of(context).brightness == Brightness.dark ? Color(0xFF101010) : Color(0xFFF0F0F0))
                    : Colors.black.withOpacity(0.5),

                child: InkWell(
                  onTap: () => vm.isSelected = !vm.isSelected,
                  hoverColor: Colors.blue.withOpacity(0.2),
                  child: Center(child: Text(
                    vm.name,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  )),
                ),
              ),
            ),
          );


        },
      ),
    );
  }
}