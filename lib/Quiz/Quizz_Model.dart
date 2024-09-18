import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/Quiz/Frage_Model.dart';
import 'package:login/Quiz/Frage_Service.dart';
import 'package:login/datenbank/frage_und_antwort.dart';
import 'package:login/datenbank/logData/UserLogData.dart';
import 'package:provider/provider.dart';
import 'Jett.dart';


class Quizz_Model with ChangeNotifier {
  double _width = 100;
  double get width => _width;

  List<Log_Thema> selected_LogThemen = [new Log_Thema(thema_id: 1, richtige_fragen: [], falsche_fragen: [])];
  int frageMixer = 5; // es sollen abwechselnd richtig und falsch beantwortete Fragen präsentiert werden
  Frage _frage = dummy_thema.fragen[0];
  get frage => _frage;
  late Log_Thema logThema;
  late Frage_Model _frageModel;
  Frage_Model get  frageModel => _frageModel;

  set frageModel(Frage_Model value){
    _frageModel = value;
    notifyListeners();
  }

  Quizz_Model(){
    logThema = selected_LogThemen[0];
    _frage = _getWrongQ(logThema);
    _frageModel = Frage_Model(frage: _frage);
  }

  bool _isLocked = false;
  bool get isLocked => _isLocked;
  set isLocked(bool value){
    _isLocked = value;
    notifyListeners();
  }
  void btn_clicked() {
    if(isLocked)
      _nextQ();
    else
      _update_ThemaLog();

    isLocked = !isLocked;
  }

  void _nextQ(){
    logThema = selected_LogThemen[Random().nextInt(selected_LogThemen.length)];
    if (frageMixer > 0){
      _frage = _getRightQ(logThema);
      frageMixer++;
    }
    else {
      _frage = _getWrongQ(logThema);
      frageMixer = 5;
    }
    frageModel = Frage_Model(frage: _frage);
  }

  void _update_ThemaLog(){

    /*
    wenn der Benutzer richtig geantwortet hat wird Das FrageLog-Objekt von der
    Liste "falsche_fragen" in die Liste "richtige_fragen" verschoben
    * */

    if(_frageModel.evaluate()["answeredCorrect"] as bool){
      _width = 200;
      notifyListeners();
      print("Ich wachse!");
      if(logThema.falsche_fragen.contains(logThema)){
        logThema.falsche_fragen.remove(frage);
        logThema.richtige_fragen.add(frage);
      }
    }
    else{
      _width = 10;
      notifyListeners();
      print("Ich schrumpfe!");
      if(logThema.richtige_fragen.contains(logThema)){
        logThema.richtige_fragen.remove(frage);
        logThema.falsche_fragen.add(frage);
        _width = 50;
      }
    }
    notifyListeners();
  }

  Frage _getRightQ(Log_Thema current_thema){
    if(current_thema.richtige_fragen.length > 0){
      Log_Frage random_frage = current_thema.richtige_fragen[Random().nextInt(current_thema.richtige_fragen.length)];
      return FrageService().getAnUnseenQuestion(random_frage);
    }
    else{
      return _getWrongQ(current_thema);
    }
  }

  Frage _getWrongQ(Log_Thema current_thema){
    Log_Frage random_frage = current_thema.falsche_fragen[Random().nextInt(current_thema.falsche_fragen.length)];
    return FrageService().getAnUnseenQuestion(random_frage);
  }
}

class LadebalkenDemo extends StatelessWidget {
  final Quizz_Model viewModel = Quizz_Model();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LadebalkenDemo")),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<Quizz_Model>(
          builder: (context, vm, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedProgressBar(width: vm.width),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      vm.btn_clicked();
                      print("clicked");

                    },
                    child: Text('Start'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


void main() {
  runApp(MaterialApp(
    home: LadebalkenDemo(),
  ));
}


// class GrowingProgressBar extends StatefulWidget {
//   final double initialValue;
//   final String text;
//
//   const GrowingProgressBar({required this.initialValue, required this.text, Key? key}) : super(key: key);
//
//   @override
//   _GrowingProgressBarState createState() => _GrowingProgressBarState();
// }
//
// class _GrowingProgressBarState extends State<GrowingProgressBar> with SingleTickerProviderStateMixin {
//   late double _width;
//   late AnimationController _controller;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _width = widget.initialValue;
//
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//
//     _animation = Tween<double>(begin: _width, end: _width).animate(_controller)
//       ..addListener(() {
//         setState(() {
//           _width = _animation.value;
//         });
//       });
//   }
//
//   void grow(double increment) {
//     _animation = Tween<double>(begin: _width, end: _width + increment).animate(_controller);
//     _controller.reset();
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.text),
//         SizedBox(height: 10),
//         Container(
//           height: 20,
//           width: _width,
//           color: Colors.blue,
//         ),
//       ],
//     );
//   }
// }