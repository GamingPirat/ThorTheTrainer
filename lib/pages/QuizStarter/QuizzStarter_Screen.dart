import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/personal_content_controllers.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_subThemaWidget.dart';
import 'package:lernplatform/session.dart';

class QuizStarter_Screen extends StatelessWidget {
  const QuizStarter_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    Session().pageHeader = Text("Welche Fragen sollen im Quiz sein?");
    return Scaffold(
      appBar: AppBar(
        title: Session().pageHeader,
      ),
      body: SingleChildScrollView(  // ScrollView hinzugefügt, um Überlauf zu vermeiden
        child: Column(
          children: [
            Container(
              height: 100,  // Statische Höhe für den Header oder andere Komponenten
              child: Center(child: Text("Header oder statische Komponente")),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 100,  // Stellt sicher, dass das GridView korrekt begrenzt ist
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,  // Anzahl der Spalten im Grid
                  crossAxisSpacing: 10,  // Abstand zwischen den Spalten
                  mainAxisSpacing: 10,  // Abstand zwischen den Reihen
                ),
                itemCount: Session().user.usersLernfelder
                    .expand((lernfeld) => lernfeld.meineThemen)
                    .expand((thema) => thema.meineSubThemen)
                    .length,
                itemBuilder: (context, index) {
                  List<SubThema_Personal> subthemen = Session().user.usersLernfelder
                      .expand((lernfeld) => lernfeld.meineThemen)
                      .expand((thema) => thema.meineSubThemen)
                      .toList();

                  SubThema_Personal subthema = subthemen[index];

                  return QuizStarterSubThemaWidget(viewModel: subthema);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
