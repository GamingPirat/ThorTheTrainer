import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../datenklassen/view_builder.dart';

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

  bool? evaluate(){
    _locked = true;
    if(isSelected){
      if(antwort.isKorrekt){
        _color = Colors.green;
        return true;
      } else{
        _color = Colors.red;
        return false;
      }
    } else{
      if(antwort.isKorrekt){
        _color = Colors.yellow;
        return null;
      }
    }
    notifyListeners();
  }

  set isSelected(bool value){
    if(value && !isMultipleChoice)
      unselectAntworten(this);
    _isSelected = value;
    _color = _isSelected ? Colors.lightBlueAccent : Colors.transparent;
    notifyListeners();
  }

}
