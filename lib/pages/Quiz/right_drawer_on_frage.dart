import 'package:flutter/material.dart';

class RightDrawer extends StatefulWidget {
  final bool isVisible; // Der boolean-Wert, der die Animation steuert

  const RightDrawer({super.key, required this.isVisible});

  @override
  _RightDrawerState createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start außerhalb des Bildschirms (rechts)
      end: Offset.zero, // Ende auf der Bildschirmfläche
    ).animate(_controller);

    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void didUpdateWidget(RightDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isVisible != widget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDialog() {
    setState(() {
      _isDialogVisible = true;
    });
  }

  void _hideDialog() {
    setState(() {
      _isDialogVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Hier wird die Farbe dynamisch aus dem aktuellen Theme abgerufen
    Color iconColor = Theme.of(context).iconTheme.color!.withOpacity(0.5);

    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: SlideTransition(
            position: _offsetAnimation,
            child: Column(
              children: [
                const Spacer(flex: 3),
                // IconButton(
                //   icon: Icon(Icons.thumb_down, size: 48, color: iconColor),
                //   onPressed: _showDialog,
                // ),
                // const Spacer(flex: 1),
                InkWell(
                  onTap: _showDialog,
                  child: Column(
                    children: [
                      Icon(Icons.lightbulb, size: 48, color: iconColor),
                      Text("Dir"),
                      Text("ist eine"),
                      Text("Frage"),
                      Text("eingefallen?"),
                      Text("Spende"),
                      Text("ne Frage."),
                      Text("Erweitere"),
                      Text("den Pool."),
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                InkWell(
                  onTap: _showDialog,
                  child: Column(
                    children: [
                      Icon(Icons.note_add, size: 48, color: iconColor),
                      Text("Diese Frage ist"),
                      Text("verbesserungswürdig?"),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
        // Das überlagernde Dialog-Fenster
        if (_isDialogVisible)
          GestureDetector(
            onTap: _hideDialog, // Schließt das Fenster bei Tap außerhalb
            child: Container(
              color: Colors.black.withOpacity(0.5), // Dimm-Effekt
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor, // Dynamische Hintergrundfarbe
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Feature wird noch entwickelt',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: _hideDialog,
                              child: const Text('Abbrechen'),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                // Logik für den Bestätigungsbutton
                                _hideDialog();
                              },
                              child: const Text('Akzeptieren'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
