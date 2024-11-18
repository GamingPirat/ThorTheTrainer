import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math';

class MyBackGround extends StatefulWidget {

  static MyBackGround? _instance;

  const MyBackGround._internal({
    Key? key,
  }) : super(key: key);

  // Factory Constructor für das Singleton
  factory MyBackGround() {
    return _instance ??= MyBackGround._internal();
  }

  @override
  State<MyBackGround> createState() => _MyBackGroundState();
}


class _MyBackGroundState extends State<MyBackGround> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> initialPoints;
  late List<Offset> targetPoints;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 500), // Animationszyklus von 5 Sekunden
      vsync: this,
    )
      ..addListener(() {
        setState(() {}); // Frame-Aktualisierungen
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(); // Rückwärts abspielen
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward(); // Vorwärts abspielen
        }
      })
      ..forward(); // Animation starten

    // Initiale Positionen basierend auf der Farbenanzahl im Painter
    int numberOfPoints = MyCustomPainter.pointColors.length;
    initialPoints = List.generate(
      numberOfPoints,
          (index) => Offset(
        Random().nextDouble() * 0.8 + 0.1,
        Random().nextDouble() * 0.8 + 0.1,
      ),
    );

    // Zielpositionen basierend auf der Farbenanzahl im Painter
    targetPoints = List.generate(
      numberOfPoints,
          (index) => Offset(
        Random().nextDouble() * 0.8 + 0.1,
        Random().nextDouble() * 0.8 + 0.1,
      ),
    );
  }

  @override
  void dispose() {
    _controller.stop(); // Animation sicher stoppen
    _controller.dispose(); // Ressourcen freigeben
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: MyCustomPainter(
        Theme.of(context),
        _controller.value, // Animationsfortschritt
        initialPoints,
        targetPoints,
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final ThemeData theme;
  final double animationValue;
  final List<Offset> initialPoints;
  final List<Offset> targetPoints;

  // Farben der Punkte im Painter definiert
  static final List<Color> pointColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];

  MyCustomPainter(
      this.theme,
      this.animationValue,
      this.initialPoints,
      this.targetPoints,
      );

  @override
  void paint(Canvas canvas, Size size) {
    // Punkte interpolieren
    List<Offset> animatedPoints = List.generate(
      initialPoints.length,
          (index) => Offset(
        lerpDouble(initialPoints[index].dx, targetPoints[index].dx, animationValue)!,
        lerpDouble(initialPoints[index].dy, targetPoints[index].dy, animationValue)!,
      ),
    );

    // Verbindungslinien zwischen den Punkten
    for (int i = 0; i < animatedPoints.length; i++) {
      for (int j = i + 1; j < animatedPoints.length; j++) {
        final linePaint = Paint()
          ..color = (theme.brightness == Brightness.light ? Colors.black : Colors.white).withOpacity(0.1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.5; // Hauchdünne Linie

        // Linie zeichnen
        canvas.drawLine(
          Offset(animatedPoints[i].dx * size.width, animatedPoints[i].dy * size.height),
          Offset(animatedPoints[j].dx * size.width, animatedPoints[j].dy * size.height),
          linePaint,
        );
      }
    }

    // Punkte zeichnen
    for (int i = 0; i < animatedPoints.length; i++) {
      final circlePaint = Paint()
        ..color = pointColors[i]
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 18.0); // Größerer Leuchteffekt

      canvas.drawCircle(
        Offset(animatedPoints[i].dx * size.width, animatedPoints[i].dy * size.height),
        size.width * 0.02,
        circlePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleThemeMode() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animierter Microchip',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: MyBackGround(),
    );
  }
}
