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

  Color get color => _color;
  bool get locked => _locked;
  bool get isSelected => _isSelected;

  bool? evaluate(){
    _locked = true;
    // flag == true == Pluspunkte,
    // flag == false == Minuspunkte,
    // flag == null == neutral
    bool? flag;
    if (antwort.isKorrekt && !isSelected && !isMultipleChoice) flag = null;
    else flag = antwort.isKorrekt && isSelected;

    // farbe ändern
    if(isSelected && antwort.isKorrekt){
      _color = Colors.green;
    }
    else if(isSelected && !antwort.isKorrekt){
      _color = Colors.red;
    }
    else if(!isSelected && antwort.isKorrekt) {
      _color = Colors.yellow;
    }

    notifyListeners();
  }

  blink() async {
    // wenn der Nutzer keine Antwort gewählt hat
    _color = Colors.pink;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _color = Colors.transparent;
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
