import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/updated/fragen_bearbeiten/fragen_list.dart';

class LernfelderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lernfelder")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Lernfelder')
            .orderBy('name') // Alphabetische Sortierung auf Firestore-Ebene
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Keine Lernfelder verfügbar."));
          }

          return ListView(
            children: snapshot.data!.docs.map((lernfeldDoc) {
              return ExpansionTile(
                title: Text(lernfeldDoc['name']),
                children: [
                  KompetenzbereicheList(lernfeldId: lernfeldDoc.id),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class KompetenzbereicheList extends StatelessWidget {
  final String lernfeldId;
  const KompetenzbereicheList({required this.lernfeldId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Lernfelder')
          .doc(lernfeldId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Sortierung der Kompetenzbereiche lokal
        var kompetenzbereiche = (snapshot.data!['kompetenzbereiche'] as List<dynamic>);

        return Column(
          children: kompetenzbereiche.map((kompetenz) {
            var inhalte = kompetenz['inhalte'] as List<dynamic>;

            return ExpansionTile(
              title: Text("\t\t\t\t\t${kompetenz['name']}"),
              children: inhalte.map((inhalt) {
                return ListTile(
                  title: Text("\t\t\t\t\t\t\t\t\t\t${inhalt['name']}"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FragenList(
                          inhaltId: inhalt['id'],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }).toList(),
        );
      },
    );
  }
}