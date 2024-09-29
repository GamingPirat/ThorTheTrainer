import 'package:flutter/material.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("State Change Demo")),
        body: ParentWidget(),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  final GlobalKey<_ChildWidgetState> _childKey = GlobalKey<_ChildWidgetState>();

  void _changeChildState() {
    _childKey.currentState?.updateText("Text updated from Parent");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _changeChildState,
          child: Text("Change Child State"),
        ),
        ChildWidget(key: _childKey),
      ],
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget({Key? key}) : super(key: key);

  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  String _text = "Initial Text";

  void updateText(String newText) {
    setState(() {
      _text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_text);
  }
}
