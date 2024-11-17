import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/firebase_options.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:lernplatform/main.dart';
import 'package:lernplatform/globals/moving_background.dart';
import 'package:lernplatform/pages/Startseiten/startseite.dart';
import 'package:provider/provider.dart';


class TheDoorPage extends StatefulWidget {
  const TheDoorPage({super.key});

  @override
  State<TheDoorPage> createState() => _TheDoorPageState();
}

class _TheDoorPageState extends State<TheDoorPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isChecked = false;
  Color _textfield_frame_color = Colors.white;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      _isButtonEnabled = _controller.text.isNotEmpty && _isChecked;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
        "Thor The Trainer",
        style: TextStyle(
          fontSize: 48, // Große Schrift für mehr Präsenz
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          foreground: Paint()
            ..shader = LinearGradient(
              begin: Alignment.topLeft, // Anfang des Farbverlaufs
              end: Alignment.bottomRight, // Ende des Farbverlaufs
              colors: <Color>[
                Colors.purpleAccent,
                Colors.purpleAccent,
                Colors.grey[500]!,
              ],
            ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 50.0)),
          shadows: [
            Shadow(
              offset: Offset(4.0, 4.0), // Versatz des Schattens
              blurRadius: 6.0, // Weiche Kanten
              color: Colors.black45, // Dunkler Schatten für Tiefe
            ),
            Shadow(
              offset: Offset(-4.0, -4.0), // Highlight-Effekt in entgegengesetzter Richtung
              blurRadius: 6.0,
              color: Colors.blueAccent.withOpacity(0.9), // Leichte Farb-Tiefe
            ),
          ],
        ),
      ),


    ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 16),
                      const Text(
                        "Erlebe den Alltag eines IT-Mitarbeiters in dem du zum Teil dämliche Fragen deiner Kollegen und Kunden beantwortest.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 80,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2), // Weißer Hintergrund mit 20% Deckkraft
                            borderRadius: BorderRadius.circular(8), // Optional: Abgerundete Ecken
                          ),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8), // Abgerundeter Rahmen
                                borderSide: BorderSide(color: Colors.blue, width: 2), // Rahmenfarbe und Breite
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.white, width: 2), // Rahmen bei Fokus
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: _textfield_frame_color, width: 1), // Rahmen ohne Fokus
                              ),
                              labelText: 'Zugangsschlüssel',
                              labelStyle: TextStyle(color: Colors.white), // Farbe des Labels
                            ),
                            style: TextStyle(color: Colors.white), // Textfarbe
                          ),
                        )
                      ),
                      SizedBox(height: 32,),
                      Row(
                        children: [
                          Spacer(),
                          Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value ?? false;
                                _checkInput();
                              });
                            },
                          ),
                          Text("AGB gelesen und akzeptieren"),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 32,),
                      ElevatedButton(
                        onPressed: _isButtonEnabled
                            ? () async {
                          bool flag = await Session().enter(_controller.text);
                          if(flag) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Startseite()),
                            );
                          } else {
                            setState(() {
                              _textfield_frame_color = Colors.red;
                            });
                          }
                          }
                            : null,
                        child: const Text('Betreten'),
                      ),
                      SizedBox(height: 64),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7), // Hintergrundfarbe mit Transparenz
                          borderRadius: BorderRadius.circular(36), // Abgerundete Ecken
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Allgemeine Geschäftsbedingungen:",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Diese App befindet sich noch in der Alpha-Testphase. "
                                  "Nur ausgewählte Personen (im Folgenden Alpha-Tester genannt) "
                                  "erhalten einen speziellen Zugangsschlüssel, um die App "
                                  "testen und durch aktive Beiträge erweitern zu können.\nAlle automatisch generierten Daten der "
                                  "Alpha-Tester (im Folgenden Fortschritt genannt) werden "
                                  "lokal auf dem Endgerät des Alpha-Testers im sogenannten "
                                  "LocalStorage bzw. in den Cookies gespeichert.\n"
                                  "Alpha-Tester können aktiv Feedback geben und dem Entwickler"
                                  " Content (im weiteren Quizfragen genannt) zur Verfügung stellen.\nMit dem Einreichen von Feedback oder "
                                  "Quizfragen erklärt sich der Alpha-Tester einverstanden, dass "
                                  "diese vom Entwickler für kommerzielle Zwecke genutzt werden"
                                  " dürfen, ohne dass daraus Forderungen abgeleitet werden können.",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container(),),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Große Textkörper
          bodyMedium: TextStyle(color: Colors.white), // Standard-Textkörper
          bodySmall: TextStyle(color: Colors.white), // Kleine Texte
          headlineLarge: TextStyle(color: Colors.white), // Große Titel
          headlineMedium: TextStyle(color: Colors.white), // Mittlere Titel
          headlineSmall: TextStyle(color: Colors.white), // Kleine Titel
        ),
      ),

      // home: ParallaxZoomBackground(image_path: 'assets/phone_like.png', child: TheDoorPage(),),
      home: TheDoorPage(),
    );
  }
}
