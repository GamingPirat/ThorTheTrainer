import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:provider/provider.dart';
class ProgressWidget extends StatefulWidget {
  final UsersContentModel viewModel;

  ProgressWidget({required this.viewModel});

  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.viewModel,
      child: Consumer<UsersContentModel>(builder: (context, vm, child) {
        final progress = (vm.progress ?? 0).clamp(0, 100) / 100; // Sicherheit
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${vm.name}",
                softWrap: false,
                overflow: TextOverflow.clip,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              Stack(
                children: [
                  // Hintergrund (Grau)
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]
                          : Colors.grey[300],
                    ),
                  ),
                  // Fortschrittsbalken (Grün)
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  // Fortschrittsanzeige (Text)
                  Center(
                    child: Text(
                      "${(progress * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
