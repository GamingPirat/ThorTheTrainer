import 'package:lernplatform/datenklassen/folder_types.dart';
import 'package:lernplatform/datenklassen/db_thema.dart';
import 'package:lernplatform/globals/print_colors.dart';

class Lernfeld_DB extends ContentCarrier {
  final List<Thema> themen;

  Lernfeld_DB({
    required int id,
    required String name,
    required this.themen,
  }) : super(id: id, name: name);

  factory Lernfeld_DB.fromJson(Map<String, dynamic> json) {
    print_Yellow("$json");  // Debugging Print

    List<Thema> themen = (json['details'] as List)
        .map((themaJson) => Thema.fromJson(themaJson))
        .toList();

    return Lernfeld_DB(
      id: json['id'] ?? 0,
      name: json['name'] ?? "Lernfeldname konnte nicht gelesen werden",
      themen: themen,
    );
  }
}