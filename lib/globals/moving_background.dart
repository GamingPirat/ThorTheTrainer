import 'package:flutter/material.dart';
import 'package:lernplatform/pages/Startseiten/enter_page.dart';

// class MovingBackground extends StatefulWidget {
//   final String image_path;
//   const MovingBackground({super.key, required this.image_path});
//
//   @override
//   _MovingBackgroundState createState() => _MovingBackgroundState();
// }
//
// class _MovingBackgroundState extends State<MovingBackground>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 20), // Geschwindigkeit der Bewegung
//     )..repeat(); // Wiederholt die Animation endlos
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
//     return Scaffold(
//       body: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, child) {
//           return Transform.translate(
//             offset: Offset(0, -200 * _controller.value), // Bewegung nach oben
//             child: child,
//           );
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(widget.image_path),
//               fit: BoxFit.cover, // Passt das Bild an den Bildschirm an
//               onError: (exception, stackTrace) {
//                 print("Bild konnte nicht geladen werden: $exception");
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ParallaxZoomBackground extends StatefulWidget {
  final Widget child;
  final String image_path;

  ParallaxZoomBackground({super.key, required this.child, required this.image_path});

  @override
  _ParallaxZoomBackgroundState createState() => _ParallaxZoomBackgroundState();
}

class _ParallaxZoomBackgroundState extends State<ParallaxZoomBackground> {
  final ScrollController _foregroundController = ScrollController();
  final ScrollController _backgroundController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Synchronisiere den Hintergrund-Scrollcontroller mit halber Geschwindigkeit
    _foregroundController.addListener(() {
      if (_foregroundController.hasClients && _backgroundController.hasClients) {
        _backgroundController.jumpTo(_foregroundController.offset * 0.32);
      }
    });
  }

  @override
  void dispose() {
    _foregroundController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Hintergrundbild mit eigenem ScrollController
          ListView(
            controller: _backgroundController, // Separater ScrollController
            physics: NeverScrollableScrollPhysics(), // Manuelles Scrollen durch Synchronisierung
            children: [
              Container(
                height: screenHeight * 2, // Bildhöhe verdoppelt
                decoration: BoxDecoration(
                  color: Colors.black, // Fallback-Hintergrundfarbe
                  image: widget.image_path != null
                      ? DecorationImage(
                    image: AssetImage(widget.image_path),
                    fit: BoxFit.cover,
                  )
                      : null, // Kein Bild, nur die Fallback-Farbe
                ),
              ),
            ],
          ),
          // Vordergrund: Scrollbereich ohne ListView
          SingleChildScrollView(
            controller: _foregroundController, // Hauptscrollen
            child: Container(
              height: screenHeight * 4, // Voller Scrollbereich
              child: widget.child
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Große Textkörper
          bodyMedium: TextStyle(color: Colors.white), // Standard-Textkörper
          bodySmall: TextStyle(color: Colors.white), // Kleine Texte
          headlineLarge: TextStyle(color: Colors.white), // Große Titel
          headlineMedium: TextStyle(color: Colors.white), // Mittlere Titel
          headlineSmall: TextStyle(color: Colors.white), // Kleine Titel
        ),
      ),

      home: ParallaxZoomBackground(image_path:'assets/phone_like.png', child: EnterPage()),
    );
  }
}

void main() {
  runApp(const MyApp());
}
