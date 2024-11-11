import 'dart:convert';
import 'dart:io';
import 'package:lernplatform/datenklassen/a_db_service_fragen.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'folder_types.dart';



class SubThema extends ContentCarrier {
  final List<int> tags; // Id's von Themen
  List<DB_Frage> fragen;

  SubThema({
    required int id,
    required String name,
    required this.tags,
    required this.fragen,
  }) : super(id: id, name: name){_loadFragen();}

  void _loadFragen() async{
    fragen = await FrageDBService(datei_name: "PV_WISO_Fragen").getByThemaID(id);
    // print_Yellow("SubThema fragen loaded fragen.length = ${fragen.length}"); // todo print
  }

  factory SubThema.fromJson(Map<String, dynamic> json) {
    return SubThema(
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

  static Future<SubThema> fromJsonFile(String path) async {
    final file = File(path);
    final contents = await file.readAsString();
    final json = jsonDecode(contents);
    return SubThema.fromJson(json);
  }

  int getTrueLengthOfFragen() {
    int counter = 0;
    for (DB_Frage frage in fragen) {
      if (frage.version == 1) counter++;
    }
    return counter;
  }
}














