import 'package:flutter/material.dart';
import 'folder_types.dart';

class LernfeldPage extends StatelessWidget {
  Lernfeld lernfeld;

  LernfeldPage({super.key, required this.lernfeld});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Text(lernfeld.name)
    );
  }
}

