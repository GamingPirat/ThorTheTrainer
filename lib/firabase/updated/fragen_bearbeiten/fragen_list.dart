import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/a_db_service_fragen.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';
import 'package:lernplatform/firabase/updated/fragen_bearbeiten/frage_editor.dart';

class FragenList extends StatefulWidget {
  final int inhaltId;

  FragenList({
    required this.inhaltId,
  });

  @override
  _FragenListState createState() => _FragenListState();
}

class _FragenListState extends State<FragenList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kernfragen"),
      ),
      body: Column(
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: (){},
                  child: Text("neue Kernfrage")
              )
          ),
          SizedBox(height: 16,),
          if(true)
            Text("Hallo"),
          SizedBox(height: 16,),
          Expanded(
            child: FutureBuilder<List<DB_Frage>>(
              future: FrageDBService().getByInhaltID(widget.inhaltId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Keine Fragen verfügbar."));
                }

                final fragen = snapshot.data!;

                return ListView.builder(
                  itemCount: fragen.length,
                  itemBuilder: (context, index) {
                    final frage = fragen[index];

                    return FrageDetailEditor(frage: frage,);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
