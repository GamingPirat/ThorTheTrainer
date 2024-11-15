import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';

class FrageDBService {
  // Liste, um alle geladenen Fragen für diese Instanz zu speichern
  List<DB_Frage>? _alleFragenCache;

  // Methode zum Abrufen von Fragen nach Inhalt-ID, nutzt Caching
  Future<List<DB_Frage>> getByInhaltID(int inhaltId) async {
    // Prüfen, ob der Cache bereits befüllt ist
    if (_alleFragenCache != null) {
      // Filtere die gecachten Fragen basierend auf inhaltId
      return _alleFragenCache!.where((frage) => frage.inhalt_id == inhaltId).toList();
    }

    // Wenn der Cache leer ist, laden wir alle Fragen aus Firebase
    _alleFragenCache = [];
    CollectionReference lernfelderCollection = FirebaseFirestore.instance.collection('Lernfelder');

    QuerySnapshot lernfelderSnapshot = await lernfelderCollection.get();
    for (var lernfeldDoc in lernfelderSnapshot.docs) {
      String lernfeldId = lernfeldDoc.id;
      String subcollectionName = '$lernfeldId Fragen';
      CollectionReference fragenCollection = lernfelderCollection
          .doc(lernfeldId)
          .collection(subcollectionName);

      QuerySnapshot snapshot = await fragenCollection.get();
      var fragen = snapshot.docs.map((doc) => DB_Frage.fromJson(doc.data() as Map<String, dynamic>)).toList();
      _alleFragenCache!.addAll(fragen);
    }

    // Rückgabe der gefilterten Fragen basierend auf inhaltId
    return _alleFragenCache!.where((frage) => frage.inhalt_id == inhaltId).toList();
  }

  // Methode zum Leeren des Caches (z.B. wenn man die Daten aktualisieren möchte)
  void clearCache() {
    _alleFragenCache = null;
  }
}
