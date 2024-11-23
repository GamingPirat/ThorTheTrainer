import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lernplatform/pages/Quiz/quiz_inhalt_widget.dart';
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
  bool _isAnimating = false;

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

    // Standard-Initialisierung der Animationen
    _oldContainerAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_controller);
    _newContainerAnimation = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(_controller);
  }

  // Methode zum Erstellen eines neuen Containers
  Widget _buildContainer(int index) {
    viewModel.nextQuestion();
    return QuizInhaltWidget(viewModel: viewModel.aktueller_inhalt);
  }

  void _onScroll(double dy) {
    if (_isAnimating) return; // Verhindere mehrfaches Scrollen während einer Animation
    if (dy > 0 && _currentIndex < _containers.length - 1) {
      _navigateToNext();
    } else if (dy < 0 && _currentIndex > 0) {
      _navigateToPrevious();
    } else if (dy > 0 && _currentIndex == _containers.length - 1 && viewModel.is_locked) {
      _addAndNavigateToNext();
    }
  }

  void _navigateToNext() {
    setState(() {
      _isScrollingDown = true;
      _previousIndex = _currentIndex;
      _currentIndex++;
      _startAnimation();
    });
  }

  void _navigateToPrevious() {
    setState(() {
      _isScrollingDown = false;
      _previousIndex = _currentIndex;
      _currentIndex--;
      _startAnimation();
    });
  }

  void _addAndNavigateToNext() {
    setState(() {
      _containers.add(_buildContainer(_containers.length));
      _isScrollingDown = true;
      _previousIndex = _currentIndex;
      _currentIndex++;
      _startAnimation();
    });
  }

  // Animation starten
  void _startAnimation() {
    _isAnimating = true;

    _controller.reset();

    _oldContainerAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: _isScrollingDown ? Offset(0.0, -1.0) : Offset(0.0, 1.0),
    ).animate(_controller);

    _newContainerAnimation = Tween<Offset>(
      begin: _isScrollingDown ? Offset(0.0, 1.0) : Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(_controller);

    _controller.forward().whenComplete(() {
      setState(() => _isAnimating = false); // Animation abgeschlossen
    });
  }

  void _onScrollWheel(PointerSignalEvent event) {
    if (event is PointerScrollEvent && !_isAnimating) {
      _onScroll(event.scrollDelta.dy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Session().appBar,
      drawer: Session().drawer,
      body: Stack(
        children: [
          Session().background,
          Listener(
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
