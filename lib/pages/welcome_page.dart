import 'package:ce_mobile/model/workspace.dart';
import 'package:ce_mobile/pages/editor_page.dart';
import 'package:ce_mobile/widgets/create_dialog.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
                    'Recent Projects',
                  )),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    ListTile(
                      tileColor: Colors.lightGreen[600],
                      title:
                          const Text('Recent #1', textAlign: TextAlign.center),
                      onTap: () {},
                    ),
                    ListTile(
                      tileColor: Colors.lightGreen[500],
                      title:
                          const Text('Recent #2', textAlign: TextAlign.center),
                      onTap: () {},
                    ),
                    ListTile(
                      tileColor: Colors.lightGreen[200],
                      title: Text('Recent #3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary)
                                  .color!)),
                      onTap: () {},
                    ),
                    ListTile(
                      tileColor: Colors.lightGreen[100],
                      title: Text('Recent #4',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary)
                                  .color!)),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
