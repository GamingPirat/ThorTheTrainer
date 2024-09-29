import 'dart:convert'; // Für JSON-Konvertierung
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/thema.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Quiz/quiz_teilnehmer.dart'; // Für den Zugriff auf den lokalen Speicher



class LogLernfeld {
  int id;
  List<LogThema> meineThemen;

  LogLernfeld(this.id, this.meineThemen);

}

List<LogLernfeld> mok_lernfelder = [
  LogLernfeld(1, [mok_lokThemen[0], mok_lokThemen[1], ]),
  LogLernfeld(2, [mok_lokThemen[2], mok_lokThemen[3], ]),
];

class LogFrage {
  String id;

  LogFrage(this.id);


}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Themen Verwaltung',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ThemenVerwaltung(),
    );
  }
}

class ThemenVerwaltung extends StatefulWidget {
  @override
  _ThemenVerwaltungState createState() => _ThemenVerwaltungState();
}

class _ThemenVerwaltungState extends State<ThemenVerwaltung> {
  Teilnehmer teilnehmer = Teilnehmer();
  TextEditingController _controller = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await teilnehmer.load();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> addThema() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        teilnehmer.meineLernfelder.add(LogLernfeld(
          teilnehmer.meineLernfelder.length + 1,
          [],
        ));
      });
      _controller.clear();
      await teilnehmer.save();
    }
  }

  Future<void> deleteThema(int index) async {
    setState(() {
      teilnehmer.meineLernfelder.removeAt(index);
    });
    await teilnehmer.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Themen Verwaltung'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Neues Thema',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addThema,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teilnehmer.meineLernfelder.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Thema ${teilnehmer.meineLernfelder[index].id}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteThema(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
