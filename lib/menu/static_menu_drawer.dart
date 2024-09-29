import 'package:flutter/material.dart';
import 'package:lernplatform/user_session.dart';
import '../Quiz/Quiz_Screen.dart';
import '../datenklassen/folder_types.dart';
import 'folder_widget.dart';

class StaticMenuDrawer extends StatefulWidget {

  @override
  State<StaticMenuDrawer> createState() => _StaticMenuDrawerState();
}

class _StaticMenuDrawerState extends State<StaticMenuDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          children: [
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Quiz_Screen(),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.emoji_events),
                      SizedBox(width: 32,),
                      Text("Quiz"),
                    ],
                  ),
                ),
              ),
            ),
            buildFolderList(),
          ],
        ),
      ),
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