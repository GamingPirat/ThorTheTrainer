import 'dart:math';
import 'package:lernplatform/datenklassen/frage.dart' as IDKW;
import '../session.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import '../datenklassen/thema.dart';

class QuizThema {
  late final Thema thema;
  late final List<String> geseheneFragen;
  final LogThema logThema;
  final random = Random();

  QuizThema({required this.logThema}){
    for(Lernfeld lernfeld in Session().user.usersLernfelder)
      for(Thema thema in lernfeld.themen)
          if(thema.id == logThema.id)
            this.thema = thema;
    geseheneFragen =[
      ...logThema.richtigBeantworteteFragen,
      ...logThema.falschBeantworteteFragen
    ];
  }

  userHatRichtigGeantwortet(String value){
    logThema.richtigBeantworteteFragen.add(value);
  }
  userHatFalschGeantwortet(String value){
    logThema.falschBeantworteteFragen.add(value);
  }

  IDKW.Frage _getFalschbeantworteteFrage(){
    if(logThema.falschBeantworteteFragen.isEmpty)
      return getRandomFrage(1);
    else{
      // finde die Version einer Frage die der User noch nicht gesehen hat

      for(String falschFrage in logThema.falschBeantworteteFragen)
        for(IDKW.Frage frage in thema.fragen)
          if(frage.id.split('_')[1] == falschFrage.split('_')[1])     // FrageNummer ==
            if(frage.id.split('_')[2] != falschFrage.split('_')[2])   // FrageVersion !=
              return frage;

      // wenn es keine ungesehene Version einer falsch beantworteten Frage mehr gibt
      // lösche die falschBeantworteteFragen und mach damit alle darin enthaltenen zu offenen Fragen
      logThema.falschBeantworteteFragen.clear();
      geseheneFragen =[...logThema.richtigBeantworteteFragen];
      return getRandomFrage(1);
    }
  }

  IDKW.Frage getRandomFrage(int counter){
    // der User soll alle 3 Runden mit einer bereits falsch beantworteten Frage
    // konfrontiert werden aber in einer anderen Version dieser Frage.
    if(counter != 3)
      for(IDKW.Frage frage in thema.fragen)
        if( ! geseheneFragen.contains(frage.id))
          return frage;

    return _getFalschbeantworteteFrage();
  }

}
