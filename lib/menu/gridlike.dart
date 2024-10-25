import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const ExpandableWidget({required this.title, required this.children});

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool isHovering = false;

  void _setExpanded(bool value) {
    if (isHovering)
      Future.delayed(Duration(milliseconds: 1000),
        ()=> setState(() => isHovering = !isHovering));
    else
      setState(() => isHovering = !isHovering);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MouseRegion(
          onEnter: (_) => _setExpanded(true),
          onExit: (_) => _setExpanded(false),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Theme.of(context).brightness == Brightness.dark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.5),
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        if (isHovering)
          MouseRegion(
            onEnter: (_) => _setExpanded(true),
            onExit: (_) => _setExpanded(false),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,  // Maximale Breite
              children: widget.children
                  .map((child) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: child,
              ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('Expandable Widget Test')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
    children:[ExpandableWidget(
              title: 'Hover to Expand',
              children: [
                ExpandableWidget(
                  title: 'Hover to Expand',
                  children: [
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                  ],
                ),
                ExpandableWidget(
                  title: 'Hover to Expand',
                  children: [
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                  ],
                ),
                ExpandableWidget(
                  title: 'Hover to Expand',
                  children: [
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                    ExpandableWidget(
                      title: 'Hover to Expand',
                      children: [
                        Container(
                          color: Colors.red,
                          height: 50,
                          child: Center(child: Text('Widget 1')),
                        ),
                        Container(
                          color: Colors.blue,
                          height: 50,
                          child: Center(child: Text('Widget 2')),
                        ),
                        Container(
                          color: Colors.yellow,
                          height: 50,
                          child: Center(child: Text('Widget 3')),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),]
          ),),
        ),
      ),
    );
  }
}

void main() {
  runApp(TestApp());
}
