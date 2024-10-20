import 'dart:math';
import 'package:lernplatform/datenklassen/frage.dart' as IDKW;
import 'package:lernplatform/datenklassen/subthema.dart';
import '../session.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import '../datenklassen/thema.dart';

class QuizSubThema {
  late final SubThema subThema;
  late final List<String> geseheneFragen;
  final LogSubThema logSubThema;
  final random = Random();

  QuizSubThema({required this.logSubThema}){
    // for(Lernfeld lernfeld in Session().user.usersLernfelder)
    //   for(Thema thema in lernfeld.themen)
    //     for(SubThema thema in lernfeld.themen)
    //         if(thema.id == logSubThema.id)
    //           this.subThema = thema;
      geseheneFragen =[
        ...logSubThema.richtigBeantworteteFragen,
        ...logSubThema.falschBeantworteteFragen
      ];
  }

  userHatRichtigGeantwortet(String value){
    logSubThema.richtigBeantworteteFragen.add(value);
  }
  userHatFalschGeantwortet(String value){
    logSubThema.falschBeantworteteFragen.add(value);
  }

  IDKW.Frage _getFalschbeantworteteFrage(){
    if(logSubThema.falschBeantworteteFragen.isEmpty)
      return getRandomFrage(1);
    else{
      // finde die Version einer Frage die der User noch nicht gesehen hat

      for(String falschFrage in logSubThema.falschBeantworteteFragen)
        for(IDKW.Frage frage in subThema.fragen)
          if(frage.id.split('_')[1] == falschFrage.split('_')[1])     // FrageNummer ==
            if(frage.id.split('_')[2] != falschFrage.split('_')[2])   // FrageVersion !=
              return frage;

      // wenn es keine ungesehene Version einer falsch beantworteten Frage mehr gibt
      // lösche die falschBeantworteteFragen und mach damit alle darin enthaltenen zu offenen Fragen
      logSubThema.falschBeantworteteFragen.clear();
      geseheneFragen =[...logSubThema.richtigBeantworteteFragen];
      return getRandomFrage(1);
    }
  }

  IDKW.Frage getRandomFrage(int counter){
    // der User soll alle 3 Runden mit einer bereits falsch beantworteten Frage
    // konfrontiert werden aber in einer anderen Version dieser Frage.
    if(counter != 3)
      for(IDKW.Frage frage in subThema.fragen)
        if( ! geseheneFragen.contains(frage.id))
          return frage;

    return _getFalschbeantworteteFrage();
  }

}
