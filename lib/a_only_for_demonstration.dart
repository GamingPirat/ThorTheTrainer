import 'package:flutter/material.dart';
import 'package:lernplatform/session.dart';
import 'menu/my_appBar.dart';
import 'menu/my_left_drawer.dart';


class DemonstrationPage extends StatelessWidget {
  Widget testWidget;


  DemonstrationPage({super.key, required this.testWidget}){Session().pageHeader=Text("DemonstrationsPage");}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Session().appBar,
        drawer: Session().drawer,
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
      Session().themeMode = value;
    });
  }

  late Session session;

  @override
  void initState() {
    session = Session();
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
        themeMode: Session().themeMode, // Dies ist eine vereinfachte Annahme.
        home: widget.home
    );
  }
}
