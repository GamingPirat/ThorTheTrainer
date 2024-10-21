import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/folder_types.dart';
import 'package:lernplatform/datenklassen/thema.dart';

import '../datenklassen/lernfeld.dart';

class LernfeldWidget extends StatefulWidget {
  final Lernfeld lernfeld;

  LernfeldWidget({required this.lernfeld}) : super(key: ValueKey(lernfeld.id));

  @override
  _LernfeldWidgetState createState() => _LernfeldWidgetState();
}

class _LernfeldWidgetState extends State<LernfeldWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    print("Rendering LernfeldWidget: ${widget.lernfeld.name}, Expanded: $isExpanded");

    return ExpansionTile(
      title: Text(widget.lernfeld.name),
      initiallyExpanded: isExpanded,
      onExpansionChanged: (expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      children: widget.lernfeld.themen.map((thema) {
        return ThemaWidget(thema: thema);
      }).toList(),
    );
  }
}




class ThemaWidget extends StatefulWidget {
  final Thema thema;

  ThemaWidget({required this.thema});

  @override
  State<ThemaWidget> createState() => _ThemaWidgetState();
}

class _ThemaWidgetState extends State<ThemaWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.thema.name),
      initiallyExpanded: isExpanded,
      onExpansionChanged: (expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      children: widget.thema.subthemen.map((subThema) {
        return ListTile(
          title: Text(subThema.name),
        );
      }).toList(),
    );
  }
}
