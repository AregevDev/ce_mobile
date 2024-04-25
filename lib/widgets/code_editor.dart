import 'package:ce_mobile/model/workspace.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeEditor extends StatefulWidget {
  const CodeEditor({super.key, required this.file});

  final WorkspaceFile file;

  @override
  State<CodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(text: widget.file.code);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 32,
          alignment: Alignment.centerLeft,
          color: Theme.of(context).colorScheme.onInverseSurface,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(widget.file.filename, style: GoogleFonts.jetBrainsMono()),
        ),
        SingleChildScrollView(
          child: CodeField(
            controller: _codeController,
            textStyle: GoogleFonts.jetBrainsMono(),
            background: Theme.of(context).colorScheme.background,
            cursorColor: Theme.of(context).colorScheme.primary,
            onChanged: (p0) {
              widget.file.code = _codeController.text;
            },
          ),
        ),
      ],
    );
  }
}
