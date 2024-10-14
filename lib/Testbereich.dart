import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ColorScrollWidget extends StatefulWidget {
  @override
  _ColorScrollWidgetState createState() => _ColorScrollWidgetState();
}

class _ColorScrollWidgetState extends State<ColorScrollWidget> with TickerProviderStateMixin {
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
    return Container(
      color: Colors.primaries[index % Colors.primaries.length],
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text(
          "Container $index",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  // Methode zur Steuerung der Animationen und des Wechsels
  void _onScroll(PointerScrollEvent event) {
    if (event.scrollDelta.dy > 0) {
      // Scroll nach unten (nächster Container)
      if (_currentIndex == _containers.length - 1) {
        // Wenn wir am letzten Container sind, einen neuen hinzufügen
        setState(() {
          _containers.add(_buildContainer(_containers.length));
          _isScrollingDown = true;
          _previousIndex = _currentIndex;
          _currentIndex++;
          _startAnimation();
        });
      } else if (_currentIndex < _containers.length - 1) {
        setState(() {
          _isScrollingDown = true;
          _previousIndex = _currentIndex;
          _currentIndex++;
          _startAnimation();
        });
      }
    } else if (event.scrollDelta.dy < 0) {
      // Scroll nach oben (vorheriger Container)
      if (_currentIndex > 0) {
        setState(() {
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

  @override
  Widget build(BuildContext context) {
    return Listener(
      // Erkennung des Scrollens mit dem Mausrad
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          _onScroll(pointerSignal);
        }
      },
      child: Stack(
        children: [
          // SlideTransition für den alten Container (rausgleiten)
          SlideTransition(
            position: _oldContainerAnimation,
            child: _containers[_previousIndex],
          ),
          // SlideTransition für den neuen Container (reingleiten)
          SlideTransition(
            position: _newContainerAnimation,
            child: _containers[_currentIndex],
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ColorScrollWidget(),
    ),
  ));
}
