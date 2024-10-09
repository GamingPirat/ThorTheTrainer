import 'package:flutter/material.dart';
import 'package:lernplatform/menu/mok_user_model.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';

class MyStaticMenu extends StatelessWidget {

  MokUserModel viewModel = Session().derEingeloggteUser_Model;

  Widget content;
  MyStaticMenu({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MokUserModel>(
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
