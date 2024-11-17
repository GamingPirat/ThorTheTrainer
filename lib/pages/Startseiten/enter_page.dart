import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/firebase_options.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:lernplatform/pages/Startseiten/startseite.dart';
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
        child: EnterPage(),
      )
  );
}


class EnterPage extends StatefulWidget {
  @override
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {

  @override
  void initState() {
    super.initState();
    Session().initializeAppBar((themeMode) {
      Provider.of<ThemeNotifier>(context, listen: false).setThemeMode(themeMode); // Update ThemeMode via Provider
    });
  }

  Future<void> _initializeApp() async {
    await Session().enter(r"Alpha_B8$kFm2@rW^bXe!4pZ*u&oR6%1HjLq#G7Nv?Td");
    print_Cyan("Session erfolgreich initialisiert");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Ladeanzeige während der Initialisierung
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasError) {
          // Fehleranzeige, falls etwas schiefgeht
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Fehler bei der Initialisierung: ${snapshot.error}"),
              ),
            ),
          );
        }

        // Wenn das Future abgeschlossen ist, normale App rendern
        final themeNotifier = Provider.of<ThemeNotifier>(context);
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeNotifier.themeMode,
          home: Startseite(),
        );
      },
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
