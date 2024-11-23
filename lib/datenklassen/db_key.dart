import 'package:lernplatform/globals/print_colors.dart';

class AlphaKey {
  String key;
  List<String> lernfelder;

  AlphaKey({required this.key, required this.lernfelder});

  factory AlphaKey.fromJson(Map<String, dynamic> json) {
    print_Cyan("AlphaKey.fromJson: Eingangsdaten: $json");
    List<String> lernfelderList = [];
    if (json['lernfelder'] != null) {
      try {
        // Prüfen, ob lernfelder eine Liste ist und konvertieren
        lernfelderList = List<String>.from(json['lernfelder']);
        // print_Cyan("AlphaKey.fromJson: Verarbeitete lernfelder: $lernfelderList");
      } catch (e, stackTrace) {
        print_Red("AlphaKey.fromJson: Fehler beim Konvertieren von lernfelder: $e");
        print_Red("AlphaKey.fromJson: StackTrace: $stackTrace");
      }
    }
    return AlphaKey(
      key: json['key'] ?? '',
      lernfelder: lernfelderList,
    );
  }




}