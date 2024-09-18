import 'package:lernplatform/datenklassen/view_builder.dart';

import 'folder_types.dart';

class Thema extends ContentContainer {
  final List<int> tags; // Id's von Lerfeldern
  final List<Frage> fragen;

  Thema({
    required int id,
    required String name,
    required this.tags,
    required this.fragen,
  }) : super(id: id, name: name);
}

List<Thema> mok_themen = [
  Thema(id: 1, name: "LF 1 T1", tags: [1], fragen: []),
  Thema(id: 2, name: "LF 1 T2", tags: [1], fragen: []),
  Thema(id: 3, name: "LF 1,2 T3", tags: [1,2], fragen: []),
  Thema(id: 4, name: "LF 1,2 T4", tags: [1,2], fragen: []),
];