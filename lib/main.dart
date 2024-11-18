import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/firebase_options.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:lernplatform/globals/parallax_background.dart';
import 'package:lernplatform/pages/Startseiten/the_door_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    print_Cyan("MaterialApp erstellt"); // todo print

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeNotifier.themeMode, // Use the themeMode from ThemeNotifier
      home: ParallaxZoomBackground(image_path: 'assets/phone_like.png', child: TheDoorPage()),
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
