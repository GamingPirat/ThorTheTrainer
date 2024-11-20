

import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fire_all_lernfelder() async {
  List<String> returnList = [];

  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection("Alle_Lernfelder")
      .get();

  for (var doc in snapshot.docs) {
    if (doc.data().containsKey("doc_ids") && doc.data()["doc_ids"] is List) {
      List<dynamic> docIds = doc.data()["doc_ids"];
      returnList.addAll(docIds.whereType<String>());
    }
  }

  return returnList;
}





