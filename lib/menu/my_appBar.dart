import 'package:flutter/material.dart';
import 'package:lernplatform/menu/my_left_drawer.dart';
import 'package:lernplatform/user_session.dart';
import '../datenklassen/folder_types.dart';
import 'folder_widget.dart';


class MyAppBar extends AppBar {
  final void Function(ThemeMode) setThemeMode;

  MyAppBar({Key? key, required this.setThemeMode})
      : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
        ? Color.fromRGBO(22,22,22,1) : Color.fromRGBO(255,255,240,1),
      title: Center(child: UserSession().pageHeader),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Theme.of(context).brightness == Brightness.dark
              ? Icons.dark_mode
              : Icons.light_mode),
          onPressed: () {
            // setState(() {
            widget.setThemeMode(Theme.of(context).brightness == Brightness.dark
                ? ThemeMode.light
                : ThemeMode.dark);
            // }
            // );
          },
        ),
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ich arbeite noch an diesem Feature'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildFolderList() {
    return Expanded(
      child: ListView(
        children: mok_TeilnehmerFolder.lernFelder.map((lernfeld) {
          return LernfeldWidget(lernfeld: lernfeld,);
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MyTestApp());
}

// Nur zu Testzwecken eingebaut
void setThemeMode(ThemeMode value) {
  // Dummy Funktion für Testzwecke
}

// Nur zu Testzwecken eingebaut
late UserSession session;

class MyTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Nur zu Testzwecken eingebaut
    session = UserSession();
    session.appBar = MyAppBar(setThemeMode: (themeMode) {
      setThemeMode(themeMode);
    });
    session.drawer = MyLeftDrawer();

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: session.appBar,
        drawer: session.drawer,
        body: Center(
          child: Text('TestApp Content'),
        ),
      ),
    );
  }
}
