import 'package:lernplatform/datenklassen/folder_types.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/print_colors.dart';

class Lernfeld extends ContentCarrier {
  final List<Thema> themen;

  Lernfeld({
    required int id,
    required String name,
    required this.themen,
  }) : super(id: id, name: name);

  // Aktualisierte fromJson-Methode
  factory Lernfeld.fromJson(Map<String, dynamic> json) {
    // Wenn 'name' auf oberster Ebene "themen" ist, nimm den Namen des ersten Eintrags in 'details'
    String lernfeldName = json['name'] == 'themen' && (json['details'] as List).isNotEmpty
        ? json['details'][0]['name']
        : json['name'] ?? 'Unbekanntes Lernfeld';

    print_Magenta("Gelesener Lernfeld-Name: $lernfeldName");

    return Lernfeld(
      id: json['id'] ?? 0,
      name: lernfeldName,
      themen: (json['details'] as List).map((e) => Thema.fromJson(e)).toList(),
    );
  }


//   return Lernfeld(
  //     id: json['id'] ?? 0,  // Verwende die extrahierte ID
  //     name: json['name'] ?? 'Unbekannt',
  //     themen: gesamtThemen,
  //   );
  // }
}

