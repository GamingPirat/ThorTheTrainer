import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';

class RightDrawer extends StatefulWidget {
  final bool isVisible;
  final DB_Frage db_frage;
  bool frageGesendet = false;

  RightDrawer({super.key, required this.isVisible, required this.db_frage});

  @override
  _RightDrawerState createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

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
      widget.isVisible ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _addQuestionToFirestore(String questionText) async {
    CollectionReference neueFragenRef = FirebaseFirestore.instance.collection('Neue Fragen');

    try {
      await neueFragenRef.add({
        ...widget.db_frage.toJson(),
        'neue_frage': questionText,
      });
      print("Frage und Nachricht erfolgreich hinzugefügt!");
    } catch (e) {
      print("Fehler beim Hinzufügen der Frage: $e");
    }
  }

  void _showAddQuestionDialog({required String title, required String hint, }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddQuestionDialog(
          title: title,
          hint: hint,
          onSend: (questionText) async {
            await _addQuestionToFirestore(questionText);
            setState(() => widget.frageGesendet = true);
            Navigator.of(context).pop(); // Dialog schließen
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                InkWell(
                  onTap: () => _showAddQuestionDialog(
                      title: "Dir ist eine Frage eingefallen?",
                      hint: "Wirf sie in den Pool!"
                  ),
                  child: widget.frageGesendet
                      ? Icon(Icons.thumb_up, size: 48, color: Colors.greenAccent)
                      : Icon(Icons.lightbulb, size: 48, color: iconColor),
                ),
                const Spacer(flex: 1),
                InkWell(
                  onTap: () => _showAddQuestionDialog(
                      title: "Mit der Frage stimmt was nicht?",
                      hint: "Wie würdest du sie verbessern?"
                  ),
                  child: Icon(Icons.note_add, size: 48, color: iconColor),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AddQuestionDialog extends StatefulWidget {
  final Future<void> Function(String) onSend;
  final String title;
  final String hint;

  const AddQuestionDialog({Key? key,
    required this.onSend,
    required this.title,
    required this.hint,
  }) : super(key: key);

  @override
  _AddQuestionDialogState createState() => _AddQuestionDialogState();
}

class _AddQuestionDialogState extends State<AddQuestionDialog> {
  final TextEditingController _textController = TextEditingController();
  bool _hasText = false;
  bool _questionSent = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _textController.text.trim().isNotEmpty;
    });
  }

  void _sendQuestion() async {
    await widget.onSend(_textController.text);
    setState(() {
      _textController.clear();
      _hasText = false;
      _questionSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Expanded(
                  child: _questionSent
                      ? Icon(Icons.thumb_up, size: 48, color: Color(0xFF00FF00))
                      : TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                    expands: true, // Lässt das Textfeld vertikal expandieren
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                if (_questionSent)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text("Nachricht erfolgreich gesendet!"),
                  ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dialog schließen
            _textController.clear();
          },
          child: const Text('Abbrechen'),
        ),
        TextButton(
          onPressed: _hasText ? _sendQuestion : null,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey; // Farbe im deaktivierten Zustand
                }
                return Colors.blue; // Farbe im aktiven Zustand
              },
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey.withOpacity(0.2); // Hintergrund im deaktivierten Zustand
                }
                return Colors.blue.withOpacity(0.1); // Hintergrund im aktiven Zustand
              },
            ),
          ),
          child: const Text('Mitwirken'),
        ),
      ],
    );
  }
}
