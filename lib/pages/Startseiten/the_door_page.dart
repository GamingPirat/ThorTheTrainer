import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/firebase_options.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:lernplatform/main.dart';
import 'package:lernplatform/pages/Startseiten/startseite.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            fontSize: 48,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            foreground: Paint()
              ..shader = LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.purpleAccent,
                  Colors.purpleAccent,
                  Colors.grey[500]!,
                ],
              ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 50.0)),
            shadows: [
              Shadow(
                offset: Offset(4.0, 4.0),
                blurRadius: 6.0,
                color: Colors.black45,
              ),
              Shadow(
                offset: Offset(-4.0, -4.0),
                blurRadius: 6.0,
                color: Colors.blueAccent.withOpacity(0.9),
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
                      const Text(
                        "Erlebe den Alltag eines IT-Mitarbeiters in dem du zum Teil dämliche Fragen deiner Kollegen und Kunden beantwortest.",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                BorderSide(color: Colors.white, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: _textfield_frame_color, width: 1),
                              ),
                              labelText: 'Zugangsschlüssel',
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
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
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _isButtonEnabled
                            ? () async {
                          // Überprüfe, ob der Nutzer bereits zugestimmt hat
                          bool consent = await _hasGivenCookieConsent();

                          // Zeige den Dialog nur, wenn keine Zustimmung vorliegt
                          if (!consent) {
                            await _showCookieConsentDialog();
                          }

                          // Wenn der Nutzer zugestimmt hat, weiter zur nächsten Seite
                          if (await _hasGivenCookieConsent()) {
                            bool flag = await Session()
                                .enter(_controller.text);
                            if (flag) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const Startseite()),
                              );
                            } else {
                              setState(() {
                                _textfield_frame_color = Colors.red;
                              });
                            }
                          }
                        }
                            : null,
                        child: const Text('Betreten'),
                      ),
                      SizedBox(height: 64),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: const Column(
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
                                  "testen und durch aktive Beiträge erweitern zu können.\n"
                                  "Alle automatisch generierten Daten der "
                                  "Alpha-Tester (im Folgenden Fortschritt genannt) werden "
                                  "lokal auf dem Endgerät des Alpha-Testers im sogenannten "
                                  "LocalStorage bzw. in den Cookies gespeichert.\n"
                                  "Alpha-Tester können aktiv Feedback geben und dem Entwickler"
                                  " Content (im weiteren Quizfragen genannt) zur Verfügung stellen.\n"
                                  "Mit dem Einreichen von Feedback oder "
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
            Expanded(child: Container()),
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

  Future<void> _showCookieConsentDialog() async {
    bool? consentGiven = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Nutzer muss explizit reagieren
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cookie-Zustimmung"),
          content: Text(
            "Deine Fortschritte auf der Seite werden in deinen Cookies gespeichert.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Ablehnung
              },
              child: Text("Ablehnen"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Zustimmung
              },
              child: Text("Zustimmen"),
            ),
          ],
        );
      },
    );

    if (consentGiven == true) {
      await _storeCookieConsent(true);
      print("Cookie-Zustimmung gegeben.");
    } else {
      print("Cookie-Zustimmung abgelehnt.");
    }
  }

  Future<void> _storeCookieConsent(bool consent) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cookieConsent', consent);
    print("Cookie-Zustimmung gespeichert: $consent");
  }

  Future<bool> _hasGivenCookieConsent() async {
    final prefs = await SharedPreferences.getInstance();
    bool? consent = prefs.getBool('cookieConsent');
    print("Cookie-Zustimmung vorhanden: $consent");
    return consent ?? false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
        ),
      ),
      home: TheDoorPage(),
    );
  }
}
