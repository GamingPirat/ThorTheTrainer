// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
// // import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
// import 'package:lernplatform/firebase_options.dart';
// import 'package:lernplatform/main.dart';
// import 'package:lernplatform/datenklassen/mok_user_model.dart';
// import 'package:lernplatform/session.dart';
// import 'package:provider/provider.dart';
//
// class TeilnehmerWidget extends StatelessWidget {
//
//   UserModel model = Session().user;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: model,
//       child: Consumer<UserModel>(
//         builder: (context, userModel, child) {
//             if (userModel.isLoading) {
//               return Center(child: CircularProgressIndicator());
//             }
//
//             final Teilnehmer teilnehmer = userModel.teilnehmer;
//             return Column(
//               children: [
//                 Text("teilnehmer key: ${teilnehmer.getKey}"),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: teilnehmer.meineLernfelder.length,
//                     itemBuilder: (context, index) {
//                       final lernfeld = teilnehmer.meineLernfelder[index];
//                       return Card(
//                         margin: EdgeInsets.all(8),
//                         child: ExpansionTile(
//                           title: Text('Lernfeld ID: ${lernfeld.id}\n'),
//                           children: lernfeld.meineThemen.map((thema) {
//                             return ExpansionTile(
//                               title: Text('Thema ID: ${thema.id}'),
//                               subtitle: Text('Fortschritt: ${(thema.getProgress() * 100).toStringAsFixed(1)}%'),
//                               children: thema.logSubthemen.map((subThema) {
//                                 return ListTile(
//                                   title: Text('SubThema: ${subThema.name}'),
//                                   subtitle: Text('Fortschritt: ${(subThema.getProgress() * 100).toStringAsFixed(1)}%'),
//                                 );
//                               }).toList(),
//                             );
//                           }).toList(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//
//         },
//         ),
//     );
//   }
// }
//
// // TestApp zum Testen des Widgets
// class TestApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(), // Dark Mode aktiviert
//       home: TeilnehmerWidget(), // Direkt das TeilnehmerWidget anzeigen
//     );
//   }
// }
//
// // void main() => runApp(TestApp());
//
//
//
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   FirebaseFirestore.instance.settings = Settings( // macht alles kostengünstiger
//     persistenceEnabled: true,
//     cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
//   );
//   runApp(
//       ChangeNotifierProvider(
//         create: (_) => ThemeNotifier(), // Für das Theme
//         child: TestApp(),
//       )
//   );
// }
