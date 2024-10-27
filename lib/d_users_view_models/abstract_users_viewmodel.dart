import 'package:flutter/material.dart';

abstract class UsersViewModel with ChangeNotifier{

  late final int id;
  late final String name;
  bool _Protected_isSelected = false;
  bool _isHovered = false;

  UsersViewModel({
    required this.id,
    required this.name,
  });

  double get progress;

  bool get isSelected => _Protected_isSelected;

  void set Protected_isSelected(bool value){ _Protected_isSelected = value; notifyListeners(); }

  void set isSelected(bool value){ _Protected_isSelected = value; notifyListeners(); }

  bool get ishovered => _isHovered;

  void set ishovered(bool value){ _isHovered = value; notifyListeners();}

}