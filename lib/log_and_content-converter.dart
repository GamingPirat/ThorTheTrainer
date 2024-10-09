import 'package:lernplatform/datenklassen/thema.dart';
import 'datenklassen/log_lernfeld_u_frage.dart';
import 'datenklassen/frage.dart';

Thema convertToThema({required LogThema logthema}){

  for(Thema thema in mok_themen) {
    if (thema.id == logthema.id)
      return thema;
  }
  return Thema(id: 9999999, name: "Thema nicht vorhanden", tags: [], fragen: []);
}

List<Frage> convertToFragen({required List<LogFrage> logFragen}){
  List<Frage> returnValue = [];
  // hol dir das zugehörige Thema
  Thema thema = Thema(
      id: 999999,
      name: "Thema existiert nicht",
      tags: [],
      fragen: []
  );
  // durchsuche themen und finde das richtige
  int searchForThemaID =  int.parse(logFragen[0].id.split('_')[0]);
  for(Thema current in mok_themen){
    if(current.id == searchForThemaID){
      thema = current;
      break;
    }
  }
  // und iterriee dann durch dessen Fragen während du nach der id suchst
  for(LogFrage logfrage in logFragen){
    for (Frage current in thema.fragen) {
      if(current.id == logfrage.id)
        returnValue.add(current);
      }
  }
  return returnValue;
  }


List<LogFrage> convertToLogFragen({required List<Frage> fragen}){
  List<LogFrage> returnValue = [];

  for(Frage frage in fragen) {
    returnValue.add(LogFrage(frage.id));
  }
  return returnValue;
}