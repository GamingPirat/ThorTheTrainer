import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_inhalt_viewmodel.dart';
import 'package:lernplatform/pages/progress_bar_widget.dart';
import 'package:provider/provider.dart';

class ExpandableWidget extends StatefulWidget {
  final UsersContentModel usersViewModel;
  final List<Widget> children;

  ExpandableWidget({required this.usersViewModel, required this.children});

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isExpanded = false; // Kontrolliert, ob das Widget ausgeklappt ist

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.usersViewModel,
      child: Consumer<UsersContentModel>(
        builder: (context, vm, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: vm is UsersKompetenzbereich
                      ? EdgeInsets.fromLTRB(80, 0, 80, 0)
                      : EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => vm.isSelected = !vm.isSelected,
                              child: Center(child: ProgressWidget(viewModel: vm)),
                            ),
                          ),
                          IconButton(
                            icon: Icon(isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more), // Pfeil-Icon abhängig vom Status
                            onPressed: toggleExpanded, // Klick-Event
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (isExpanded)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: widget.children
                        .map((child) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: child,
                    ))
                        .toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}