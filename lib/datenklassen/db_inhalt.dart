import 'dart:convert';
import 'dart:io';
import 'package:lernplatform/datenklassen/a_db_service_fragen.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'folder_types.dart';



class Inhalt extends ContentCarrier {
  final List<int> tags;
  late List<DB_Frage>? fragen;

  Inhalt({
    required int id,
    required String name,
    required this.tags,
    this.fragen,
    // required this.fragen,
  }) : super(id: id, name: name){}

  void loadFragen() async{
    fragen = await FrageDBService().getByInhaltID(id);
    print_Yellow("Inhalt fragen loaded fragen.length = ${fragen!.length}"); // todo print
  }

  factory Inhalt.fromJson(Map<String, dynamic> json) {
    return Inhalt(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unbekannt',
      tags: json['tags'] != null ? List<int>.from(json['tags']) : [],
      fragen: json['fragen'] != null
          ? (json['fragen'] as List<dynamic>)
          .map((frageJson) => DB_Frage.fromJson(frageJson))
          .toList()
          : [],
    );
  }

  static Future<Inhalt> fromJsonFile(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    return Inhalt.fromJson(json);
  }

  int getTrueLengthOfFragen() {
    int counter = 0;
    for (DB_Frage frage in fragen!) {
      if (frage.version == 1) counter++;
    }
    return counter;
  }
}














