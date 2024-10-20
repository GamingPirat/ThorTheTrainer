import 'dart:convert';
import 'dart:io';
import 'package:lernplatform/datenklassen/frage.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'folder_types.dart';



class SubThema extends ContentCarrier {
  final List<int> tags; // Id's von Themen
  final List<Frage> fragen;

  SubThema({
    required int id,
    required String name,
    required this.tags,
    required this.fragen,
  }) : super(id: id, name: name);

  factory SubThema.fromJson(Map<String, dynamic> json) {
    return SubThema(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unbekannt',
      tags: json['tags'] != null ? List<int>.from(json['tags']) : [],
      fragen: json['fragen'] != null
          ? (json['fragen'] as List<dynamic>)
          .map((frageJson) => Frage.fromJson(frageJson))
          .toList()
          : [],
    );
  }

  static Future<SubThema> fromJsonFile(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    return SubThema.fromJson(json);
  }

  int getTrueLengthOfFragen() {
    int counter = 0;
    for (Frage frage in fragen) {
      if (frage.version == 1) counter++;
    }
    return counter;
  }
}














