import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../datenklassen/frage.dart';

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

  blink() async {
    final previousColor = _color;
    _color = Colors.pink;
    notifyListeners();

    await Future.delayed(Duration(seconds: 2));

    _color = previousColor;
    notifyListeners();
  }

  bool? evaluate(){
    // null == not selected => nullPunkte
    // true == richtig + selected => plusPunkte
    // false == falsch + selected => minusPunkte

    _locked = true;
    bool? flag = !isSelected ? null : antwort.isKorrekt;
    _color = isSelected && antwort.isKorrekt
        ? Colors.green
        : isSelected && !antwort.isKorrekt
        ? Colors.red
        : !isSelected && antwort.isKorrekt
        ? Colors.yellow
        : Colors.transparent;

    notifyListeners();
    return flag;
  }

  Color get color => _color;
  bool get locked => _locked;
  bool get isSelected => _isSelected;

  set isSelected(bool value){
    if(value && !isMultipleChoice)
      unselectAntworten(this);
    _isSelected = value;
    _color = _isSelected ? Colors.lightBlueAccent : Colors.transparent;
    notifyListeners();
  }

}
