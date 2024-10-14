import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ColorScrollWidget extends StatefulWidget {
  @override
  _ColorScrollWidgetState createState() => _ColorScrollWidgetState();
}

class _ColorScrollWidgetState extends State<ColorScrollWidget> {
  late List<Container> _containers;

  int _currentIndex = 0;

  @override
  void initState() {
    _containers = [
      _buildContainer(0),
    ];
    super.initState();
  }

  Container _buildContainer(int index) {
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

  void _onScroll(PointerScrollEvent event) {
    if (event.scrollDelta.dy > 0) {
      // Scroll down
      setState(() {
        _currentIndex++;
        if (_currentIndex >= _containers.length) {
          _containers.add(_buildContainer(_currentIndex));
        }
      });
    } else if (event.scrollDelta.dy < 0 && _currentIndex > 0) {
      // Scroll up
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          _onScroll(pointerSignal);
        }
      },
      child: _containers[_currentIndex],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ColorScrollWidget(),
    ),
  ));
}
