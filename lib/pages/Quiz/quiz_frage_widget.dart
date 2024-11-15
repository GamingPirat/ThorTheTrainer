import 'package:flutter/material.dart';
import 'package:lernplatform/pages/Quiz/right_drawer_on_frage.dart';
import 'package:provider/provider.dart';
import 'quiz_antworten_widget.dart';
import 'quiz_frage_model.dart';

class QuizFrageWidget extends StatelessWidget {
  late QuizFrageModel viewModel;

  QuizFrageWidget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<QuizFrageModel>(
          builder: (context, vm, child) {
            return Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          vm.titel,
                          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        QuizAntwortenWidget(viewModels: vm.antwortenViewModel),
                        Spacer(),
                        Visibility(
                          visible: !vm.locked,
                          child: ElevatedButton(
                            onPressed: () {
                              vm.onLockTapped();
                            },
                            child: const Text("lock"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RightDrawer(isVisible: vm.locked, db_frage: vm.frage,),
                ],
              ),
            );
          }
      ),
    );
  }
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized(); // Stelle sicher, dass die Bindings initialisiert sind
//
//   runApp(
//     MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Frage Demo")),
//         body: FutureBuilder<List<Frage>>(
//           future: await Thema_JSONService().load('assets/test_thema.json').fragen, // Lade die Fragen aus der JSON-Datei
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator()); // Zeige Ladeindikator
//             } else if (snapshot.hasError) {
//               return Center(
//                   child: Text("Fehler beim Laden der Daten: ${snapshot.error}")); // Fehler behandeln
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return const Center(child: Text("Keine Fragen gefunden")); // Keine Daten gefunden
//             } else {
//               // Gebe das erste Element der Fragen an das Widget weiter
//               return Frage_Widget(
//                 viewModel: Frage_Model(
//                   frage: snapshot.data!.first, // Das erste Element der geladenen Fragen
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     ),
//   );
// }