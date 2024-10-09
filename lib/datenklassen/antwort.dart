class Antwort {
  final String frage_id;
  final String text;
  final String erklaerung;
  final bool isKorrekt;

  Antwort({
    required this.frage_id,
    required this.text,
    required this.erklaerung,
    required this.isKorrekt,
  });

  factory Antwort.fromJson(Map<String, dynamic> json) {
    return Antwort(
      frage_id: json['frage_id'],
      text: json['text'],
      erklaerung: json['erklaerung'],
      isKorrekt: json['isKorrekt'], // Direkter boolean-Wert
    );
  }
}