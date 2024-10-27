import 'package:flutter/material.dart';

abstract class UsersContentModel with ChangeNotifier{

  late final int id;
  late final String name;

  UsersContentModel({
    required this.id,
    required this.name,
  });

  bool _isHovered = false;
  bool get ishovered => _isHovered;
  void set ishovered(bool value){ _isHovered = value; notifyListeners();}

  Color _glowColor = Colors.transparent;
  Color get glowColor => _glowColor;
  void set glowColor(Color value){ _glowColor = value; notifyListeners();}

  bool _Protected_isSelected = false;
  void set Protected_isSelected(bool value){
    _Protected_isSelected = value;
    _glowColor = _Protected_isSelected ? Colors.blue : Colors.transparent;
    notifyListeners();
  }

  bool get isSelected => _Protected_isSelected;
  void set isSelected(bool value){ _Protected_isSelected = value; notifyListeners(); }

  double get progress;



}