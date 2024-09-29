import 'package:flutter/material.dart';

class GrowingProgressBar extends StatefulWidget {
  final double initialValue;
  final String text;

  const GrowingProgressBar({required this.initialValue, required this.text, Key? key}) : super(key: key);

  @override
  _GrowingProgressBarState createState() => _GrowingProgressBarState();
}

class _GrowingProgressBarState extends State<GrowingProgressBar> with SingleTickerProviderStateMixin {
  late double _width;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _width = widget.initialValue;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: _width, end: _width).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = _animation.value;
        });
      });
  }

  void grow(double increment) {
    _animation = Tween<double>(begin: _width, end: _width + increment).animate(_controller);
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        SizedBox(height: 10),
        Container(
          height: 20,
          width: _width,
          color: Colors.blue,
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GlobalKey<_GrowingProgressBarState> _progressBarKey = GlobalKey<_GrowingProgressBarState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grow Progress Bar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GrowingProgressBar(
              key: _progressBarKey,
              initialValue: 100,
              text: 'Laden...',
            ),
            ElevatedButton(
              onPressed: () {
                _progressBarKey.currentState?.grow(10); // Erhöht die Breite des Balkens um 10 Punkte
              },
              child: Text('Grow Progress Bar'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

