import 'dart:convert';
import 'dart:io';
import 'package:lernplatform/datenklassen/db_subthema.dart';
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
      name: json['name'] ?? 'Unbekanntes Thema',
      subthemen: (json['subthemen'] as List)
          .map((subthemaJson) => SubThema.fromJson(subthemaJson))
          .toList(), tags: [],
    );
  }
}






