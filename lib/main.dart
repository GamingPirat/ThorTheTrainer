import 'package:flutter/material.dart';
import 'package:lernplatform/menu/mok_user_model.dart';
import 'package:lernplatform/menu/my_appBar.dart';
import 'package:lernplatform/menu/my_static_menu.dart';
import 'package:lernplatform/session.dart';

import 'menu/my_left_drawer.dart';

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

  late Session session;

  @override
  void initState() {
    session = Session(setThemeMode: (themeMode) {
      setThemeMode(themeMode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: MyStaticMenu(
        content: const Center(
          child: Text('Wiederholung ist die Mutter des Lernens'),
        ),
      ),
    );
  }
}
