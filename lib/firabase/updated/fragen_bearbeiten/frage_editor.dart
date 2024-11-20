import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lernplatform/datenklassen/a_db_service_fragen.dart';
import 'package:lernplatform/datenklassen/db_frage.dart';

class FrageDetailEditor extends StatefulWidget {

  DB_Frage frage;
  Function? onTap;

  FrageDetailEditor({
    required this.frage,
    this.onTap,
  });

  @override
  _FrageDetailEditorState createState() => _FrageDetailEditorState();
}

class _FrageDetailEditorState extends State<FrageDetailEditor> {
  late TextEditingController textController;
  late TextEditingController punkteController;

  final ValueNotifier<bool> isExpandedNotifier =
  ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.frage.text);
    punkteController = TextEditingController(text: widget.frage.punkte.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isExpandedNotifier,
      builder: (context, isExpanded, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap:  () {
                widget.onTap == null
                    ? isExpandedNotifier.value = !isExpandedNotifier.value
                    : widget.onTap
                ;
              },
              child: ListTile(
                leading: IconButton(
                    onPressed: ()=> isExpandedNotifier.value = !isExpandedNotifier.value,
                    icon: Icon( isExpanded ? Icons.expand_less : Icons.expand_more)),
                title: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: punkteController,
                        decoration: const InputDecoration(
                            labelText: "Punkte"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                            labelText: "Frage Text"),
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        final aktualisierteAntworten =
                        widget.frage.antworten.asMap().entries.map(
                              (entry) => entry.value.copyWith(
                            text: entry.value.text,
                            erklaerung: entry.value.erklaerung,
                          ),
                        );

                        await FrageDBService().updateFrage(
                          widget.frage.copyWith(
                            text: textController.text,
                            punkte: int.tryParse(
                                punkteController.text) ??
                                widget.frage.punkte,
                            antworten: aktualisierteAntworten
                                .toList(), // Umwandlung in Liste
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Frage ${widget.frage.nummer} gespeichert."),
                          ),
                        );
                      },
                      child: const Text("Speichern"),
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.frage.antworten.asMap().entries.map((entry) {
                      final antwortIndex = entry.key;
                      final antwort = entry.value;

                      final antwortTextController =
                      TextEditingController(text: antwort.text);
                      final erklaerungController =
                      TextEditingController(
                          text: antwort.erklaerung);

                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          title: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: antwortTextController,
                                  onChanged: (value) {
                                    antwort.text = value;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Antwort",
                                  ),
                                ),
                              ),
                              Checkbox(
                                value: antwort.isKorrekt,
                                onChanged: (value) {
                                  setState(() {
                                    antwort.isKorrekt = value ?? false;
                                  });
                                },
                              ),
                            ],
                          ),
                          subtitle: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(32,0,0,0),
                              child: TextFormField(
                                controller: erklaerungController,
                                onChanged: (value) {
                                  antwort.erklaerung = value;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Erklärung",
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
