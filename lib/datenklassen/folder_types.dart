import 'package:lernplatform/datenklassen/mokdaten.dart';
import 'lernfeld.dart';


class ContentCarrier {
  final int id;
  final String name;

  ContentCarrier({
    required this.id,
    required this.name,
  });
}

class Folder{
  final int id;
  final String name;
  final List<Folder> subFolder;
  final List<Lernfeld> lernFelder;

  Folder({
    required this.id,
    required this.name,
    required this.subFolder,
    required this.lernFelder,
  });
}
// todo
// Folder mok_Mainfolder = Folder(id: 1, name: "mok_MainFolder", lernFelder: [],
//   subFolder: [
//     Folder(id: 2, name: "Schulen",  lernFelder: [],
//       subFolder: [
//         Folder(id: 3, name: "ComCave", subFolder: [], lernFelder: [
//           mok_lernfelder[2],
//           mok_lernfelder[3],
//         ]),
//         Folder(id: 4, name: "GFN", subFolder: [], lernFelder: [
//           mok_lernfelder[0],
//           mok_lernfelder[1],
//         ]),
//       ],
//     ),
//     Folder(id: 5, name: "BMW", subFolder: [], lernFelder: [
//       mok_lernfelder[3],
//       mok_lernfelder[4],
//     ])
//   ],
// );