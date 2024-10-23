import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/db_lernfeld.dart';
import 'package:lernplatform/datenklassen/db_subthema.dart';
import 'package:lernplatform/datenklassen/db_thema.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';

abstract class UsersContentModel with ChangeNotifier{

  late final int id;
  late final String name;
  late double _progress;
  bool _isSelected = false;

  UsersContentModel({
    required this.id,
    required this.name,
  });

  double loadProgress();

  double get progress => _progress;

  void set progress(double value) { _progress = value; notifyListeners(); }

  bool get isSelected => _isSelected;

  void set isSelected(bool value);

}

class Lernfeld_Personal extends UsersContentModel{

  LogLernfeld logLernfeld;
  late List<Thema_Personal> meineThemen = [];

  Lernfeld_Personal({required this.logLernfeld, required Lernfeld_DB l,})
      : super(id: l.id, name: l.name){
    for(Thema thema in l.themen)
      for(LogThema logThema in logLernfeld.meineThemen)
        if(thema.id == logThema.id)
          meineThemen.add(
              Thema_Personal(
                  logThema: logThema,
                  thema: thema,
                  checkParent: () => checkIfAllChildrenAreSelected
              ));
    loadProgress();
  }

  @override
  void set isSelected(bool value) {
    for(Thema_Personal thema in meineThemen){
      thema.isSelected = value;
      for(SubThema_Personal subthema in thema.meineSubThemen)
        subthema.isSelected = value;
    }
    _isSelected = value; notifyListeners();
  }

  bool checkIfAllChildrenAreSelected(){
    int counter = 0;
    for(Thema_Personal thema in meineThemen)
      if(thema.checkIfAllChildrenAreSelected())
        counter++;

    if(counter == meineThemen.length)
      isSelected = true;
    return isSelected;
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
  final Function checkParent;

  Thema_Personal({
    required this.logThema,
    required Thema thema,
    required this.checkParent,
  })
      : super(id: thema.id, name: thema.name){
    for(SubThema st in thema.subthemen)
      for(LogSubThema lst in logThema.logSubthemen)
        if(st.id == lst.id)
          meineSubThemen.add(
              SubThema_Personal(
                  logSubThema: lst,
                  subThema: st,
                  selectParent: ()=> checkIfAllChildrenAreSelected
              ));
    loadProgress();
  }

  @override
  void set isSelected(bool value) {
    for(SubThema_Personal subthema in meineSubThemen)
      subthema.isSelected = value;

    if(value) checkParent();

    _isSelected = value; notifyListeners();
  }


  bool checkIfAllChildrenAreSelected(){
    int counter = 0;
    for(SubThema_Personal subthema in meineSubThemen)
      if(subthema.isSelected)
        counter++;

    if(counter == meineSubThemen.length)
      isSelected = true;
    return isSelected;
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
  final Function selectParent;

  SubThema_Personal({
    required this.logSubThema,
    required this.subThema,
    required this.selectParent,
  })
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

  @override
  set isSelected(bool value) {
    _isSelected = value;  // Direktes Setzen der privaten Variable
    if(_isSelected) selectParent();
    notifyListeners();
  }

}