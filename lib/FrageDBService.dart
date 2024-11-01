import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';

class FrageDBService {

  late final CollectionReference _fragenCollection;

  FrageDBService({required String dateiname }) : _fragenCollection = FirebaseFirestore.instance.collection(dateiname);


  // Create (neue Frage ohne ID, Firestore generiert automatisch eine ID)
  Future<void> createFrage(DB_Frage frage) async {
    await _fragenCollection.add(frage.toJson());
    print("### FrageDBService createFrage: Neue Frage hinzugefügt.\n$frage");
  }

  Future<List<DB_Frage>> getFragenById(String id) async {
    QuerySnapshot snapshot = await _fragenCollection.where(FieldPath.documentId, isEqualTo: id).get();
    return snapshot.docs.map((doc) => DB_Frage.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  // Read (alle Fragen mit einer bestimmten themaID lesen)
  Future<List<DB_Frage>> getByThemaID(int themaID) async {
    QuerySnapshot snapshot = await _fragenCollection.where('themaID', isEqualTo: themaID).get();
    print("### FrageDBService getByThemaID:");
    for (DB_Frage frage in snapshot.docs.map((doc) => DB_Frage.fromJson(doc.data() as Map<String, dynamic>)).toList()) {
      print(frage);
    }
    return snapshot.docs.map((doc) => DB_Frage.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  // Update (eine Frage updaten)
  Future<void> updateFrage(String id, DB_Frage neueFrage) async {
    // Prüfe, ob das Dokument mit der angegebenen ID existiert
    DocumentSnapshot docSnapshot = await _fragenCollection.doc(id).get();

    if (docSnapshot.exists) {
      // Dokument mit dieser ID existiert, also wird es aktualisiert
      await _fragenCollection.doc(id).update(neueFrage.toJson());
      print("### FrageDBService updateFrage: Dokument mit ID $id aktualisiert.\n$neueFrage");
    } else {
      // Dokument existiert nicht, Fehler werfen
      throw Exception("Fehler: Dokument mit ID $id existiert nicht.");
    }
  }

  // Delete (eine Frage löschen)
  Future<void> deleteFrage(String id) async {
    await _fragenCollection.doc(id).delete();
    print("### FrageDBService deleteFrage: Frage mit ID $id gelöscht.");
  }
}
