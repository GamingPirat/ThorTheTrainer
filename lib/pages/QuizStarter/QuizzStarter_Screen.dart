import 'package:flutter/material.dart';
import 'package:lernplatform/globals/my_background.dart';
import 'package:lernplatform/globals/user_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_kompetenzbereich_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_inhalt_viewmodel.dart';
import 'package:lernplatform/pages/Quiz/Quizscreen.dart';
import 'package:lernplatform/pages/QuizStarter/expandable.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_selecter_widget.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:provider/provider.dart';

class QuizStarter_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Session().pageHeader = const Text("Welche Fragen sollen im Quiz sein?");
    return Scaffold(
        appBar: Session().appBar,
        drawer: Session().drawer,
        body: Stack(
          children: [
            Session().background,
            ChangeNotifierProvider.value(
              value: Session().user,
              child: Consumer<UserModel>(
                  builder: (context, vm, child) {
                    return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [

                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              child: Text("Quiz starten"),
                              onPressed: () {
                                vm.childIsSelected
                                    ? Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => QuizScreen()),
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
                          ),
                          const SizedBox(height: 32,),
                          Expanded(
                            flex: 12,
                            child: ListView.builder(
                              itemCount: vm.lernfelder.length,
                              itemBuilder: (context, index) {
                                UsersLernfeld lernfeld = vm.lernfelder[index];

                                return ExpandableWidget(
                                  usersViewModel: lernfeld,
                                  children: lernfeld.usersKompetenzbereiche.map((UsersKompetenzbereich thema) {
                                    return ExpandableWidget(
                                      usersViewModel: thema,
                                      children: thema.usersInhalte.map((UsersInhalt subthema) {
                                        return QuizStarterSelecterWidget(viewModel: subthema);
                                      }).toList(),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      );
  }
}