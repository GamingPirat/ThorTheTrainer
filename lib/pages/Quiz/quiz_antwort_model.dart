import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/db_antwort.dart';

class QuizAntwortModel with ChangeNotifier {
  final Antwort antwort;
  final Function unselectAntworten;
  final bool isMultipleChoice;
  bool _isSelected = false;
  bool _locked = false;
  bool erklaerungVisible = false;
  Color _color = Colors.transparent;

  QuizAntwortModel({
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

  void evaluate(){
    _locked = true;

    if(isSelected && antwort.isKorrekt)
      _color = Colors.green;
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
    Color previusColor = _color;
    _color = Colors.pink;
    notifyListeners();
    await Future.delayed(Duration(seconds: 1));
    _color = previusColor;
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
