import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FortschrittSpeicherAnzeigerModel with ChangeNotifier {
  int _filledContainers = 0;
  bool _showSavedText = false;

  int get filledContainers => _filledContainers;
  bool get showSavedText => _showSavedText;

  void set filledContainers(int newCount) {
    for (int i = 0; i <= newCount; i++) {
      Future.delayed(Duration(milliseconds: 30));
      _filledContainers = i;
      notifyListeners();
    }
    if (newCount == 10) {
      Future.delayed(Duration(seconds: 1));
      _showSavedText = true;
      notifyListeners();
      Future.delayed(Duration(seconds: 1));
      _showSavedText = false;
      notifyListeners();
    }
  }
}

class FortschrittSpeicherAnzeiger extends StatelessWidget {
  late FortschrittSpeicherAnzeigerModel _model;

  void updateFilledContainers(int newCount){
    _model.filledContainers = newCount;
  }

  set fortschritt(int value) {
    _model.filledContainers = value;
  }

  int get fortschritt => _model.filledContainers;

  FortschrittSpeicherAnzeiger({super.key, required int fortschritt}) {
    _model = FortschrittSpeicherAnzeigerModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: Consumer<FortschrittSpeicherAnzeigerModel>(
        builder: (context, vm, child) {
            return vm.showSavedText
            ? const Center(
              child: Text(
                'Fortschritt Gespeichert',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(9, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.all(4),
                  color: index < vm.filledContainers ? Colors.green : Colors.grey,
                );
              })
                ..add(AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.all(4),
                  child: Icon(
                    Icons.save,
                    color: vm.filledContainers == 10 ? Colors.green : Colors.grey,
                  ),
                )),
            );
        },
      ),
    );
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
  int _containerCount = 0;

  FortschrittSpeicherAnzeiger containerAnzeige = FortschrittSpeicherAnzeiger(fortschritt: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container Anzeige mit ViewModel'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              containerAnzeige,
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Neue Anzahl Container',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  int? newValue = int.tryParse(_controller.text);
                  if (newValue != null) {
                    setState(() {
                      containerAnzeige.fortschritt = newValue;
                    });
                  }
                },
                child: Text('Aktualisieren'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
