import 'package:flutter/material.dart';
import 'package:lernplatform/globals/print_colors.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FrageFrame(child: Text("hier könnte auch deine Frage stehen"),),
    );
  }
}

class FrageFrame extends StatelessWidget {
  Widget child;

  FrageFrame({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomContainerWithImage(
          imagePath: 'characters/provokant.webp',
          child: child,
        ),
      ),
    );
  }
}

class CustomContainerWithImage extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final Color _color =Colors.green[900]!;

  CustomContainerWithImage({
    Key? key,
    required this.imagePath,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print_Yellow("CustomContainerWithImage: imagePath = $imagePath");
    return Container(
      // Parent-Container sorgt für Platz für das Bild
      margin: const EdgeInsets.all(40), // Platz für das Bild schaffen
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Der Rahmen
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: _color, width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(16),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 16, 4, 4),
                child: child), // Austauschbarer Inhalt
          ),
          // Das Bild im zweiten Drittel
          Positioned(
            top: -30, // Weiter nach oben verschoben
            left: MediaQuery.of(context).size.width * 0.03, // 2. Drittel - Bildmitte
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: _color, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 60, // Quadratische Größe
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
