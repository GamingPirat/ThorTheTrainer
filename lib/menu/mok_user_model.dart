import 'package:flutter/material.dart';
import '../datenklassen/log_teilnehmer.dart';

class MokUserModel with ChangeNotifier {

  late Teilnehmer teilnehmer;
  bool _isLoading = true;

  MokUserModel(){_load;}

  get isLoading => _isLoading;

  Future<void>_load() async {
    teilnehmer = await Teilnehmer.loadTeilnehmer('user_key');
    _isLoading = false;
    notifyListeners();
  }
}