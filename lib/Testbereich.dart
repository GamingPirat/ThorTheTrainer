import 'package:flutter/material.dart';

class ProgressIcons extends StatelessWidget {
  final int points;

  ProgressIcons({required this.points});

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.star,
      Icons.favorite,
      Icons.check_circle,
      Icons.thumb_up,
      Icons.emoji_events,
      Icons.flash_on,
      Icons.verified,
      Icons.grade,
      Icons.trending_up,
      Icons.military_tech,
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: icons.map((icon) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              '$points',
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ],
        );
      }).toList(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: ProgressIcons(points: 8),
      ),
    ),
  ));
}
