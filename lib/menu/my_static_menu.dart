import 'package:flutter/material.dart';
import 'package:lernplatform/menu/mok_user_model.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';

import '../print_colors.dart';

class MyStaticMenu extends StatelessWidget {

  UserModel viewModel = Session().user;

  Widget content;
  MyStaticMenu({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    // print_Magenta("build MyStaticMenu"); //todo
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<UserModel>(
          builder: (context, vm, child) {
          return Scaffold(
            appBar: Session().appBar,
            drawer: Session().drawer,
            body: vm.isLoading ? Center(child: CircularProgressIndicator()) : content,
          );
        }
      ),
    );
  }
}
