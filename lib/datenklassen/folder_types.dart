import 'package:lernplatform/datenklassen/mokdaten.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/datenklassen/frage.dart';

import 'lernfeld.dart';


class ContentContainer {
  final int id;
  final String name;

  ContentContainer({
    required this.id,
    required this.name,
  });
}

class Folder extends ContentContainer{
  final List<Folder> subFolder;
  final List<Lernfeld> lernFelder;

  Folder({
    required int pk,
    required String name,
    required this.subFolder,
    required this.lernFelder,
  }) : super(id: pk, name: name);
}

Folder mok_Mainfolder = Folder(pk: 1, name: "mok_MainFolder", lernFelder: [],
  subFolder: [
    Folder(pk: 2, name: "Schulen",  lernFelder: [],
      subFolder: [
        Folder(pk: 3, name: "ComCave", subFolder: [], lernFelder: [
          mok_lernfelder[2],
          mok_lernfelder[3],
        ]),
        Folder(pk: 4, name: "GFN", subFolder: [], lernFelder: [
          mok_lernfelder[0],
          mok_lernfelder[1],
        ]),
      ],
    ),
    Folder(pk: 5, name: "BMW", subFolder: [], lernFelder: [
      mok_lernfelder[3],
      mok_lernfelder[4],
    ])
  ],
);