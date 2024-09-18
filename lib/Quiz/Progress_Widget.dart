import 'dart:math';

import 'package:flutter/material.dart';

class Progress_Widget extends StatefulWidget {
  final int progress;
  final String text;
  final int max;

  const Progress_Widget({Key? key, required this.progress, required this.text, required this.max}) : super(key: key);

  @override
  _Progress_WidgetState createState() => _Progress_WidgetState();
}

class _Progress_WidgetState extends State<Progress_Widget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _shadowAnimation;
  late int _previousProgress;
  late String _previousText;
  bool _shouldShowShadow = true;

  @override
  void initState() {
    super.initState();
    _previousProgress = widget.progress;
    _previousText = widget.text;
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(begin: _previousProgress / widget.max, end: widget.progress / widget.max).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _shadowAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant Progress_Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool progressChanged = oldWidget.progress != widget.progress;
    bool textChanged = oldWidget.text != widget.text;

    if (textChanged) {
      _shouldShowShadow = false;
    } else if (progressChanged) {
      _previousProgress = oldWidget.progress;
      _animation = Tween<double>(begin: _previousProgress / widget.max, end: widget.progress / widget.max).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _shouldShowShadow = true;
      _shadowAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: _controller.isAnimating ? widget.progress < _previousProgress ? Colors.redAccent : Colors.greenAccent : Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      boxShadow: _shouldShowShadow
          ? [
        BoxShadow(
          color: (widget.progress < _previousProgress ? Colors.redAccent : Colors.greenAccent)
              .withOpacity(_shadowAnimation.value),
          blurRadius: 20 * _shadowAnimation.value,
          spreadRadius: 5 * _shadowAnimation.value,
        ),
      ]
          : [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              width: _animation.value * MediaQuery.of(context).size.width,
              height: 20,
              decoration: _getBoxDecoration(),
            ),
          ],
        ),
      ],
    );
  }
}




class LadebalkenDemo extends StatefulWidget {
  @override
  _LadebalkenDemoState createState() => _LadebalkenDemoState();
}

class _LadebalkenDemoState extends State<LadebalkenDemo> {
  int progress = 0;
  int max = 100;
  String text = "Hallo Welt!";

  void incrementProgress() {
    setState(() {
      progress += 10;
      if (progress > max) progress = max;
    });
  }

  void decrementProgress() {
    setState(() {
      progress -= 10;
      if (progress < 0) progress = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animierter Ladebalken'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Progress_Widget(progress: progress, text: text, max: max),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: incrementProgress,
                  child: Text('Füllen'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: decrementProgress,
                  child: Text('Leeren'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      text = String.fromCharCodes(
                        List.generate(12, (index) => Random().nextInt(26) + 65),
                      );
                    });
                  },
                  child: Text('Text ändern'),
                )
              ],
            ),
          ],
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
