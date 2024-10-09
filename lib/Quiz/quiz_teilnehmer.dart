import 'dart:math';
import '../session.dart';
import 'package:lernplatform/datenklassen/lernfeld.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';
import '../datenklassen/thema.dart';

class QuizThema {
  late Thema thema;
  final LogThema logThema;
  final random = Random();

  QuizThema({required this.logThema}){
    for(Lernfeld lernfeld in Session().user.usersLernfelder)
      for(Thema thema in lernfeld.themen)
          if(thema.id == logThema.id)
            this.thema = thema;
  }

  userHatRichtigGeantwortet(){}
  userHatFalschGeantwortet(){}

  // Frage nextFrage(){
  //   // suche nach dem aktuellem konkretem Thema
  //   List<String> geseheneFragen =[
  //     ..._aktuellesLogThema.richtigBeantworteteFragen,
  //     ..._aktuellesLogThema.falschBeantworteteFragen
  //   ];
  //   for(Thema thema in ausgewaehlteThemen)
  //     if(thema.id == _aktuellesLogThema.id)
  //       // versuche offene Frage zu returnieren
  //
  //       return thema.
  // }

}
