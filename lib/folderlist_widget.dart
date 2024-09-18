import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/view_builder.dart';
import 'package:lernplatform/datenklassen/folder_types.dart';

class FolderWidget extends StatelessWidget {
  final Folder folder;

  FolderWidget({required this.folder});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          Icon(Icons.folder, color: Colors.red),
          SizedBox(width: 8),
          Text(folder.name),
        ],
      ),
      childrenPadding: EdgeInsets.only(left: 16.0),
      children: [
        ...folder.subFolder.map((subFolder) => FolderWidget(folder: subFolder)).toList(),
        ...folder.lernFelder.map((lernfeld) => LernfeldWidget(lernfeld: lernfeld)).toList(),
      ],
    );
  }
}

class LernfeldWidget extends StatelessWidget {
  final Lernfeld lernfeld;

  LernfeldWidget({required this.lernfeld});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(Icons.lightbulb),
      title: Text(lernfeld.name),
      onTap: () {
        // Aktionen für Lernfeld
      },
    );
  }
}

class Folderlist_widget extends StatelessWidget {
  final List<ContentContainer> folders;

  Folderlist_widget({required this.folders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projektansicht'),
      ),
      // body: ListView(
      //   children: folders.map((folder) => FolderWidget(folder: folder)).toList(),
      // ),
    );
  }
}

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Folder> folders = [
      Folder(
        id: 1,
        name: 'Schulen',
        subFolder: [
          Folder(
            id: 2,
            name: 'GFN',
            subFolder: [],
            lernFelder: [
              Lernfeld(id: 3, name: 'Lernfeld 1 der Fachinformatiker', themen: []),
              Lernfeld(id: 4, name: 'Lernfeld 2 der Fachinformatiker', themen: []),
            ],
          ),
        ],
        lernFelder: [
          Lernfeld(id: 5, name: 'main.cc', themen: []),
          Lernfeld(id: 6, name: 'my_application.cc', themen: []),
          Lernfeld(id: 7, name: 'my_application.h', themen: []),
        ],
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test App'),
        ),
        body: Folderlist_widget(folders: folders),
      ),
    );
  }
}
