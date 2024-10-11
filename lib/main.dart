import 'package:flutter/material.dart';
import 'package:lernplatform/menu/my_static_menu.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(), // Für das Theme
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Session session;
  late Widget _currentPage; // Holds the current page to avoid rebuilding

  @override
  void initState() {
    super.initState();
    session = Session(setThemeMode: (themeMode) {
      Provider.of<ThemeNotifier>(context, listen: false).setThemeMode(themeMode); // Update ThemeMode via Provider
    });
    _currentPage = MyStaticMenu(
      content: const Center(
        child: Text('Wiederholung ist die Mutter des Lernens'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context); // Get the theme from the Provider

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.themeMode, // Use the themeMode from ThemeNotifier
      home: _currentPage, // Current page remains the same after theme change
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners(); // Notify listeners when the theme changes
  }
}
