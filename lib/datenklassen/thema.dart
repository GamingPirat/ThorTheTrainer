import 'dart:convert';
import 'dart:io';
import 'package:lernplatform/datenklassen/subthema.dart';
import 'folder_types.dart';



class Thema extends ContentCarrier {
  final List<int> tags; // Id's von Lernfeldern
  final List<SubThema> subthemen;

  Thema({
    required int id,
    required String name,
    required this.tags,
    required this.subthemen,
  }) : super(id: id, name: name);

  factory Thema.fromJson(Map<String, dynamic> json) {
    return Thema(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unbekannt',
      tags: json['tags'] != null ? List<int>.from(json['tags']) : [],
      subthemen: json['subthemen'] != null
          ? (json['subthemen'] as List<dynamic>)
          .map((subThemaJson) => SubThema.fromJson(subThemaJson))
          .toList()
          : [],
    );
  }

  static Future<Thema> fromJsonFile(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    return Thema.fromJson(json);
  }
}






