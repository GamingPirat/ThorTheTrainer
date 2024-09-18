import 'package:http/http.dart' as http;
import 'dart:convert';

class JSONService {
  static const String baseUrl = 'http://localhost:3000/codes';

  Future<List<dynamic>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fehler beim Laden der Daten');
    }
  }

  Future<Map<String, dynamic>> fetchById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Fehler beim Laden des Eintrags');
    }
  }

  Future<void> insert(Map<String, dynamic> newEntry) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newEntry),
    );
    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Fehler beim Hinzufügen des Eintrags');
    }
  }

  Future<void> update(int id, Map<String, dynamic> updatedEntry) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedEntry),
    );
    if (response.statusCode != 200) {
      throw Exception('Fehler beim Aktualisieren des Eintrags');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Fehler beim Löschen des Eintrags');
    }
  }
}

void main() async {
  JSONService service = JSONService();

  // Beispiel für FetchAll
  List<dynamic> allEntries = await service.fetchAll();
  print(allEntries);

  // Beispiel für FetchById
  Map<String, dynamic> entry = await service.fetchById(1);
  print(entry);

  // Beispiel für Insert
  Map<String, dynamic> newEntry = {'id': 13, 'code': '54321'};
  await service.insert(newEntry);

  // Beispiel für Update
  Map<String, dynamic> updatedEntry = {'id': 1, 'code': 'Joo'};
  await service.update(1, updatedEntry);

  // Beispiel für Delete
  // await service.delete(2);
}

