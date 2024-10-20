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
  print("$black$message$resetColor");
}

void print_Red(String message) {
  print("$red$message$resetColor");
}

void print_Green(String message) {
  print("$green$message$resetColor");
}

void print_Yellow(String message) {
  print("$yellow$message$resetColor");
}

void print_Blue(String message) {
  print("$blue$message$resetColor");
}

void print_Magenta(String message) {
  print("$magenta$message$resetColor");
}

void print_Cyan(String message) {
  print("$cyan$message$resetColor");
}

void print_White(String message) {
  print("$white$message$resetColor");
}

// Teste die Farben
void main() {
  print_Black("Das ist eine Nachricht in Schwarz.");
  print_Red("Das ist eine Nachricht in Rot.");
  print_Green("Das ist eine Nachricht in Grün.");
  print_Yellow("Das ist eine Nachricht in Gelb.");
  print_Blue("Das ist eine Nachricht in Blau.");
  print_Magenta("Das ist eine Nachricht in Magenta.");
  print_Cyan("Das ist eine Nachricht in Cyan.");
  print_White("Das ist eine Nachricht in Weiß.");
}
