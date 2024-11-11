import 'package:flutter/material.dart';
import 'package:lernplatform/d_users_view_models/users_lernfeld_viewmodel.dart';
import 'package:lernplatform/globals/session.dart';
import 'package:lernplatform/pages/Startseiten/the_door_page.dart';


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
      backgroundColor: (Theme.of(context).brightness == Brightness.dark
          ? Color(0xFF101010)
          : Color(0xFFF0F0F0)),
      title: Center(child: Session().pageHeader),
      leading:IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
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
              Session().sterneAnzeige,
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
        SizedBox(width:12),
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Row(
                    children: const [
                      Icon(Icons.info, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Fortschritt zurücksetzen'),
                    ],
                  ),
                  content: const Text(
                    'Willst du wirklich den gesamten Fortschritt zurücksetzen?\n'
                        'Sämtliche Fortschritsbalken werden zurückgesetzt. Gesammelte Sterne bleiben erhalten',
                  ),
                  actions: [
                    // Abbrechen-Button
                    TextButton(
                      onPressed: ()=> Navigator.of(context).pop(), // Der Button macht NICHTS
                      child: const Text('Abbrechen'),
                    ),
                    // Fortschritt löschen-Button
                    TextButton(
                      onPressed: ()=> {
                        Session().user.fortschritt_loeschen(),
                        for(UsersLernfeld lernfeld in Session().user.lernfelder)
                          lernfeld.updateProgress(updateParent: false),
                        Navigator.of(context).pop()
                      },
                      child: const Text('Fortschritt löschen'),
                    ),
                  ],
                );
              },
            );
          },
        ),
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
