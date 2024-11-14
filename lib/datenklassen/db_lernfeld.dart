import 'package:lernplatform/datenklassen/folder_types.dart';
import 'package:lernplatform/datenklassen/db_kompetenzbereich.dart';
import 'package:lernplatform/globals/print_colors.dart';

class Lernfeld extends ContentCarrier {
  final List<KompetenzBereich> kompetenzbereiche;

  Lernfeld({
    required int id,
    required String name,
    required this.kompetenzbereiche,
  }) : super(id: id, name: name);

  factory Lernfeld.fromJson(Map<String, dynamic> json) {
    List<KompetenzBereich> kompetenzbereiche = (json['kompetenzbereiche'] as List?)
        ?.map((themaJson) => KompetenzBereich.fromJson(themaJson))
        .toList() ?? [];

    return Lernfeld(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Lernfeldname konnte nicht gelesen werden",
      kompetenzbereiche: kompetenzbereiche,
    );
  }


  @override
  String toString() {
    return 'Lernfeld_DB{id: $id, name: $name, kompetenzbereiche: $kompetenzbereiche}';
  }
}