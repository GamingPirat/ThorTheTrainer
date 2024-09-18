import 'package:flutter/material.dart';
import 'package:lernplatform/my_appBar.dart';
import 'package:lernplatform/quiz_starter_page.dart';
import 'package:lernplatform/user_session.dart';

import 'datenklassen/folder_types.dart';
import 'folderlist_widget.dart';

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
                    UserSession().pageHeader = "Das ist n Quizzstarter";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizStarterPage(),
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


// class StaticMenu extends Drawer {
//   // ThemeMode _themeMode = ThemeMode.dark;
//   // ThemeMode get themeMode => _themeMode;
//   // set themeMode(ThemeMode value){
//   //   _themeMode = value;
//   // }
//
//   MyAppBar appBar = MyAppBar(themeMode: themeMode);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.25,
//         child: Column(
//           children: [
//             SizedBox(height: 32,),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Builder(
//                 builder: (context) => ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => QuizStarterPage(myDrawer: this,),
//                       ),
//                     );
//                   },
//                   child: const Row(
//                     children: [
//                       Icon(Icons.emoji_events),
//                       SizedBox(width: 32,),
//                       Text("Quiz"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             buildFolderList(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildFolderList() {
//     return Expanded(
//       child: ListView(
//         children: mok_TeilnehmerFolder.lernFelder.map((lernfeld) {
//           return LernfeldWidget(lernfeld: lernfeld,);
//         }).toList(),
//       ),
//     );
//   }
// }
