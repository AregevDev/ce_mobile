
import 'package:ce_mobile/isar_service.dart';
import 'package:ce_mobile/model/workspace.dart';
import 'package:ce_mobile/pages/editor_page.dart';
import 'package:flutter/material.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  late TextEditingController _controller;
  bool _saveOnDisk = true;
  final IsarService service = IsarService();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Workspace'),
      content: SizedBox(
        width: 384,
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Save on Disk'),
                Switch(
                  thumbIcon: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Icon(Icons.check);
                    }

                    return null;
                  }),
                  value: _saveOnDisk,
                  onChanged: (value) => {
                    setState(() {
                      _saveOnDisk = value;
                    })
                  },
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              Workspace w = Workspace(_controller.text);
              Future.wait([service.saveWorkspace(w)]);

              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditorPage(workspace: w),
                  ));
            },
            child: const Text('Create'))
      ],
    );
  }
}
