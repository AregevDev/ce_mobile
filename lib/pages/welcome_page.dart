import 'dart:developer';

import 'package:ce_mobile/model/workspace.dart';
import 'package:ce_mobile/pages/editor_page.dart';
import 'package:ce_mobile/services/sembast_service.dart';
import 'package:ce_mobile/widgets/create_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final SembastService _service = SembastService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(48),
          child: Column(
            children: <Widget>[
              ShaderMask(
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    'CE Mobile',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  shaderCallback: (bounds) => const LinearGradient(colors: [
                        Color(0xff67c52a),
                        Color(0xff999999),
                      ]).createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8, top: 64),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                const CreateDialog()),
                        label: const Text('Create a New Workspace')),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ElevatedButton.icon(
                        icon: const Icon(Icons.link),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditorPage(workspace: Workspace('hello')))),
                        label: const Text('Import from Link')),
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.all(8),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Recent Workspaces',
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
              StreamBuilder(
                stream: _service.streamRecentWorkspaces(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final workspaces = snapshot.data;
                    if (workspaces != null) {
                      if (workspaces.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                              itemCount: workspaces.length,
                              itemBuilder: (context, index) {
                                final workspace = workspaces[index];

                                return ListTile(
                                  title: Text(
                                      '${workspace.name} - ${workspace.currentCompiler.name} - ${workspace.uuid}'),
                                  subtitle: Text(
                                      'Last modified: ${DateFormat('dd-MM-yyyy kk:mm').format(workspace.lastModified)}'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditorPage(
                                                workspace: workspace)));
                                  },
                                );
                              }),
                        );
                      } else {
                        return  Expanded(
                            child: Center(
                                child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.error)),
                          child: Text(
                            'You have no projects.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        )));
                      }
                    }
                  } else if (snapshot.hasError) {
                    log('Error: ${snapshot.error.toString()}');
                  }

                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
