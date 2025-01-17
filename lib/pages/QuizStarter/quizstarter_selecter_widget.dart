import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/pages/progress_bar_widget.dart';
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
            margin: EdgeInsets.fromLTRB(160, 0, 160, 0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: vm.glowColor,
                  spreadRadius: 5,
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Abrundung nur im Child
              child: Container(
                padding: EdgeInsets.all(4),
                color: (Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF101010)
                    : Color(0xFFF0F0F0)),
                child: InkWell(
                  onTap: () => vm.isSelected = !vm.isSelected,
                  child: Center(child: ProgressWidget(viewModel: viewModel)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}