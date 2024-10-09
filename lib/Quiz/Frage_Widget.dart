import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Antwort_Widget.dart';
import 'Frage_Model.dart';

class Frage_Widget extends StatelessWidget {
  late Frage_Model viewModel;

  Frage_Widget({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<Frage_Model>(
          builder: (context, vm, child) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    vm.titel,
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  Antworten_Widget(viewModels: vm.antwortenViewModel),
                  SizedBox(height: 36,),
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