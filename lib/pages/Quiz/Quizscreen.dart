import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lernplatform/pages/Quiz/quiz_subthema_widget.dart';
import 'package:lernplatform/pages/Quiz/quizmaster.dart';
import 'package:lernplatform/globals/print_colors.dart';
import 'package:lernplatform/globals/session.dart';

class QuizScreen extends StatefulWidget {

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  late Quizmaster viewModel;
  late List<Widget> _containers;
  int _currentIndex = 0;
  int _previousIndex = 0;
  bool _isScrollingDown = true;

  late AnimationController _controller;
  late Animation<Offset> _oldContainerAnimation;
  late Animation<Offset> _newContainerAnimation;

  @override
  void initState() {
    super.initState();

    viewModel = Quizmaster();

    // Initialisiere die Liste mit nur einem Container
    _containers = [_buildContainer(0)];

    // Initialisierung des AnimationControllers
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    // Standard-Initialisierung der Animationen auf null Offset
    _oldContainerAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_controller);
    _newContainerAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_controller);
  }

  // Methode zum Erstellen eines neuen Containers
  Widget _buildContainer(int index) {
    viewModel.nextQuestion();
    return QuizSubthemaWidget(viewModel: viewModel.aktuelles_subthema);
  }

  void _onScroll(double dy) {
    // print_Magenta("QuizScreen scrollen erfasst: Delta = $dy"); // todo print

    if (dy > 0) {
      // Scroll nach unten (nächster Container)
      // print_Magenta("QuizScreen Scroll nach unten "
      //     "_currentIndex == _containers.length "
      //     "${_currentIndex == _containers.length} "
      //     "$_currentIndex == ${_containers.length} "
          // "viewModel.is_locked == ${viewModel.is_locked}"); // todo print
      if (_currentIndex == _containers.length - 1 && viewModel.is_locked) {
        setState(() {
          // print_Magenta("QuizScreen Scroll nach unten (nächster Container"); // todo print
          _containers.add(_buildContainer(_containers.length));
          _isScrollingDown = true;
          _previousIndex = _currentIndex;
          _currentIndex++;
          _startAnimation();
        });
      } else if (_currentIndex < _containers.length - 1) {
        setState(() {
          // print_Magenta("QuizScreen Scroll nach unten (nächster Container"); // todo print
          _isScrollingDown = true;
          _previousIndex = _currentIndex;
          _currentIndex++;
          _startAnimation();
        });
      }
    } else if (dy < 0) {
      // Scroll nach oben (vorheriger Container)
      if (_currentIndex > 0) {
        setState(() {
          // print_Magenta("QuizScreen Scroll nach oben (vorheriger Container"); // todo print
          _isScrollingDown = false;
          _previousIndex = _currentIndex;
          _currentIndex--;
          _startAnimation();
        });
      }
    }
  }

  // Animationen für den Wechsel zwischen Containern
  void _startAnimation() {
    _controller.reset();

    // Alte Container-Animation: Scrollt nach oben oder unten raus
    _oldContainerAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: _isScrollingDown ? Offset(0.0, -1.0) : Offset(0.0, 1.0),
    ).animate(_controller);

    // Neue Container-Animation: Scrollt von unten oder oben rein
    _newContainerAnimation = Tween<Offset>(
      begin: _isScrollingDown ? Offset(0.0, 1.0) : Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward();
  }


  void _onScrollWheel(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      final dy = event.scrollDelta.dy;
      if (dy != 0) {
        _onScroll(dy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Session().appBar,
      drawer: Session().drawer,
      body: Listener(
        onPointerSignal: _onScrollWheel,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta != null) {
              _onScroll(details.primaryDelta!);
            }
          },
          child: Stack(
            children: [
              SlideTransition(
                position: _oldContainerAnimation,
                child: _containers[_previousIndex],
              ),
              SlideTransition(
                position: _newContainerAnimation,
                child: _containers[_currentIndex],
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
