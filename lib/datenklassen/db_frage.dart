import 'package:lernplatform/datenklassen/db_antwort.dart';

class DB_Frage {
  final int nummer;
  final int version;
  final int themaID;
  final int punkte;
  final String text;
  final List<Antwort> antworten;

  DB_Frage({
    required this.nummer,
    required this.version,
    required this.themaID,
    required this.punkte,
    required this.text,
    required this.antworten,
  });

  String get id => "${themaID}_${nummer}_$version";

  // fromJson factory method
  factory DB_Frage.fromJson(Map<String, dynamic> json) {
    var antwortenJson = json['antworten'] as List<dynamic>;
    List<Antwort> antwortenList = antwortenJson.map((item) => Antwort.fromJson(item as Map<String, dynamic>)).toList();

    return DB_Frage(
      nummer: json['nummer'],
      version: json['version'],
      themaID: json['themaID'],
      punkte: json['punkte'],
      text: json['text'],
      antworten: antwortenList,
    );
  }


  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'nummer': nummer,
      'version': version,
      'themaID': themaID,
      'punkte': punkte,
      'text': text,
      'antworten': antworten.map((antwort) => antwort.toJson()).toList(),
    };
  }

  // copyWith method
  DB_Frage copyWith({
    int? nummer,
    int? version,
    int? themaID,
    int? punkte,
    String? text,
    List<Antwort>? antworten,
  }) {
    return DB_Frage(
      nummer: nummer ?? this.nummer,
      version: version ?? this.version,
      themaID: themaID ?? this.themaID,
      punkte: punkte ?? this.punkte,
      text: text ?? this.text,
      antworten: antworten ?? this.antworten,
    );
  }


  @override
  String toString() {
    return 'Frage $nummer: $text\nAntworten:\n${antworten.map((a) => a.toString()).join('\n')}';
  }}








