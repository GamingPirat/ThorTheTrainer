import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/abstract_users_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_subthema_viewmodel.dart';
import 'package:lernplatform/d_users_view_models/users_thema_viewmodel.dart';
import 'package:lernplatform/firebase_options.dart';
import 'package:lernplatform/main.dart';
import 'package:lernplatform/pages/QuizStarter/quizstarter_selecter_widget.dart';
import 'package:lernplatform/session.dart';
import 'package:provider/provider.dart';

class ExpandableWidget extends StatelessWidget {
  final UsersViewModel usersViewModel;
  final List<Widget> children;

  const ExpandableWidget({required this.usersViewModel, required this.children});

  void _setExpanded(bool value) {
    if (usersViewModel.ishovered) {
      Future.delayed(Duration(milliseconds: 1000), () {
        usersViewModel.ishovered = value;
      });
    } else {
      usersViewModel.ishovered = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: usersViewModel,
      child: Consumer<UsersViewModel>(
        builder: (context, vm, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MouseRegion(
                onEnter: (_) => _setExpanded(true),
                onExit: (_) => _setExpanded(false),
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: vm.isSelected ? Colors.blue : Colors.transparent,
                        spreadRadius: 5,
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2), // Eckenabrundung
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),  // Gleiche Eckenabrundung für Hover-Effekt
                    child: Container(
                      padding: EdgeInsets.all(4),
                      color: vm.isSelected
                          ? (Theme.of(context).brightness == Brightness.dark ? Color(0xFF101010) : Color(0xFFF0F0F0))
                          : Colors.black.withOpacity(0.5),

                      child: InkWell(
                        onTap: () => vm.isSelected = !vm.isSelected,
                        hoverColor: Colors.blue.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            vm.name,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (vm.ishovered)
                MouseRegion(
                  onEnter: (_) => _setExpanded(true),
                  onExit: (_) => _setExpanded(false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children
                        .map((child) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 16.0),
                      child: child,
                    ))
                        .toList(),
                  ),
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
              itemCount: Session().user.usersLernfelder.length,
              itemBuilder: (context, index) {
                UsersLernfeld lernfeld = Session().user.usersLernfelder[index];

                return ExpandableWidget(
                  usersViewModel: lernfeld,
                  children: lernfeld.usersThemen.map((UsersThema thema) {
                    return ExpandableWidget(
                      usersViewModel: thema,
                      children: thema.meineSubThemen.map((UsersSubthema subthema) {
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
