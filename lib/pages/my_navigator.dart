import 'package:flutter/material.dart';
import 'package:lernplatform/session.dart';

class MyScreen extends StatelessWidget {
  Widget body;

  MyScreen({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Session().appBar,
        Container(
          width: double.infinity,
          height: double.infinity,
          child: body,
        ),
      ],
    );
  }
}



void MyNavigator({
  required BuildContext context,
  required Widget body,
}) {

  Navigator.push(context, PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Material(
        child: MyScreen(body: body), // Nutze das Material-Widget, um den Theme-Kontext zu übernehmen
      );
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Startet rechts außerhalb des Bildschirms
      const end = Offset.zero; // Endet in der normalen Position
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  ));
}


