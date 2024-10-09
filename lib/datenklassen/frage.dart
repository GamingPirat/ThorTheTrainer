import 'antwort.dart';

class Frage {
  final int nummer;
  final int version;
  final int themaID;
  final int punkte;
  final String text;
  final List<Antwort> antworten;

  Frage({
    required this.nummer,
    required this.version,
    required this.themaID,
    required this.punkte,
    required this.text,
    required this.antworten,
  });

  String get id => "${themaID}_${nummer}_$version";

  factory Frage.fromJson(Map<String, dynamic> json) {
    var antwortenJson = json['antworten'] as List;
    List<Antwort> antwortenList = antwortenJson.map((i) => Antwort.fromJson(i)).toList();

    return Frage(
      nummer: json['nummer'],
      version: json['version'],
      themaID: json['themaID'],
      punkte: json['punkte'],
      text: json['text'],
      antworten: antwortenList,
    );
  }
}

class Antwort {
  final String text;
  final String erklaerung;
  final bool isKorrekt;

  Antwort({
    required this.text,
    required this.erklaerung,
    required this.isKorrekt,
  });

  factory Antwort.fromJson(Map<String, dynamic> json) {
    return Antwort(
      text: json['text'],
      erklaerung: json['erklaerung'],
      isKorrekt: json['isKorrekt'], // Direkter boolean-Wert
    );
  }
}




