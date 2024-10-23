import 'package:flutter/material.dart';
import 'package:lernplatform/menu/my_left_drawer.dart';
import 'package:lernplatform/menu/punkte_widget.dart';
import 'package:lernplatform/session.dart';
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
      title: Center(child: Session().pageHeader),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        Row(
          children: [
            Icon(Icons.star),
            Session().punkteAnzeige,
          ],
        ),
        SizedBox(width:12),
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
          builder: (context) => GestureDetector(
            onLongPress: () async {
              await Future.delayed(Duration(seconds: 7));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Geheimer Admin-Zugang!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: IconButton(
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
        )

      ],
    );
  }
}
