import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';

class NewQuizsubthemaModel with ChangeNotifier{

  UsersSubThema selected_subthema;

  NewQuizsubthemaModel({required this.selected_subthema});

}