import 'package:flutter/material.dart';
import 'package:lernplatform/my_appBar.dart';
import 'package:lernplatform/static_menu_drawer.dart';
import 'package:lernplatform/user_session.dart';


class StaticMenu extends StatefulWidget {

  @override
  State<StaticMenu> createState() => _StaticMenuState();
}

class _StaticMenuState extends State<StaticMenu> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserSession().appBar,
      drawer: UserSession().drawer,
      body: const Center(
        child: Text('Wiederholung ist die Mutter des Lernens'),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



class QuizStarterPage extends StatelessWidget {

  QuizStarterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserSession().appBar,
      drawer: UserSession().drawer,
      body: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text("hier ist eine Auswahl der Lernfelder"),
        ),
      ),
    );
  }
}
