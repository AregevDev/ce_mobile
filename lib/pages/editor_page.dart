import 'package:ce_mobile/model/workspace.dart';
import 'package:flutter/material.dart';

class EditorPage extends StatefulWidget {
  final Workspace workspace;

  const EditorPage({super.key, required this.workspace});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Editor [${widget.workspace.name}]'),
      ),
      body: Center(
        child: Text('Current project: ${widget.workspace.name}'),
      ),
    );
  }
}
