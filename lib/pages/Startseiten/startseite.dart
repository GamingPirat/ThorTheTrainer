import 'package:flutter/material.dart';
import 'package:lernplatform/globals/my_background.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:lernplatform/globals/user_viewmodel.dart';
import 'package:lernplatform/pages/QuizStarter/QuizzStarter_Screen.dart';
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
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 32),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => QuizStarter_Screen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ),
            body: Stack(
              children: [
                Session().background,
                vm.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Center( child: Text('Wiederholung ist die Mutter des Lernens'),),
              ],
            ),
          );
        },
      ),
    );
  }
}
