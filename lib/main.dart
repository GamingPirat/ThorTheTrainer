import 'package:flutter/material.dart';
import 'package:lernplatform/menu/my_appBar.dart';
import 'package:lernplatform/user_session.dart';

import 'menu/static_menu_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  setThemeMode(ThemeMode value){
    setState(() {
      _themeMode = value;
    });
  }

  late UserSession session;

  @override
  void initState() {
    session = UserSession();
    session.appBar = MyAppBar(setThemeMode: (themeMode) {
      setThemeMode(themeMode);
    },);
    session.drawer = StaticMenuDrawer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // Zugriff auf den themeMode über den State von MyAppBar:
      themeMode: _themeMode, // Dies ist eine vereinfachte Annahme.
      home: Scaffold(
        appBar: session.appBar,
        drawer: session.drawer,
        body: const Center(
          child: Text('Wiederholung ist die Mutter des Lernens'),
        ),
      ),
    );
  }
}
