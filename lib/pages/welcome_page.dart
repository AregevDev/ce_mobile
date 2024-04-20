import 'package:ce_mobile/isar_service.dart';
import 'package:ce_mobile/model/workspace.dart';
import 'package:ce_mobile/pages/editor_page.dart';
import 'package:ce_mobile/widgets/create_dialog.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final IsarService isarService = IsarService();
  late Future<List<Workspace>> _recentProjectsFuture;

  @override
  void initState() {
    super.initState();
    _recentProjectsFuture = isarService.getRecentProjects();
  }

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
                                    const CreateDialog())
                            .then((value) => setState(() {
                                  _recentProjectsFuture =
                                      isarService.getRecentProjects();
                                })),
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
                  child: FutureBuilder<List<Workspace>>(
                future: _recentProjectsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Projects Found'));
                    }

                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(
                                'Last Modified: ${snapshot.data![index].lastModified}'),
                            onTap: () {},
                          );
                        });
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