// List<Frage> mok_fragen_zuThema1 = [
//   // Fragen für Thema 1 (LF 1 T1)
//   Frage(
//     nummer: 1,
//     version: 1,
//     themaID: 1,
//     punkte: 5,
//     text: "Was ist ein Betriebssystem?",
//     antworten: [
//       Antwort(text: "Eine Software, die Hardware verwaltet", erklaerung: "Betriebssysteme sind für die Verwaltung der Hardware zuständig.", isKorrekt: true),
//       Antwort(text: "Ein Programm, das Dateien speichert", erklaerung: "Falsch, Betriebssysteme verwalten Dateien, aber das ist nicht ihre Hauptaufgabe.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 1,
//     version: 2,
//     themaID: 1,
//     punkte: 5,
//     text: "Wofür ist ein Betriebssystem zuständig?",
//     antworten: [
//       Antwort(text: "Für die Verwaltung von Hardware und Software", erklaerung: "Das ist korrekt.", isKorrekt: true),
//       Antwort(text: "Für die Sicherheit von Anwendungen", erklaerung: "Das ist nicht die Hauptaufgabe eines Betriebssystems.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 1,
//     themaID: 1,
//     punkte: 5,
//     text: "Welcher dieser Speicher ist flüchtig?",
//     antworten: [
//       Antwort(text: "RAM", erklaerung: "RAM ist flüchtiger Speicher.", isKorrekt: true),
//       Antwort(text: "Festplatte", erklaerung: "Festplatten sind nicht flüchtig.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 2,
//     themaID: 1,
//     punkte: 5,
//     text: "Welcher Speicher verliert seinen Inhalt nach einem Neustart?",
//     antworten: [
//       Antwort(text: "RAM", erklaerung: "Korrekt, RAM verliert seinen Inhalt.", isKorrekt: true),
//       Antwort(text: "SSD", erklaerung: "SSD speichert Daten auch nach dem Ausschalten.", isKorrekt: false),
//     ],
//   ),
// ];
//
//
//
// List<Frage> mok_fragen_zuThema2 = [
//   Frage(
//     nummer: 1,
//     version: 1,
//     themaID: 2,
//     punkte: 5,
//     text: "Was ist der Hauptzweck einer Firewall?",
//     antworten: [
//       Antwort(text: "Schutz vor unautorisierten Zugriffen", erklaerung: "Firewalls schützen Netzwerke.", isKorrekt: true),
//       Antwort(text: "Daten sichern", erklaerung: "Firewalls schützen, aber sie sichern keine Daten.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 1,
//     version: 2,
//     themaID: 2,
//     punkte: 5,
//     text: "Wofür wird eine Firewall verwendet?",
//     antworten: [
//       Antwort(text: "Zur Sicherung des Netzwerks vor unautorisierten Zugriffen", erklaerung: "Das ist korrekt.", isKorrekt: true),
//       Antwort(text: "Zum Backup von Daten", erklaerung: "Backups sind nicht die Aufgabe einer Firewall.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 1,
//     themaID: 2,
//     punkte: 5,
//     text: "Welches Protokoll wird für E-Mail-Versand verwendet?",
//     antworten: [
//       Antwort(text: "SMTP", erklaerung: "SMTP ist für den E-Mail-Versand zuständig.", isKorrekt: true),
//       Antwort(text: "FTP", erklaerung: "FTP wird für Dateitransfers verwendet, nicht für E-Mail.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 2,
//     themaID: 2,
//     punkte: 5,
//     text: "Welches Protokoll ermöglicht den Versand von E-Mails?",
//     antworten: [
//       Antwort(text: "SMTP", erklaerung: "Richtig, SMTP wird dafür verwendet.", isKorrekt: true),
//       Antwort(text: "HTTP", erklaerung: "HTTP ist für das Laden von Webseiten zuständig.", isKorrekt: false),
//     ],
//   ),
// ];
//
//
//
// List<Frage> mok_fragen_zuThema3 = [
//   Frage(
//     nummer: 1,
//     version: 1,
//     themaID: 3,
//     punkte: 5,
//     text: "Was ist die Aufgabe eines Betriebssystems?",
//     antworten: [
//       Antwort(text: "Verwaltung von Hardware und Software", erklaerung: "Das ist korrekt.", isKorrekt: true),
//       Antwort(text: "Erstellen von Programmen", erklaerung: "Betriebssysteme erstellen keine Programme.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 1,
//     version: 2,
//     themaID: 3,
//     punkte: 5,
//     text: "Wie unterstützt ein Betriebssystem die Hardware?",
//     antworten: [
//       Antwort(text: "Es verwaltet die Ressourcen", erklaerung: "Das ist richtig.", isKorrekt: true),
//       Antwort(text: "Es installiert Software", erklaerung: "Das ist nicht die Hauptaufgabe eines Betriebssystems.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 1,
//     themaID: 3,
//     punkte: 5,
//     text: "Welches Protokoll wird verwendet, um Webseiten anzuzeigen?",
//     antworten: [
//       Antwort(text: "HTTP", erklaerung: "HTTP ist das korrekte Protokoll.", isKorrekt: true),
//       Antwort(text: "SMTP", erklaerung: "SMTP wird für E-Mail verwendet, nicht für Webseiten.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 2,
//     themaID: 3,
//     punkte: 5,
//     text: "Welches Protokoll überträgt Webseiteninhalte?",
//     antworten: [
//       Antwort(text: "HTTP", erklaerung: "Richtig, HTTP wird dafür verwendet.", isKorrekt: true),
//       Antwort(text: "FTP", erklaerung: "FTP wird für Dateitransfers verwendet, nicht für Webseiten.", isKorrekt: false),
//     ],
//   ),
// ];
//
//
//
// List<Frage> mok_fragen_zuThema4 = [
//   Frage(
//     nummer: 1,
//     version: 1,
//     themaID: 4,
//     punkte: 5,
//     text: "Was ist die Aufgabe von HTTP?",
//     antworten: [
//       Antwort(text: "Webseiten-Inhalte übertragen", erklaerung: "Das ist korrekt.", isKorrekt: true),
//       Antwort(text: "Dateien auf Server hochladen", erklaerung: "Falsch, dafür wird FTP verwendet.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 1,
//     version: 2,
//     themaID: 4,
//     punkte: 5,
//     text: "Wofür wird das HTTP-Protokoll verwendet?",
//     antworten: [
//       Antwort(text: "Übertragung von Webseiten", erklaerung: "Richtig, HTTP überträgt Webseiten.", isKorrekt: true),
//       Antwort(text: "Übertragung von E-Mails", erklaerung: "E-Mails werden mit SMTP übertragen.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 1,
//     themaID: 4,
//     punkte: 5,
//     text: "Was ist ein Server?",
//     antworten: [
//       Antwort(text: "Ein Gerät, das Dienste bereitstellt", erklaerung: "Korrekt, das ist die Hauptaufgabe eines Servers.", isKorrekt: true),
//       Antwort(text: "Ein Computer für normale Benutzer", erklaerung: "Das ist nicht korrekt, Server sind für Dienste zuständig.", isKorrekt: false),
//     ],
//   ),
//   Frage(
//     nummer: 2,
//     version: 2,
//     themaID: 4,
//     punkte: 5,
//     text: "Welche Funktion hat ein Server?",
//     antworten: [
//       Antwort(text: "Bereitstellung von Diensten", erklaerung: "Das ist korrekt.", isKorrekt: true),
//       Antwort(text: "Speichern von Dateien", erklaerung: "Das ist nicht die Hauptaufgabe eines Servers.", isKorrekt: false),
//     ],
//   ),
// ];


