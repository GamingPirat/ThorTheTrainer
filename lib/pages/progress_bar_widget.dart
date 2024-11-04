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
        return Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${vm.name}",
                softWrap: false,
                overflow: TextOverflow.clip,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: FractionallySizedBox(
                      // widthFactor: 0.5,
                      widthFactor: vm.progress == null ? 0 : vm.progress / 100,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  // Center(child: Text("${(vm.progress).toStringAsFixed(0)}%"),),
                  Center(
                    child: Text("${((vm.progress * 10).floor() / 10).toStringAsFixed(1)}%"),
                  ),

                  // Positioned.fill(
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       child: Text("${vm.name}" ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
