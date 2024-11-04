import 'package:flutter/material.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:lernplatform/globals/user_viewmodel.dart';
import 'package:provider/provider.dart';

class Startseite extends StatelessWidget {
  const Startseite({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Session().user,
      child: Consumer<UserModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: Session().appBar,
            drawer: Session().drawer,
            body: vm.isLoading
                ? Center(child: CircularProgressIndicator())
                : Center( child: Text('Wiederholung ist die Mutter des Lernens'),),
          );
        },
      ),
    );
  }
}
