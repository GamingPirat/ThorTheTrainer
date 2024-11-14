class AlphaKey {
  String key;
  List<String> lernfelder;

  AlphaKey({required this.key, required this.lernfelder});

  factory AlphaKey.fromJson(Map<String, dynamic> json) {
    List<String> lernfelderList = [];
    if (json['lernfelder'] != null) {
      try {
        lernfelderList = (json['lernfelder'] as Map<String, dynamic>).keys.toList();
      } catch (e) {
        print("Fehler beim Konvertieren von lernfelder (Schlüssel): ${e.toString()}");
      }
    }
    return AlphaKey(
      key: json['key'] ?? '',
      lernfelder: lernfelderList,
    );
  }

  @override
  String toString() {
    return 'AlphaKey{key: $key, lernfelder: $lernfelder}';
  }


}