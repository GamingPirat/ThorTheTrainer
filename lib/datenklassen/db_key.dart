class AlphaKey {
  String key;
  List<String> lernfelder;

  AlphaKey({required this.key, required this.lernfelder});

  factory AlphaKey.fromJson(Map<String, dynamic> json) {
    List<String> lernfelderList = [];
    if (json['lernfelder'] != null) {
      try {
        lernfelderList = List<String>.from(json['lernfelder'] as Iterable);
      } catch (e) {
        print("Fehler beim Konvertieren von lernfelder: ${e.toString()}");
      }
    }
    return AlphaKey(
      key: json['key'] ?? '',
      lernfelder: lernfelderList,
    );
  }
}