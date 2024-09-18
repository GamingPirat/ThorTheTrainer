import 'package:login/datenbank/frage_und_antwort.dart';

import '../datenbank/logData/UserLogData.dart';

class FrageService{

  Frage getAnUnseenQuestion(Log_Frage u_frage){
    List<Frage> allVersions = _getAllVersionsOfQuestion(u_frage);
    for(Frage frage in allVersions){
      if( ! u_frage.gesehene_versionen.contains(frage.version)){
        u_frage.gesehene_versionen.add(frage.version); // todo speicher das
        return frage;
      }
    }
    u_frage.gesehene_versionen = [];
    u_frage.gesehene_versionen.add(allVersions[0].version); // todo speicher das

    return allVersions[0];

  }

  List<Frage> _getAllVersionsOfQuestion(Log_Frage u_frage){
    List<Frage> allVersions = [];
    for(Frage frage in dummy_thema.fragen)
      if(frage.kompetenzbereich_id == u_frage.thema_id && frage.nummer == u_frage.nummer)
        allVersions.add(frage);

    return allVersions;

  }
}