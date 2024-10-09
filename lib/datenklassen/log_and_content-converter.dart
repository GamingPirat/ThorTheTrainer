
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/datenklassen/mokdaten.dart';
import 'package:lernplatform/datenklassen/thema.dart';

Thema convertToThema({required LogThema logthema}){

  for(Thema thema in mok_themen) {
    if (thema.id == logthema.id)
      return thema;
  }
  return Thema(id: 9999999, name: "Thema nicht vorhanden", tags: [], fragen: []);
}