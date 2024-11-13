import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/updated/sammlung_erstellen.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> pages = [
    {"text": "neue Sammlung erstellen", "page": SammlungErstellen()},
  ];

  final List<Color> rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  Color getContrastingTextColor(Color color) {
    // Berechnet die Helligkeit der Farbe, um eine passende Kontrastfarbe zu wählen
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rainbow Navigation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 Buttons pro Reihe
            childAspectRatio: 2, // Länglicher Button
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            final buttonColor = rainbowColors[index % pages.length];
            final textColor = getContrastingTextColor(buttonColor);

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[index]["page"]),
                );
              },
              child: Text(
                '${pages[index]["text"]}', // Zugriff auf "text" in der Map
                style: TextStyle(
                  fontSize: 24,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
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