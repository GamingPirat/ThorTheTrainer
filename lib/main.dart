
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/mok_user_model.dart';
import 'package:lernplatform/menu/my_static_menu.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings( // macht alles kostengünstiger
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(), // Für das Theme
        child: MyApp(),
      )
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
    session = Session();
    session.initializeAppBar((themeMode) {
      Provider.of<ThemeNotifier>(context, listen: false).setThemeMode(themeMode); // Update ThemeMode via Provider
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context); // Get the theme from the Provider

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.themeMode, // Use the themeMode from ThemeNotifier
      home: MyStaticMenu(
        content: const Center(
          child: Text('Wiederholung ist die Mutter des Lernens'),
        ),
      ), // Current page remains the same after theme change
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
