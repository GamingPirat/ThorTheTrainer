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
      leading:IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
        // Session().drawerIsOpen = !Session().drawerIsOpen;
        //   Session().drawerIsOpen
        //   ? openCustomDrawer(context)
        //   : Navigator.pop(context);

        openCustomDrawer(context);
        }
      ),
      actions: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.of(context).pop();
                });
                return const AlertDialog(
                  title: Column(
                    children: [
                      Icon(Icons.mood_bad),
                      SizedBox(height: 32,),
                      Text("Sorry aber im Moment kannst du mit den "
                          "erreichten Sternen noch nichts anfangen. Ich arbeite "
                          "noch daran."),
                      SizedBox(height: 32,),
                      Icon(Icons.handshake ),
                      SizedBox(height: 32,),
                      Icon(Icons.mood ),
                    ],
                  ),
                );
              },
            );
          },
          hoverColor: Colors.blue.withOpacity(0.2),
          child: Row(
            children: [
              Icon(Icons.star),
              Session().punkteAnzeige,
            ],
          ),
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
  void openCustomDrawer(BuildContext context) {
    final theme = Theme.of(context); // Hole das aktuelle Theme (inkl. Dark Mode)

    showGeneralDialog(
      context: context,
      barrierLabel: "Drawer",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5), // Optional: Hintergrund dimmen
      transitionDuration: Duration(milliseconds: 300), // Animationsdauer
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent, // Hintergrund transparent lassen, falls gewünscht
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35, // Belege 35% der Bildschirmbreite
              height: double.infinity, // Volle Höhe
              color: theme.cardColor, // Nutze das cardColor des aktuellen Themes
              child: Session().drawer,
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1, 0), // Startposition außerhalb des Bildschirms (links)
            end: Offset(0, 0), // Endposition auf dem Bildschirm
          ).animate(anim1),
          child: child,
        );
      },
    );
  }



}
