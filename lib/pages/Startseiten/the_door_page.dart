import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/firebase_options.dart';
import 'package:lernplatform/main.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Wiederholung ist die Mutter des Lernens.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              const Text(
                "Erlebe den Alltag eines IT-Mitarbeiters in dem du zum Teil dämliche Fragen deiner Kollegen und Kunden beantwortest.",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Zugangsschlüssel',
                  ),
                ),
              ),
              Text("Allgemeine Geschäftsbedingungen:",
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
                      " Content (im weiteren Quizfragen genannt) zur verfügung stellen.\nMit dem Einreichen von Feedback oder "
                      "Quizfragen erklärt sich der Alpha-Tester einverstanden, dass "
                      "diese vom Entwickler für kommerzielle Zwecke genutzt werden"
                      " dürfen, ohne dass daraus Forderungen abgeleitet werden können."
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
                  Text("AGb´s akzeptieren"),
                  Spacer(),
                ],
              ),
              SizedBox(height: 32,),
              ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Startseite()),
                  );
                }
                    : null,
                child: const Text('Betreten'),
              ),
            ],
          ),
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
      theme: ThemeData.dark(), // Dark Mode
      home: const TheDoorPage(),
    );
  }
}
