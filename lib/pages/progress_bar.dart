import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/log_teilnehmer.dart';

import '../datenklassen/thema.dart';

class ProgressBar extends StatefulWidget {
  final LogThema logThema;

  const ProgressBar({required this.logThema});

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isHighlighted = !isHighlighted;
        });
      },
      child: Container(
        height: 40,
        margin: EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(5),
          boxShadow: isHighlighted
              ? [BoxShadow(color: Colors.yellow, blurRadius: 10, spreadRadius: 2)]
              : [],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              width: widget.logThema.getProgress().clamp(0.0, 1.0) * MediaQuery.of(context).size.width,
              height: 40,
            ),
            Center(
              child: Text(
                widget.logThema.name,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
