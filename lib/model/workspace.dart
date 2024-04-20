import 'package:ce_mobile/consts.dart';

import 'language.dart';
import 'compiler.dart';

class Workspace {
  String name;
  Compiler currentCompiler = defaultCompiler;
  Language currentLanguage = defaultLanguage;

  Workspace(this.name);
}
