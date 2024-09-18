import 'dart:convert'; // Für JSON-Konvertierung
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Für den Zugriff auf den lokalen Speicher

class Teilnehmer {
  late List<LogThema> meineThemen;

  Teilnehmer() {
    load();
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? gespeicherteDaten = prefs.getString('ThorTheTrainerStudent');

    if (gespeicherteDaten != null) {
      List<dynamic> jsonList = jsonDecode(gespeicherteDaten);
      meineThemen = jsonList.map((item) => LogThema.fromJson(item)).toList();
    } else {
      meineThemen = [];
    }
  }

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList =
    meineThemen.map((thema) => thema.toJson()).toList();
    prefs.setString('ThorTheTrainerStudent', jsonEncode(jsonList));
  }
}

class LogThema {
  int id;
  List<LogSubThema> meineSubThemen;

  LogThema(this.id, this.meineSubThemen);

  factory LogThema.fromJson(Map<String, dynamic> json) {
    var list = json['meineSubThemen'] as List;
    List<LogSubThema> subThemenList =
    list.map((i) => LogSubThema.fromJson(i)).toList();
    return LogThema(json['id'], subThemenList);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meineSubThemen': meineSubThemen.map((subThema) => subThema.toJson()).toList(),
    };
  }
}

class LogSubThema {
  int id;
  List<LogFrage> offeneFragen;

  LogSubThema(this.id, this.offeneFragen);

  factory LogSubThema.fromJson(Map<String, dynamic> json) {
    var list = json['offeneFragen'] as List;
    List<LogFrage> fragenList = list.map((i) => LogFrage.fromJson(i)).toList();
    return LogSubThema(json['id'], fragenList);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offeneFragen': offeneFragen.map((frage) => frage.toJson()).toList(),
    };
  }
}

class LogFrage {
  String id;

  LogFrage(this.id);

  factory LogFrage.fromJson(Map<String, dynamic> json) {
    return LogFrage(json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
    };
  }
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
        teilnehmer.meineThemen.add(LogThema(
          teilnehmer.meineThemen.length + 1,
          [],
        ));
      });
      _controller.clear();
      await teilnehmer.save();
    }
  }

  Future<void> deleteThema(int index) async {
    setState(() {
      teilnehmer.meineThemen.removeAt(index);
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
              itemCount: teilnehmer.meineThemen.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Thema ${teilnehmer.meineThemen[index].id}'),
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
