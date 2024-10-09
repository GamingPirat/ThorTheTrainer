import 'dart:convert'; // Für JSON-Konvertierung
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'folder_types.dart';
import 'dart:io';

class Lernfeld extends ContentContainer {
  final List<Thema> themen;

  Lernfeld({
    required int id,
    required String name,
    required this.themen,
  }) : super(id: id, name: name);

  factory Lernfeld.fromJson(Map<String, dynamic> json) {
    return Lernfeld(
      id: json['id'],
      name: json['name'],
      themen: (json['themen'] as List<dynamic>?)
          ?.map((themaJson) => Thema.fromJson(themaJson))
          .toList() ??
          [],
    );
  }

  static Future<Lernfeld> fromJsonFile(int id) async {
    final file = File('assets/test_lernfelder');
    final contents = await file.readAsString();
    final json = jsonDecode(contents);

    // Die Lernfelder werden als Liste erwartet, also nach dem ID suchen.
    final lernfelder = (json['lernfelder'] as List<dynamic>?)
        ?.firstWhere((lf) => lf['id'] == id, orElse: () => null);

    if (lernfelder == null) {
      throw Exception("Lernfeld mit ID $id nicht gefunden.");
    }

    return Lernfeld.fromJson(lernfelder);
  }
}


class LogLernfeld {
  int id;
  List<LogThema> meineThemen;

  LogLernfeld(this.id, this.meineThemen);
//
}

List<LogLernfeld> mok_lernfelder = [
  LogLernfeld(1, [mok_lokThemen[0], mok_lokThemen[1], ]),
  LogLernfeld(2, [mok_lokThemen[2], mok_lokThemen[3], ]),
];

class LogFrage {
  String id;

  LogFrage(this.id);


}