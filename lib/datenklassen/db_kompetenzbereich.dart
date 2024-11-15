import 'dart:convert';
import 'dart:io';
import 'package:lernplatform/datenklassen/db_inhalt.dart';
import 'folder_types.dart';



class KompetenzBereich extends ContentCarrier {
  final List<int> tags; // Id's von Lernfeldern
  final List<Inhalt> inhalte;

  KompetenzBereich({
    required int id,
    required String name,
    required this.tags,
    required this.inhalte,
  }) : super(id: id, name: name);

  factory KompetenzBereich.fromJson(Map<String, dynamic> json) {
    List<Inhalt> inhalte = (json['inhalte'] as List?)
        ?.map((inhaltJson) => Inhalt.fromJson(inhaltJson))
        .toList() ?? [];

    return KompetenzBereich(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unbekanntes Thema',
      inhalte: inhalte,
      tags: List<int>.from(json['tags'] ?? []),
    );
  }
}






