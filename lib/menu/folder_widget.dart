import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/folder_types.dart';

import '../datenklassen/lernfeld.dart';

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
      title: Text(lernfeld.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Text('Platzhalter für ${lernfeld.name}'),
          ),
        );
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
