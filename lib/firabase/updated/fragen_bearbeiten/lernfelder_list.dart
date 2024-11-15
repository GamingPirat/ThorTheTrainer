import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/firabase/updated/fragen_bearbeiten/fragen_list.dart';

class LernfelderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lernfelder")),
      body: Row(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Lernfelder').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
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
          ),
        ],
      ),
    );
  }
}


class KompetenzbereicheList extends StatelessWidget {
  final String lernfeldId;
  KompetenzbereicheList({required this.lernfeldId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Lernfelder')
          .doc(lernfeldId)
          .collection('Kompetenzbereiche')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Column(
          children: snapshot.data!.docs.map((kompetenzDoc) {
            return ExpansionTile(
              title: Text(kompetenzDoc['name']),
              children: [
                InhalteList(
                  lernfeldId: lernfeldId,
                  kompetenzId: kompetenzDoc.id,
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

class InhalteList extends StatelessWidget {
  final String lernfeldId, kompetenzId;
  InhalteList({required this.lernfeldId, required this.kompetenzId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Lernfelder')
          .doc(lernfeldId)
          .collection('Kompetenzbereiche')
          .doc(kompetenzId)
          .collection('Inhalte')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Column(
          children: snapshot.data!.docs.map((inhaltDoc) {
            return ListTile(
              title: Text(inhaltDoc['name']),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FragenList(
                      lernfeldId: lernfeldId,
                      kompetenzId: kompetenzId,
                      inhaltId: inhaltDoc.id,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
