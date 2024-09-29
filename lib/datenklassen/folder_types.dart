import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/datenklassen/view_builder.dart';


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
    required int id,
    required String name,
    required this.subFolder,
    required this.lernFelder,
  }) : super(id: id, name: name);
}

Folder mok_Mainfolder = Folder(id: 1, name: "mok_MainFolder", lernFelder: [],
  subFolder: [
    Folder(id: 2, name: "Schulen",  lernFelder: [],
      subFolder: [
        Folder(id: 3, name: "ComCave", subFolder: [], lernFelder: [
          mok_lernfelder[2],
          mok_lernfelder[3],
        ]),
        Folder(id: 4, name: "GFN", subFolder: [], lernFelder: [
          mok_lernfelder[0],
          mok_lernfelder[1],
        ]),
      ],
    ),
    Folder(id: 5, name: "BMW", subFolder: [], lernFelder: [
      mok_lernfelder[3],
      mok_lernfelder[4],
    ])
  ],
);

class Lernfeld extends ContentContainer{
  final List<Thema> themen;

  Lernfeld({
    required int id,
    required String name,
    required this.themen,
  }) : super(id: id, name: name);
}

List<Lernfeld> mok_lernfelder = [
  Lernfeld(id: 1, name: "Lernfeld 1 der Fachinformatiker", themen: []),
  Lernfeld(id: 2, name: "Lernfeld 2 der Fachinformatiker", themen: []),
  Lernfeld(id: 3, name: "FSM I", themen: []),
  Lernfeld(id: 4, name: "FSM II", themen: []),
  Lernfeld(id: 5, name: "Mobile", themen: []),
  Lernfeld(id: 6, name: "Web", themen: []),
];

Folder mok_TeilnehmerFolder = Folder(id: 9999999, name: "mok_TeilnehmerFolder", subFolder: [], lernFelder: mok_lernfelder);