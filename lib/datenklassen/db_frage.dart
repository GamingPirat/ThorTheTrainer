import 'package:lernplatform/datenklassen/db_antwort.dart';

class DB_Frage {
  int nummer;
  int version;
  int inhalt_id;
  int punkte;
  String text;
  List<Antwort> antworten;

  DB_Frage({
    required this.nummer,
    required this.version,
    required this.inhalt_id,
    required this.punkte,
    required this.text,
    required this.antworten,
  });

  String get id => "${inhalt_id}_${nummer}_$version";

  // fromJson factory method
  factory DB_Frage.fromJson(Map<String, dynamic> json) {
    var antwortenJson = json['antworten'] as List<dynamic>;
    List<Antwort> antwortenList = antwortenJson.map((item) => Antwort.fromJson(item as Map<String, dynamic>)).toList();

    return DB_Frage(
      nummer: json['nummer'] ?? 0,
      version: json['version'] ?? 0,
      inhalt_id: json['inhalt_id'] ?? 0,
      punkte: json['punkte'] ?? 0,
      text: json['text'] ?? "Frage konte nicht geladen werden",
      antworten: antwortenList,
    );
  }


  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'nummer': nummer,
      'version': version,
      'inhalt_id': inhalt_id,
      'punkte': punkte,
      'text': text,
      'antworten': antworten.map((antwort) => antwort.toJson()).toList(),
    };
  }

  // copyWith method
  DB_Frage copyWith({
    int? nummer,
    int? version,
    int? inhalt_id,
    int? punkte,
    String? text,
    List<Antwort>? antworten,
  }) {
    return DB_Frage(
      nummer: nummer ?? this.nummer,
      version: version ?? this.version,
      inhalt_id: inhalt_id ?? this.inhalt_id,
      punkte: punkte ?? this.punkte,
      text: text ?? this.text,
      antworten: antworten ?? this.antworten,
    );
  }


  @override
  String toString() {
    return 'Frage $nummer: $text\nAntworten:\n${antworten.map((a) => a.toString()).join('\n')}';
  }
}