import 'package:flutter/material.dart';
import 'package:lernplatform/user_session.dart';
import 'menu/my_appBar.dart';
import 'menu/my_left_drawer.dart';


class DemonstrationPage extends StatelessWidget {
  Widget testWidget;


  DemonstrationPage({super.key, required this.testWidget}){UserSession().pageHeader=Text("DemonstrationsPage");}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UserSession().appBar,
        drawer: UserSession().drawer,
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(child: testWidget))
    );
  }
}



class DemonstrationApp extends StatefulWidget {
  Widget home;

  DemonstrationApp({required this.home});


  @override
  _DemonstrationAppState createState() => _DemonstrationAppState();
}

class _DemonstrationAppState extends State<DemonstrationApp> {


  setThemeMode(ThemeMode value){
    setState(() {
      UserSession().themeMode = value;
    });
  }

  late UserSession session;

  @override
  void initState() {
    session = UserSession();
    session.appBar = MyAppBar(setThemeMode: (themeMode) {
      setThemeMode(themeMode);
    },);
    session.drawer = MyLeftDrawer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        // Zugriff auf den themeMode über den State von MyAppBar:
        themeMode: UserSession().themeMode, // Dies ist eine vereinfachte Annahme.
        home: widget.home
    );
  }
}
