// import 'package:lernplatform/datenklassen/view_builder.dart';
//
// Lernfeld lernfeld42 = Lernfeld(
//   id: 42,
//   name: "Lernfeld42",
//   themen: [
//     Thema(
//       id: 1,
//       name: "Osi - Schichten - Model",
//       contentPagePath: "path/to/osi_schichten_model",
//       fragen: [
//         // Frage 1: SingleChoice
//         Frage(
//           nummer: 1,
//           version: 1,
//           themaID: 1,
//           punkte: 2,
//           text: "Welche Schicht des OSI-Modells ist für die Datenübertragung zwischen Endgeräten verantwortlich?",
//           antworten: [
//             Antwort(
//               text: "Transportschicht",
//               erklaerung: "Richtig, die Transportschicht ist verantwortlich für die Datenübertragung zwischen Endgeräten.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Sicherungsschicht",
//               erklaerung: "Falsch, die Sicherungsschicht sorgt für fehlerfreie Übertragung auf der Bitübertragungsschicht.",
//               isKorrekt: false,
//             ),
//             Antwort(
//               text: "Netzwerkschicht",
//               erklaerung: "Falsch, die Netzwerkschicht verwaltet die Wege der Datenpakete.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 2: MultipleChoice
//         Frage(
//           nummer: 2,
//           version: 1,
//           themaID: 1,
//           punkte: 3,
//           text: "Welche Schichten des OSI-Modells sind transportbezogen?",
//           antworten: [
//             Antwort(
//               text: "Transportschicht",
//               erklaerung: "Richtig, sie bezieht sich auf den Transport der Daten.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Netzwerkschicht",
//               erklaerung: "Richtig, diese Schicht verwaltet Datenwege.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Anwendungsschicht",
//               erklaerung: "Falsch, die Anwendungsschicht ist für die Kommunikation zwischen Programmen zuständig.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 3: Richtig oder falsch
//         Frage(
//           nummer: 3,
//           version: 1,
//           themaID: 1,
//           punkte: 1,
//           text: "Die Sitzungsschicht steuert den Dialog zwischen zwei Systemen.",
//           antworten: [
//             Antwort(
//               text: "richtig",
//               erklaerung: "Richtig, die Sitzungsschicht steuert und koordiniert den Dialog.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "falsch",
//               erklaerung: "Falsch, dies ist eine Funktion der Sitzungsschicht.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 4: SingleChoice
//         Frage(
//           nummer: 4,
//           version: 1,
//           themaID: 1,
//           punkte: 2,
//           text: "Auf welcher Schicht arbeitet ein Router?",
//           antworten: [
//             Antwort(
//               text: "Netzwerkschicht",
//               erklaerung: "Richtig, der Router arbeitet auf der Netzwerkschicht.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Sicherungsschicht",
//               erklaerung: "Falsch, die Sicherungsschicht ist für die fehlerfreie Übertragung auf der Bitübertragungsebene zuständig.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 5: Richtig oder falsch
//         Frage(
//           nummer: 5,
//           version: 1,
//           themaID: 1,
//           punkte: 1,
//           text: "Die Anwendungsschicht ist verantwortlich für die Darstellung von Daten.",
//           antworten: [
//             Antwort(
//               text: "falsch",
//               erklaerung: "Falsch, die Darstellungsschicht ist dafür verantwortlich.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "richtig",
//               erklaerung: "Richtig, diese Schicht ist nicht verantwortlich für die Darstellung.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//       ],
//     ),
//     Thema(
//       id: 2,
//       name: "Netzwerk - Komponenten",
//       contentPagePath: "path/to/netzwerk_komponenten",
//       fragen: [
//         // Frage 1: SingleChoice
//         Frage(
//           nummer: 1,
//           version: 1,
//           themaID: 2,
//           punkte: 2,
//           text: "Welche Komponente arbeitet auf der Sicherungsschicht des OSI-Modells?",
//           antworten: [
//             Antwort(
//               text: "Switch",
//               erklaerung: "Richtig, ein Switch arbeitet auf der Sicherungsschicht.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Router",
//               erklaerung: "Falsch, ein Router arbeitet auf der Netzwerkschicht.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 2: MultipleChoice
//         Frage(
//           nummer: 2,
//           version: 1,
//           themaID: 2,
//           punkte: 3,
//           text: "Welche der folgenden Geräte sind Netzwerkkomponenten?",
//           antworten: [
//             Antwort(
//               text: "Router",
//               erklaerung: "Richtig, Router sind essenzielle Netzwerkkomponenten.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Switch",
//               erklaerung: "Richtig, Switches sind wichtige Geräte in Netzwerken.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Monitor",
//               erklaerung: "Falsch, ein Monitor ist keine Netzwerkkomponente.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 3: Richtig oder falsch
//         Frage(
//           nummer: 3,
//           version: 1,
//           themaID: 2,
//           punkte: 1,
//           text: "Ein Switch verbindet Netzwerke und arbeitet auf Schicht 3.",
//           antworten: [
//             Antwort(
//               text: "falsch",
//               erklaerung: "Richtig, ein Switch arbeitet auf Schicht 2.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "richtig",
//               erklaerung: "Falsch, ein Switch arbeitet nicht auf Schicht 3.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 4: SingleChoice
//         Frage(
//           nummer: 4,
//           version: 1,
//           themaID: 2,
//           punkte: 2,
//           text: "Welche Komponente leitet Datenpakete basierend auf IP-Adressen weiter?",
//           antworten: [
//             Antwort(
//               text: "Router",
//               erklaerung: "Richtig, Router leiten Datenpakete anhand von IP-Adressen weiter.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Switch",
//               erklaerung: "Falsch, ein Switch verwendet MAC-Adressen.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 5: Richtig oder falsch
//         Frage(
//           nummer: 5,
//           version: 1,
//           themaID: 2,
//           punkte: 1,
//           text: "Ein Hub arbeitet intelligenter als ein Switch.",
//           antworten: [
//             Antwort(
//               text: "falsch",
//               erklaerung: "Richtig, ein Hub leitet Datenpakete einfach an alle Ports weiter, während ein Switch selektiver ist.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "richtig",
//               erklaerung: "Falsch, ein Switch arbeitet intelligenter als ein Hub.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );
//
// Lernfeld lernfeld43 = Lernfeld(
//   id: 43,
//   name: "Lernfeld43",
//   themen: [
//     Thema(
//       id: 1,
//       name: "Programmierung",
//       contentPagePath: "path/to/programmierung",
//       fragen: [
//         // Frage 1: SingleChoice
//         Frage(
//           nummer: 1,
//           version: 1,
//           themaID: 1,
//           punkte: 2,
//           text: "Welche Programmiersprache ist objektorientiert?",
//           antworten: [
//             Antwort(
//               text: "Java",
//               erklaerung: "Richtig, Java ist eine objektorientierte Programmiersprache.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "C",
//               erklaerung: "Falsch, C ist eine prozedurale Programmiersprache.",
//               isKorrekt: false,
//             ),
//             Antwort(
//               text: "Assembler",
//               erklaerung: "Falsch, Assembler ist eine maschinennahe Sprache.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 2: MultipleChoice
//         Frage(
//           nummer: 2,
//           version: 1,
//           themaID: 1,
//           punkte: 3,
//           text: "Welche der folgenden Konzepte gehören zur objektorientierten Programmierung?",
//           antworten: [
//             Antwort(
//               text: "Vererbung",
//               erklaerung: "Richtig, Vererbung ist ein zentrales Konzept der OOP.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Polymorphismus",
//               erklaerung: "Richtig, Polymorphismus ist ein weiteres Schlüsselkonzept der OOP.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Schleifen",
//               erklaerung: "Falsch, Schleifen sind grundlegende Kontrollstrukturen und gehören nicht speziell zur OOP.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 3: Richtig oder falsch
//         Frage(
//           nummer: 3,
//           version: 1,
//           themaID: 1,
//           punkte: 1,
//           text: "Eine Funktion in Python kann mehrere Rückgabewerte haben.",
//           antworten: [
//             Antwort(
//               text: "richtig",
//               erklaerung: "Richtig, eine Funktion in Python kann ein Tupel zurückgeben, das mehrere Werte enthält.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "falsch",
//               erklaerung: "Falsch, in Python können Funktionen mehrere Rückgabewerte haben.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 4: SingleChoice
//         Frage(
//           nummer: 4,
//           version: 1,
//           themaID: 1,
//           punkte: 2,
//           text: "Welcher Datentyp in Python ist unveränderlich?",
//           antworten: [
//             Antwort(
//               text: "Tuple",
//               erklaerung: "Richtig, ein Tuple ist unveränderlich.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "List",
//               erklaerung: "Falsch, Listen in Python sind veränderlich.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 5: Richtig oder falsch
//         Frage(
//           nummer: 5,
//           version: 1,
//           themaID: 1,
//           punkte: 1,
//           text: "In Java muss jede Klasse von einer anderen Klasse erben.",
//           antworten: [
//             Antwort(
//               text: "falsch",
//               erklaerung: "Richtig, eine Klasse in Java kann von keiner oder einer anderen Klasse erben.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "richtig",
//               erklaerung: "Falsch, Java unterstützt Klassen, die keine Vererbung nutzen.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//       ],
//     ),
//     Thema(
//       id: 2,
//       name: "UML",
//       contentPagePath: "path/to/uml",
//       fragen: [
//         // Frage 1: SingleChoice
//         Frage(
//           nummer: 1,
//           version: 1,
//           themaID: 2,
//           punkte: 2,
//           text: "Welche UML-Diagrammart zeigt die statische Struktur eines Systems?",
//           antworten: [
//             Antwort(
//               text: "Klassendiagramm",
//               erklaerung: "Richtig, ein Klassendiagramm zeigt die statische Struktur eines Systems.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Aktivitätsdiagramm",
//               erklaerung: "Falsch, ein Aktivitätsdiagramm zeigt den Ablauf von Aktivitäten.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 2: MultipleChoice
//         Frage(
//           nummer: 2,
//           version: 1,
//           themaID: 2,
//           punkte: 3,
//           text: "Welche der folgenden Diagrammarten gehören zu UML?",
//           antworten: [
//             Antwort(
//               text: "Klassendiagramm",
//               erklaerung: "Richtig, ein Klassendiagramm ist eine der zentralen Diagrammarten in UML.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Sequenzdiagramm",
//               erklaerung: "Richtig, ein Sequenzdiagramm gehört ebenfalls zur UML.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Flowchart",
//               erklaerung: "Falsch, ein Flowchart ist keine UML-Diagrammform.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 3: Richtig oder falsch
//         Frage(
//           nummer: 3,
//           version: 1,
//           themaID: 2,
//           punkte: 1,
//           text: "Ein Zustandsdiagramm beschreibt die Zustände und Übergänge eines Objekts.",
//           antworten: [
//             Antwort(
//               text: "richtig",
//               erklaerung: "Richtig, ein Zustandsdiagramm beschreibt die Zustände eines Objekts und die Übergänge zwischen diesen Zuständen.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "falsch",
//               erklaerung: "Falsch, ein Zustandsdiagramm zeigt genau diese Zusammenhänge.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 4: SingleChoice
//         Frage(
//           nummer: 4,
//           version: 1,
//           themaID: 2,
//           punkte: 2,
//           text: "Welches UML-Diagramm beschreibt die Interaktion zwischen Objekten über die Zeit?",
//           antworten: [
//             Antwort(
//               text: "Sequenzdiagramm",
//               erklaerung: "Richtig, ein Sequenzdiagramm beschreibt die zeitliche Interaktion von Objekten.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "Komponentendiagramm",
//               erklaerung: "Falsch, das Komponentendiagramm zeigt die physischen Komponenten eines Systems.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//         // Frage 5: Richtig oder falsch
//         Frage(
//           nummer: 5,
//           version: 1,
//           themaID: 2,
//           punkte: 1,
//           text: "Ein Use-Case-Diagramm zeigt die Beziehung zwischen Akteuren und Anwendungsfällen.",
//           antworten: [
//             Antwort(
//               text: "richtig",
//               erklaerung: "Richtig, ein Use-Case-Diagramm zeigt die Interaktionen zwischen Akteuren und Anwendungsfällen.",
//               isKorrekt: true,
//             ),
//             Antwort(
//               text: "falsch",
//               erklaerung: "Falsch, ein Use-Case-Diagramm zeigt genau diese Interaktionen.",
//               isKorrekt: false,
//             ),
//           ],
//         ),
//       ],
//     ),
//   ],
// );
//
