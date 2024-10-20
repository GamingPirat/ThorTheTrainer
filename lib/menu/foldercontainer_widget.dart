import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/folder_types.dart';
import 'package:lernplatform/session.dart';
import '../datenklassen/frage.dart';

class FolderContainer_Widget extends StatefulWidget {
  const FolderContainer_Widget({super.key});

  @override
  State<FolderContainer_Widget> createState() => _FolderContainer_WidgetState();
}

class _FolderContainer_WidgetState extends State<FolderContainer_Widget> {
  late List<ContentCarrier> contentcontainers;

  @override
  void initState() {
    contentcontainers = Session().user.usersLernfelder;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contentcontainers.length, // Anzahl der Elemente in der Liste
      itemBuilder: (context, index) {
        final content = contentcontainers[index];
        return ElevatedButton(
          onPressed: () {
          },
          child: Text(content.name), // Zeigt den Titel des ContentContainers an
        );
      },
    );
  }
}
