import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/globals/print_colors.dart';

class FrageDBService {
  FrageDBService._privateConstructor();
  static final FrageDBService _instance = FrageDBService._privateConstructor();
  factory FrageDBService() => _instance;

  List<DB_Frage>? _alleFragenCache;

  Future<List<DB_Frage>> getByInhaltID(int inhaltId) async {
    if (_alleFragenCache != null) {
      return _alleFragenCache!
          .where((frage) {
        return frage.inhalt_id == inhaltId;
      }).toList();
    }

    _alleFragenCache = [];
    CollectionReference lernfelderCollection =
    FirebaseFirestore.instance.collection('Lernfelder');

    QuerySnapshot lernfelderSnapshot = await lernfelderCollection.get();

    for (var lernfeldDoc in lernfelderSnapshot.docs) {
      String lernfeldId = lernfeldDoc.id;
      String subcollectionName = '${lernfeldDoc.id} Fragen';
      CollectionReference fragenCollection =
      lernfelderCollection.doc(lernfeldId).collection(subcollectionName);

      try {
        QuerySnapshot snapshot = await fragenCollection.get();
        for (var doc in snapshot.docs) {
          try {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            if (data['inhalt_id'] is String) {
              data['inhalt_id'] = int.tryParse(data['inhalt_id']) ?? 0;
            }
            var frage = DB_Frage.fromJson(data);
            _alleFragenCache!.add(frage);
          } catch (error) {
            print_Red('Fehler beim Verarbeiten der Frage in Dokument-ID ${doc.id}: $error');
          }
        }
      } catch (e) {
        print_Red('Fehler beim Laden der Fragen für $lernfeldId (${lernfeldDoc['name']}): $e');
      }
    }

    var gefilterteFragen = _alleFragenCache!
        .where((frage) {
      return frage.inhalt_id == inhaltId;
    }).toList();

    return gefilterteFragen;
  }





  Future<void> updateFrage(DB_Frage frage) async {
    String collectionName = 'Fragen'; // Fix: Einheitlicher Subcollection-Name

    try {
      await FirebaseFirestore.instance
          .collection('Lernfelder')
          .doc(frage.inhalt_id.toString())
          .collection(collectionName)
          .doc(frage.id)
          .update(frage.toJson());
    } catch (error) {
      print_Red("Fehler beim Aktualisieren der Frage ${frage.id}: $error");
    }
  }

  void clearCache() {
    _alleFragenCache = null;
  }
}
