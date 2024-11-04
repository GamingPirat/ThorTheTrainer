import 'package:flutter/material.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:provider/provider.dart';

class PunkteAnzeige extends StatelessWidget {
  late PunkteModel _model;

  int get punkte => _model.punkte;
  set punkte(int value) {
    _model.animatePunkte(value);
  }

  PunkteAnzeige({super.key, required int punkte}) {
    _model = PunkteModel(punkte: punkte);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Consumer<PunkteModel>(
        builder: (context, vm, child) {
          return Text(
            vm.punkte.toString(),
            style: TextStyle(fontSize: 40),
          );
        },
      ),
    );
  }
}

class PunkteModel with ChangeNotifier {
  late int _punkte;
  late int _oldPunkte;

  int get punkte => _punkte;

  set punkte(int value) {
    _punkte = value;
    notifyListeners();
  }

  PunkteModel({required int punkte}) {
    _punkte = punkte;
    _oldPunkte = punkte;
  }

  void animatePunkte(int newPunkte) {
    if (newPunkte != _punkte) {
      _oldPunkte = _punkte;
      _animate(newPunkte);
    }
  }

  void _animate(int newPunkte) async {
    if (_oldPunkte < newPunkte) {
      for (int i = _oldPunkte; i <= newPunkte; i++) {
        await Future.delayed(Duration(milliseconds: 50));
        _punkte = i;
        notifyListeners();
      }
    } else {
      for (int i = _oldPunkte; i >= newPunkte; i--) {
        await Future.delayed(Duration(milliseconds: 50));
        _punkte = i;
        notifyListeners();
      }
    }
  }
}

void main() {
  runApp(TestApp());
}

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  final TextEditingController _controller = TextEditingController();
  int _punkte = 0;

  PunkteAnzeige punkteAnzeige = PunkteAnzeige(punkte: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PunkteAnzeige Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              punkteAnzeige,
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Neue Punkte',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  int? newPunkte = int.tryParse(_controller.text);
                  if (newPunkte != null) {
                    punkteAnzeige.punkte = newPunkte;
                  }
                },
                child: Text('Punkte Aktualisieren'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
