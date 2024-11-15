import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FrageDetailEditor extends StatefulWidget {
  final QueryDocumentSnapshot frageDoc;
  final String lernfeldId, kompetenzId, inhaltId;

  FrageDetailEditor({
    required this.frageDoc,
    required this.lernfeldId,
    required this.kompetenzId,
    required this.inhaltId,
  });

  @override
  _FrageDetailEditorState createState() => _FrageDetailEditorState();
}

class _FrageDetailEditorState extends State<FrageDetailEditor> {
  late TextEditingController textController;
  late TextEditingController punkteController;
  // Weitere Controller für andere Attribute können hier hinzugefügt werden

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.frageDoc['text']);
    punkteController = TextEditingController(text: widget.frageDoc['punkte'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: textController,
          decoration: InputDecoration(labelText: "Frage Text"),
        ),
        TextField(
          controller: punkteController,
          decoration: InputDecoration(labelText: "Punkte"),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Lernfelder')
                .doc(widget.lernfeldId)
                .collection('Kompetenzbereiche')
                .doc(widget.kompetenzId)
                .collection('Inhalte')
                .doc(widget.inhaltId)
                .collection('Fragen')
                .doc(widget.frageDoc.id)
                .update({
              'text': textController.text,
              'punkte': int.tryParse(punkteController.text) ?? 0,
              // Weitere Attribute hier aktualisieren
            });
          },
          child: Text("Speichern"),
        ),
      ],
    );
  }
}
