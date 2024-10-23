//
// import 'package:lernplatform/datenklassen/db_lernfeld.dart';
// import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
// import 'package:lernplatform/datenklassen/mokdaten.dart';
// import 'package:lernplatform/datenklassen/db_subthema.dart';
// import 'package:lernplatform/datenklassen/db_thema.dart';
// import 'package:lernplatform/session.dart';
//
// Thema convertToThema({required LogThema logthema}){
//
//   for(Lernfeld_DB lernfeld in Session().user.usersLernfelder)
//     for(Thema thema in lernfeld.themen)
//       if (thema.id == logthema.id)
//         return thema;
//
//   return Thema(id: 9999999, name: "Thema nicht vorhanden", tags: [], subthemen: []);
// }
//
// SubThema convertToSubThema({required LogSubThema logthema}){
//
//   for(Lernfeld_DB lernfeld in Session().user.usersLernfelder)
//     for(Thema thema in lernfeld.themen)
//       for(SubThema subthema in thema.subthemen)
//         if (subthema.id == logthema.id)
//           return subthema;
//
//   return SubThema(id: 9999999, name: "SubThema nicht vorhanden", tags: [], fragen: []);
// }