import 'package:flutter/material.dart';
import 'package:lernplatform/globals/session.dart';

// ANSI Escape Codes für Farben
const String resetColor = "\x1B[0m";
const String black = "\x1B[30m";
const String red = "\x1B[31m";
const String green = "\x1B[32m";
const String yellow = "\x1B[33m";
const String blue = "\x1B[34m";
const String magenta = "\x1B[35m";
const String cyan = "\x1B[36m";
const String white = "\x1B[37m";

// Methoden für farbige Prints
void print_Black(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$black$message$resetColor");
}

void print_Red(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$red$message$resetColor");
}

void print_Green(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$green$message$resetColor");
}

void print_Yellow(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$yellow$message$resetColor");
}

void print_Blue(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$blue$message$resetColor");
}

void print_Magenta(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$magenta$message$resetColor");
}

void print_Cyan(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$cyan$message$resetColor");
}

void print_White(String message) {
  if (Session().IS_IN_DEBUG_MODE) print("$white$message$resetColor");
}


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text("Color Print Test")),
        body: Center(
          child: PrintTestWidget(),
        ),
      ),
    );
  }
}

class PrintTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Teste farbige Ausgaben in der Konsole
    print_Black("Das ist eine Nachricht in Schwarz.");
    print_Red("Das ist eine Nachricht in Rot.");
    print_Green("Das ist eine Nachricht in Grün.");
    print_Yellow("Das ist eine Nachricht in Gelb.");
    print_Blue("Das ist eine Nachricht in Blau.");
    print_Magenta("Das ist eine Nachricht in Magenta.");
    print_Cyan("Das ist eine Nachricht in Cyan.");
    print_White("Das ist eine Nachricht in Weiß.");

    return Text(
      "Check console for colored output.",
      style: TextStyle(color: Colors.white),
    );
  }
}

