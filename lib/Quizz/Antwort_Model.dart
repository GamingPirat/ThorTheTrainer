import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Antwort_Model with ChangeNotifier {
  final Antwort antwort;
  final Function unselectAntworten;
  final bool isMultipleChoice;
  bool _isSelected = false;
  bool _locked = false;
  bool erklaerungVisible = false;
  Color _color = Colors.transparent;

  Antwort_Model({
    required this.antwort,
    required this.unselectAntworten,
    required this.isMultipleChoice
  });

  clicked(){
    if(_locked){
      erklaerungVisible = !erklaerungVisible;
      notifyListeners();
    }
    else{
      isSelected = !isSelected;
    }
  }

  Color get color => _color;
  bool get locked => _locked;
  bool get isSelected => _isSelected;

  Map<String, dynamic> evaluate(){
    Map<String, dynamic> map = {"erreichtePunkte":0, "maxPunkte":antwort.punkte};
    _locked = true;
    if(isSelected){
      if(antwort.isKorrekt){
        _color = Colors.green;
        map["erreichtePunkte"] = antwort.punkte;
      } else{
        _color = Colors.red;
        map["erreichtePunkte"] = -antwort.punkte;
      }
    } else{
      if(antwort.isKorrekt){
        _color = Colors.yellow;
        map["erreichtePunkte"] = -1;
      }
    }
    notifyListeners();
    return map;
  }

  set isSelected(bool value){
    if(value && !isMultipleChoice)
      unselectAntworten(this);
    _isSelected = value;
    _color = _isSelected ? Colors.lightBlueAccent : Colors.transparent;
    notifyListeners();
  }

}
