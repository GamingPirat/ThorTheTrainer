import 'package:lernplatform/datenklassen/mokdaten.dart';
import 'package:lernplatform/datenklassen/thema.dart';

List<Frage> convertToFragen({required List<String> logFragen}){
  List<Frage> returnValue = [];
  // hol dir das zugehörige Thema
  Thema thema = Thema(
      id: 999999,
      name: "Thema existiert nicht",
      tags: [],
      fragen: []
  );
  // durchsuche themen und finde das richtige
  int searchForThemaID =  int.parse(logFragen[0].split('_')[0]);
  for(Thema current in mok_themen){
    if(current.id == searchForThemaID){
      thema = current;
      break;
    }
  }
  // und iterriee dann durch dessen Fragen während du nach der id suchst
  for(String logfrage in logFragen){
    for (Frage current in thema.fragen) {
      if(current.id == logfrage)
        returnValue.add(current);
    }
  }
  return returnValue;
}

class Frage {
  final int nummer;
  final int version;
  final int themaID;
  final int punkte;
  final String text;
  final List<Antwort> antworten;

  Frage({
    required this.nummer,
    required this.version,
    required this.themaID,
    required this.punkte,
    required this.text,
    required this.antworten,
  });

  String get id => "${themaID}_${nummer}_$version";

  // fromJson factory method
  factory Frage.fromJson(Map<String, dynamic> json) {
    var antwortenJson = json['antworten'] as List<dynamic>;
    List<Antwort> antwortenList = antwortenJson.map((item) => Antwort.fromJson(item as Map<String, dynamic>)).toList();

    return Frage(
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
  Frage copyWith({
    int? nummer,
    int? version,
    int? themaID,
    int? punkte,
    String? text,
    List<Antwort>? antworten,
  }) {
    return Frage(
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

class Antwort {
  final String text;
  final String erklaerung;
  final bool isKorrekt;

  Antwort({
    required this.text,
    required this.erklaerung,
    required this.isKorrekt,
  });

  // fromJson factory method
  factory Antwort.fromJson(Map<String, dynamic> json) {
    return Antwort(
      text: json['text'],
      erklaerung: json['erklaerung'],
      isKorrekt: json['isKorrekt'],
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'erklaerung': erklaerung,
      'isKorrekt': isKorrekt,
    };
  }

  // copyWith method
  Antwort copyWith({
    String? text,
    String? erklaerung,
    bool? isKorrekt,
  }) {
    return Antwort(
      text: text ?? this.text,
      erklaerung: erklaerung ?? this.erklaerung,
      isKorrekt: isKorrekt ?? this.isKorrekt,
    );
  }
  @override
  String toString() {
    return 'Antwort: $text, Korrekt: $isKorrekt';
  }
}






