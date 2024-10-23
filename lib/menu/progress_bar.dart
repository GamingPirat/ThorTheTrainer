import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/personal_content_controllers.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
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
                      widthFactor: vm.progress,
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
                  Center(child: Text("${(vm.progress * 100).toStringAsFixed(0)}%"),),
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

// TestApp for testing
class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Lernfeld_Personal testModel = Lernfeld_Personal(
      logLernfeld: LogLernfeld(1, []),
      l: Lernfeld_DB(id: 1, name: 'Das n langes Lernfeld', themen: []),
    );

    TextEditingController progressController = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Progress Widget")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressWidget(
                viewModel: testModel,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    child: TextField(
                      controller: progressController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Progress",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Hier kommt der Builder, um den korrekten Kontext für ScaffoldMessenger zu bekommen
                  Builder(
                    builder: (BuildContext newContext) {
                      return ElevatedButton(
                        onPressed: () {
                          double? newProgress = double.tryParse(progressController.text);
                          if (newProgress != null && newProgress >= 0 && newProgress <= 1) {
                            testModel.progress = newProgress; // Setzt den neuen progress-Wert
                          } else {
                            // Verwende den Kontext aus dem Builder, um den ScaffoldMessenger zu erreichen
                            ScaffoldMessenger.of(newContext).showSnackBar(
                              SnackBar(content: Text("Bitte eine Zahl zwischen 0 und 1 eingeben.")),
                            );
                          }
                        },
                        child: Text("Set Progress"),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() => runApp(TestApp());
