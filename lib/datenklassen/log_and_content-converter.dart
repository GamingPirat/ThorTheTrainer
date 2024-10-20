
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import 'package:lernplatform/datenklassen/mokdaten.dart';
import 'package:lernplatform/datenklassen/subthema.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:lernplatform/session.dart';

Thema convertToThema({required LogThema logthema}){

  for(Lernfeld lernfeld in Session().user.usersLernfelder)
    for(Thema thema in lernfeld.themen)
      if (thema.id == logthema.id)
        return thema;

  return Thema(id: 9999999, name: "Thema nicht vorhanden", tags: [], subthemen: []);
}

SubThema convertToSubThema({required LogSubThema logthema}){

  for(Lernfeld lernfeld in Session().user.usersLernfelder)
    for(Thema thema in lernfeld.themen)
      for(SubThema subthema in thema.subthemen)
        if (subthema.id == logthema.id)
          return subthema;

  return SubThema(id: 9999999, name: "SubThema nicht vorhanden", tags: [], fragen: []);
}