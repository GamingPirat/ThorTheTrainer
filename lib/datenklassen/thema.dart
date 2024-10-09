import 'dart:convert';
import 'dart:io';
import 'package:lernplatform/datenklassen/frage.dart';
import 'folder_types.dart';



class Thema extends ContentContainer {
  final List<int> tags; // Id's von Lernfeldern
  final List<Frage> fragen;

  Thema({
    required int id,
    required String name,
    required this.tags,
    required this.fragen,
  }) : super(id: id, name: name);

  factory Thema.fromJson(Map<String, dynamic> json) {
    return Thema(
      id: json['id'],
      name: json['name'],
      tags: List<int>.from(json['tags'] ?? []), // Sicherheit hinzufügen, um leere Tags zu vermeiden
      fragen: (json['fragen'] as List<dynamic>?)?.map((frageJson) => Frage.fromJson(frageJson)).toList() ?? [], // Fragen korrekt dekodieren
    );
  }

  static Future<Thema> fromJsonFile(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    return Thema.fromJson(json);
  }

  int getTrueLengthOfFragen() {
    int counter = 0;
    for (Frage frage in fragen) {
      if (frage.version == 1) counter++;
    }
    return counter;
  }
}






