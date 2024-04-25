import 'dart:developer';

import 'package:ce_mobile/model/workspace.dart';
import 'package:ce_mobile/services/ce_service.dart';
import 'package:ce_mobile/services/sembast_service.dart';
import 'package:ce_mobile/widgets/code_editor.dart';
import 'package:flutter/material.dart';

class EditorPage extends StatefulWidget {
  final Workspace workspace;

  const EditorPage({super.key, required this.workspace});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final SembastService _service = SembastService();

  // late PageController _pageController;

  final int _pageCount = 1;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController();
  // }

  // void _addPage() {
  //   setState(() {
  //     _pageCount++;
  //   });
  // }
  //
  // void _removePage(BuildContext context) {
  //   if (_pageCount > 1) {
  //     setState(() {
  //       _pageCount--;
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Last page')));
  //   }
  // }
  //
  // void _navigateToPage(int index) {
  //   _pageController.animateToPage(index,
  //       duration: const Duration(microseconds: 300), curve: Curves.easeIn);
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        widget.workspace.lastModified = DateTime.now();
        log(widget.workspace.currentCompiler.name);
        if (widget.workspace.saveOnDisk) {
          Future.wait([_service.saveWorkspace(widget.workspace)]);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Editor [${widget.workspace.name}] (${widget.workspace.uuid})'),
        ),
        body: PageView.builder(
          itemCount: _pageCount,
          itemBuilder: (context, index) {
            return CodeEditor(file: widget.workspace.files[index]);
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              final future = CEService.compile(
                  widget.workspace.currentCompiler,
                  CompileRequest(
                      source: widget.workspace.files.first.code,
                      options: Options()));

              showDialog(context: context, builder: (context) {
                return FutureBuilder(future: future, builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AlertDialog(
                      title: const Text('Compilation Result'),
                      content: SingleChildScrollView(child: Text(snapshot.data!)),
                    );
                  } else if (snapshot.hasError) {
                    log(snapshot.error.toString());
                  }

                  return const Center(child: CircularProgressIndicator());
                });
              });
            },
            label: const Text('Run'),
            icon: const Icon(Icons.play_arrow)),
      ),
    );
  }
}
