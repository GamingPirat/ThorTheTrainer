import 'package:flutter/material.dart';
import 'package:lernplatform/print_colors.dart';

abstract class UsersContentModel with ChangeNotifier{

  late final int id;
  late final String name;
  late Color effect_color;
  late double _progress;

  UsersContentModel({
    required this.id,
    required this.name,
  }){updateProgress();}

  bool _isHovered = false;
  bool get ishovered => _isHovered;
  void set ishovered(bool value){ _isHovered = value; notifyListeners();}

  Color _glowColor = Colors.transparent;
  Color get glowColor => _glowColor;
  void set glowColor(Color value){ _glowColor = value; notifyListeners();}


  // es gibt _Protected_isSelected und zusätzlich isSelected. weil isSelected
  // überschrieben werden muss und daher nen anderen Algorythus ausführen soll.
  // Ich muss also diesen bool ändern können ohne den isSelected Algorythmus
  // aus zu lösen.
  bool _Protected_isSelected = false;
  void set Protected_isSelected(bool value){
    _Protected_isSelected = value;
    _glowColor = _Protected_isSelected ? Colors.blue : Colors.transparent;
    notifyListeners();
  }

  bool get isSelected => _Protected_isSelected;
  void set isSelected(bool value){ _Protected_isSelected = value; notifyListeners(); }

  void updateProgress();

  double get progress => _progress;
  set progress (double value) {
    _progress = value;
    notifyListeners();
  print_Green("UsersContentModel progress updated = $progress");
  }



}