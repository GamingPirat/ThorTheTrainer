import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';

class FrageDBService {
  List<DB_Frage>? _alleFragenCache;

  Future<List<DB_Frage>> getByInhaltID(int inhaltId) async {
    if (_alleFragenCache != null) {
      return _alleFragenCache!
          .where((frage) => frage.inhalt_id == inhaltId)
          .toList();
    }

    _alleFragenCache = [];
    CollectionReference lernfelderCollection =
    FirebaseFirestore.instance.collection('Lernfelder');

    QuerySnapshot lernfelderSnapshot = await lernfelderCollection.get();
    for (var lernfeldDoc in lernfelderSnapshot.docs) {
      String lernfeldId = lernfeldDoc.id;
      String subcollectionName = '$lernfeldId Fragen';
      CollectionReference fragenCollection =
      lernfelderCollection.doc(lernfeldId).collection(subcollectionName);

      QuerySnapshot snapshot = await fragenCollection.get();
      var fragen = snapshot.docs
          .map((doc) =>
          DB_Frage.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      _alleFragenCache!.addAll(fragen);
    }

    return _alleFragenCache!
        .where((frage) => frage.inhalt_id == inhaltId)
        .toList();
  }

  Future<void> updateFrage(DB_Frage frage) async {
    String collectionName = '${frage.inhalt_id} Fragen';

    await FirebaseFirestore.instance
        .collection('Lernfelder')
        .doc(frage.inhalt_id.toString())
        .collection(collectionName)
        .doc(frage.id)
        .update(frage.toJson())
        .then((_) => print("Frage ${frage.id} erfolgreich aktualisiert"))
        .catchError((error) =>
        print("Fehler beim Aktualisieren der Frage ${frage.id}: $error"));
  }

  void clearCache() {
    _alleFragenCache = null;
  }
}
