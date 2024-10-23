import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/db_thema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';

abstract class UsersContentModel with ChangeNotifier{

  late final int id;
  late final String name;
  late double _progress;

  UsersContentModel({
    required this.id,
    required this.name,
  });

  double get progress => _progress;
  void set progress(double value) {
    _progress = value;
    notifyListeners();
  }

  double loadProgress();
}

class Lernfeld_Personal extends UsersContentModel{

  LogLernfeld logLernfeld;
  late List<Thema_Personal> meineThemen = [];

  Lernfeld_Personal({required this.logLernfeld, required Lernfeld_DB l,})
      : super(id: l.id, name: l.name){
    for(Thema t in l.themen)
      for(LogThema lt in logLernfeld.meineThemen)
        if(t.id == lt.id)
          meineThemen.add(Thema_Personal(logThema: lt, t: t));
    loadProgress();
  }


  @override
  double loadProgress(){
    double erreichteZahl = 0;
    for(Thema_Personal thema in meineThemen){
      erreichteZahl += thema.loadProgress();
    }
    this.progress = erreichteZahl.clamp(0.0, 1.0);
    return this.progress;
  }
}

class Thema_Personal extends UsersContentModel{

  LogThema logThema;
  late List<SubThema_Personal> meineSubThemen = [];

  Thema_Personal({required this.logThema, required Thema t,})
      : super(id: t.id, name: t.name){
    for(SubThema st in t.subthemen)
      for(LogSubThema lst in logThema.logSubthemen)
        if(st.id == lst.id)
          meineSubThemen.add(SubThema_Personal(logSubThema: lst, subThema: st));
    loadProgress();
  }


  @override
  double loadProgress(){
    double erreichteZahl = 0;
    for(SubThema_Personal subThema in meineSubThemen){
      erreichteZahl += subThema.loadProgress();
    }
    this.progress = erreichteZahl.clamp(0.0, 1.0);
    return this.progress;
  }
}

class SubThema_Personal extends UsersContentModel{
  LogSubThema logSubThema;
  final SubThema subThema;

  SubThema_Personal({required this.logSubThema, required this.subThema,})
      : super(id: subThema.id, name: subThema.name) {
    loadProgress();
  }

  @override
  double loadProgress(){
    // zähle wie viele richtig beantwortet sind
    int richtigbeantwortete = 0;
    for(String frage in logSubThema.richtigBeantworteteFragen){
      if (frage.split('_').last == '1')
        richtigbeantwortete++;
    }

    // bilde fortschritt
    double progress = richtigbeantwortete / subThema.getTrueLengthOfFragen();

    // stelle sicher das fortschritt nicht größer als 1 ist
    this.progress = progress.clamp(0.0, 1.0);
    return this.progress;
  }
}