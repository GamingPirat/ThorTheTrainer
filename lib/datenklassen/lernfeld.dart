import 'package:lernplatform/datenklassen/thema.dart';
import 'folder_types.dart';

class Lernfeld extends ContentContainer {
  final List<Thema> themen;

  Lernfeld({
    required int id,
    required String name,
    required this.themen,
  }) : super(id: id, name: name);

}

