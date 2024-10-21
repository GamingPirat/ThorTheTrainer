import 'package:lernplatform/datenklassen/folder_types.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/print_colors.dart';

class Lernfeld extends ContentCarrier {
  final List<Thema> themen;

  Lernfeld({
    required int id,
    required String name,
    required this.themen,
  }) : super(id: id, name: name);

  factory Lernfeld.fromJson(Map<String, dynamic> json, lernfeldName) {
    print("Parsed Lernfeld Name: $lernfeldName");  // Debugging Print

    List<Thema> themen = (json['details'] as List)
        .map((themaJson) => Thema.fromJson(themaJson))
        .toList();

    return Lernfeld(
      id: json['id'] ?? 0,
      name: lernfeldName,
      themen: themen,
    );
  }



}

