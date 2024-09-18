import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login_page extends StatefulWidget {
  static const PATH = "/login";

  const Login_page({super.key});
  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  final TextEditingController _benutzernameController = TextEditingController();
  final TextEditingController _passwortController = TextEditingController();
  final TextEditingController _passwortBestatigenController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _benutzernameError;

  void _formularAbsenden() async {
    if (_formKey.currentState!.validate()) {
      String benutzername = _benutzernameController.text;
      String passwort = _passwortController.text;
      String key = _keyController.text;

      final response = await http.post(
        Uri.parse('http://localhost:5000/keys'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'key': key,
          'user_name': benutzername,
          'user_password': passwort,
        }),
      );

      if (response.statusCode == 200) {
        // Anfrage erfolgreich
        print('Benutzer erfolgreich registriert');
        setState(() {
          _benutzernameError = null;
        });
      } else if (response.statusCode == 400 && response.body == 'Username already taken') {
        // Benutzername bereits vergeben
        setState(() {
          _benutzernameError = 'Benutzername bereits vergeben';
        });
      } else {
        // Andere Fehler
        print('Fehler bei der Registrierung: ${response.body}');
        setState(() {
          _benutzernameError = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrierungsseite'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _benutzernameController,
                decoration: InputDecoration(
                  labelText: 'Benutzername',
                  errorText: _benutzernameError,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie einen Benutzernamen ein';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwortController,
                decoration: const InputDecoration(labelText: 'Passwort'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie ein Passwort ein';
                  } else if (value.length < 8) {
                    return 'Das Passwort muss mindestens 8 Zeichen lang sein';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwortBestatigenController,
                decoration: const InputDecoration(labelText: 'Passwort bestätigen'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte bestätigen Sie Ihr Passwort';
                  } else if (value != _passwortController.text) {
                    return 'Passwörter stimmen nicht überein';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _keyController,
                decoration: const InputDecoration(labelText: 'Key'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bitte geben Sie einen Key ein';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _formularAbsenden,
                child: const Text('Absenden'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
