// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lernplatform/datenklassen/a_db_service_fragen.dart';
// import 'dart:convert';
// import 'package:lernplatform/datenklassen/db_frage.dart';
// import 'package:lernplatform/firabase/firebase_options.dart';
//
// class JsonInputApp extends StatefulWidget {
//   @override
//   _JsonInputAppState createState() => _JsonInputAppState();
// }
//
// class _JsonInputAppState extends State<JsonInputApp> {
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _fileNameController = TextEditingController();
//   FrageDBService? _frageDBService;
//
//   // Methode zum Abschicken der Liste von Objekten
//   void _submitJsonList() async {
//     if (_fileNameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Bitte geben Sie einen Dateinamen an.')),
//       );
//       return;
//     }
//
//     _frageDBService = FrageDBService();
//
//     try {
//       List<dynamic> jsonData = jsonDecode(_controller.text);
//       List<DB_Frage> fragen = jsonData.map((item) => DB_Frage.fromJson(item)).toList();
//
//       for (var frage in fragen) {
//         await _frageDBService!.createFrage(frage);
//       }
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Fragenliste erfolgreich gespeichert!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Fehler beim Einfügen der Fragen: $e')),
//       );
//     }
//   }
//
//   // Methode zum Abschicken eines einzelnen Objekts
//   void _submitSingleJson() async {
//     if (_fileNameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Bitte geben Sie einen Dateinamen an.')),
//       );
//       return;
//     }
//
//     _frageDBService = FrageDBService();
//
//     try {
//       Map<String, dynamic> jsonData = jsonDecode(_controller.text);
//       DB_Frage frage = DB_Frage.fromJson(jsonData);
//
//       await _frageDBService!.createFrage(frage);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Einzelne Frage erfolgreich gespeichert!')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Fehler beim Einfügen der Frage: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('JSON Fragen Input')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _fileNameController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Dateiname eingeben',
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: TextField(
//                 controller: _controller,
//                 maxLines: null,
//                 expands: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'JSON-Liste oder einzelnes Objekt hier einfügen',
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _submitJsonList,
//                     child: Text('Liste abschicken'),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _submitSingleJson,
//                     child: Text('Einzelnes Objekt abschicken'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   FirebaseFirestore.instance.settings = Settings( // macht alles kostengünstiger
//     persistenceEnabled: true,
//     cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
//   );
//   runApp(MaterialApp(theme: ThemeData.dark(),home: JsonInputApp()));
// }