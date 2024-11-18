

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> fire_all_lernfelder() async{
  List<String> return_list = [];

  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
      .collection("Alle_Lernfelder")
      .get();

  for (var doc in snapshot.docs) {
    if (doc.data().containsKey("lernfelder") && doc.data()["lernfelder"] is List) {
      List<dynamic> lernfelder = doc.data()["lernfelder"];
      return_list.addAll(lernfelder.whereType<String>());
    }
  }

  return return_list;
}




