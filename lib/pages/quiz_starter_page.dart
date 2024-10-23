// import 'package:flutter/material.dart';
// import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
// import 'package:lernplatform/pages/progress_bar.dart';
// import 'package:lernplatform/session.dart';
//
// class ProgressBarList extends StatelessWidget {
//   final List<LogSubThema> logThemen;
//
//   const ProgressBarList({required this.logThemen});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: logThemen.length,
//       itemBuilder: (context, index) {
//         return ProgressBar(logThema: logThemen[index]);
//       },
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(), // Dark Mode Theme
//       home: TestProgressBarScreen(),
//     );
//   }
// }
//
// class TestProgressBarScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Beispiel-Daten für LogThema-Liste (muss durch echte Daten aus teilnehmer ersetzt werden)
//     // List<LogThema> logThemen = [
//     //   LogThema(id: 1, falschBeantworteteFragen: [], richtigBeantworteteFragen: ['frage_1_1', 'frage_2_1']),
//     //   LogThema(id: 2, falschBeantworteteFragen: ['frage_3_0'], richtigBeantworteteFragen: ['frage_4_1']),
//     //   LogThema(id: 3, falschBeantworteteFragen: ['frage_5_0'], richtigBeantworteteFragen: []),
//     // ];
//     List<LogSubThema> logThemen = [];
//     for( LogLernfeld logLernfeld in Session().user.teilnehmer.meineLernfelder)
//       for( LogThema logThema in logLernfeld.meineThemen)
//       for( LogSubThema logSubThema in logThema.logSubthemen)
//         logThemen.add(logSubThema);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ProgressBar Test"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ProgressBarList(logThemen: logThemen),
//       ),
//     );
//   }
// }
