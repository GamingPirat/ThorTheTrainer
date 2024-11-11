import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_content_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/firabase/firebase_options.dart';
import 'package:lernplatform/main.dart';
import 'package:lernplatform/pages/progress_bar_widget.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_selecter_widget.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:provider/provider.dart';

class ExpandableWidget extends StatefulWidget {
  final UsersContentModel usersViewModel;
  final List<Widget> children;

  ExpandableWidget({required this.usersViewModel, required this.children});

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isExpanded = false; // Kontrolliert, ob das Widget ausgeklappt ist

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.usersViewModel,
      child: Consumer<UsersContentModel>(
        builder: (context, vm, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: vm is UsersThema
                    ? EdgeInsets.fromLTRB(80, 0, 80, 0)
                    : EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: vm.glowColor,
                      spreadRadius: 5,
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(2), // Eckenabrundung
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2), // Eckenabrundung für Hover-Effekt
                  child: Container(
                    padding: EdgeInsets.all(4),
                    color: (Theme.of(context).brightness == Brightness.dark
                        ? Color(0xFF101010)
                        : Color(0xFFF0F0F0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => vm.isSelected = !vm.isSelected,
                            child: Center(child: ProgressWidget(viewModel: vm)),
                          ),
                        ),
                        IconButton(
                          icon: Icon(isExpanded
                              ? Icons.expand_less
                              : Icons.expand_more), // Pfeil-Icon abhängig vom Status
                          onPressed: toggleExpanded, // Klick-Event
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isExpanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.children
                      .map((child) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: child,
                  ))
                      .toList(),
                ),
            ],
          );
        },
      ),
    );
  }
}


class QuizStarter_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Session().pageHeader = const Text("Welche Fragen sollen im Quiz sein?");
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        // appBar: Session().appBar,
        // drawer: Session().drawer,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: Session().user.lernfelder.length,
              itemBuilder: (context, index) {
                UsersLernfeld lernfeld = Session().user.lernfelder[index];

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
        ),
      ),
    );
  }
}

// void main() {
//   runApp(TestApp());
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = Settings( // macht alles kostengünstiger
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );
  runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(), // Für das Theme
        child: QuizStarter_Screen(),
      )
  );
}
