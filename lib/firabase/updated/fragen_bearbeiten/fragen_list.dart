import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/updated/fragen_bearbeiten/frage_editor.dart';

class FragenList extends StatelessWidget {
  final String lernfeldId, kompetenzId, inhaltId;
  FragenList({required this.lernfeldId, required this.kompetenzId, required this.inhaltId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fragen für Inhalt $inhaltId")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Lernfelder')
            .doc(lernfeldId)
            .collection('Kompetenzbereiche')
            .doc(kompetenzId)
            .collection('Inhalte')
            .doc(inhaltId)
            .collection('Fragen')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: snapshot.data!.docs.map((frageDoc) {
              return ExpansionTile(
                title: Text(frageDoc['text']),
                children: [
                  FrageDetailEditor(
                    frageDoc: frageDoc,
                    lernfeldId: lernfeldId,
                    kompetenzId: kompetenzId,
                    inhaltId: inhaltId,
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
