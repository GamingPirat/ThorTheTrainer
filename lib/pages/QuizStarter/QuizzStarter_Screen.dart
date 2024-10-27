import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/user_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/pages/Quiz/new_Quizscreen.dart';
import 'package:lernplatform/pages/QuizStarter/expandable.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_selecter_widget.dart';
import 'package:lernplatform/print_colors.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';
//
// class QuizStarter_Screen extends StatelessWidget {
//   const QuizStarter_Screen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Session().pageHeader = const Text("Welche Fragen sollen im Quiz sein?");
//
//     return Scaffold(
//       appBar: Session().appBar,
//       drawer: Session().drawer,
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: ListView.builder(
//           itemCount: Session().user.usersLernfelder.length,
//           itemBuilder: (context, index) {
//             UsersLernfeld lernfeld = Session().user.usersLernfelder[index];
//
//             return Column(
//               children: [
//                 QuizStarterSelecterWidget(viewModel: lernfeld),
//                 GridView.builder(
//                   shrinkWrap: true,  // GridView nimmt nur so viel Platz ein, wie es benötigt
//                   physics: const NeverScrollableScrollPhysics(),  // Kein eigenes Scrollen
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 4,
//                     mainAxisSpacing: 4,
//                     childAspectRatio: 2.4,
//                   ),
//                   itemCount: lernfeld.meineThemen.length,
//                   itemBuilder: (context, index) {
//                     UsersThema thema = lernfeld.meineThemen[index];
//
//                     return Column(
//                       children: [
//                         QuizStarterSelecterWidget(viewModel: thema),
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,        // Anzahl der Spalten
//                             crossAxisSpacing: 4,     // Abstand zwischen den Spalten
//                             mainAxisSpacing: 4,      // Abstand zwischen den Reihen
//                             childAspectRatio: 2,    // Seitenverhältnis der Kinder (Breite zu Höhe)
//                           ),
//                           itemCount: thema.meineSubThemen.length,
//                           itemBuilder: (context, index) {
//                             UsersSubthema subthema = thema.meineSubThemen[index];
//
//                             return QuizStarterSelecterWidget(viewModel: subthema);
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class QuizStarter_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Session().pageHeader = const Text("Welche Fragen sollen im Quiz sein?");
    return Scaffold(
        appBar: Session().appBar,
        drawer: Session().drawer,
        body: ChangeNotifierProvider.value(
          value: Session().user,
          child: Consumer<UserModel>(
              builder: (context, vm, child) {
                return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 12,
                        child: ListView.builder(
                          itemCount: vm.usersLernfelder.length,
                          itemBuilder: (context, index) {
                            UsersLernfeld lernfeld = vm.usersLernfelder[index];

                            return ExpandableWidget(
                              usersViewModel: lernfeld,
                              children: lernfeld.usersThemen.map((UsersThema thema) {
                                return ExpandableWidget(
                                  usersViewModel: thema,
                                  children: thema.meineSubThemen.map((UsersSubThema subthema) {
                                    return QuizStarterSelecterWidget(viewModel: subthema);
                                  }).toList(),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          child: Text("Quiz starten"),
                          onPressed: () {
                            vm.childIsSelected
                            ? Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => NewQuizScreen()),
                            )

                            :  showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context).pop();
                                  });
                                  return const AlertDialog(
                                    title: Text("Wähle zuerst etwas aus"),
                                  );
                                },
                              );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      );
  }
}