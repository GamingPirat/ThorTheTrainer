class Antwort {
  final String text;
  final String erklaerung;
  final bool isKorrekt;

  Antwort({
    required this.text,
    required this.erklaerung,
    required this.isKorrekt,
  });

  // fromJson factory method
  factory Antwort.fromJson(Map<String, dynamic> json) {
    return Antwort(
      text: json['text'] ?? "Antwort konnte nicht geladen werden",
      erklaerung: json['erklaerung'] ?? "",
      isKorrekt: json['isKorrekt'] ?? true,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'erklaerung': erklaerung,
      'isKorrekt': isKorrekt,
    };
  }

  // copyWith method
  Antwort copyWith({
    String? text,
    String? erklaerung,
    bool? isKorrekt,
  }) {
    return Antwort(
      text: text ?? this.text,
      erklaerung: erklaerung ?? this.erklaerung,
      isKorrekt: isKorrekt ?? this.isKorrekt,
    );
  }
  @override
  String toString() {
    return 'Antwort: $text, Korrekt: $isKorrekt';
  }
}