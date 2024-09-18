import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/folder_types.dart';
import 'datenklassen/view_builder.dart';

class DrawerMenuWidget extends StatefulWidget {
  const DrawerMenuWidget({super.key});

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  late List<ContentContainer> contentcontainers;

  @override
  void initState() {
    contentcontainers = mok_lernfelder;
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
