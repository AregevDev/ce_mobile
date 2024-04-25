import 'package:ce_mobile/consts.dart';
import 'package:ce_mobile/model/compiler.dart';
import 'package:ce_mobile/model/language.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

@jsonSerializable
class WorkspaceFile {
  String filename;
  String code;

  WorkspaceFile(this.filename, this.code);
}

@jsonSerializable
class Workspace {
  String uuid;

  String name;
  Compiler currentCompiler;
  Language currentLanguage;

  DateTime lastModified = DateTime.now();

  late List<WorkspaceFile> files;

  @JsonProperty(ignore: true)
  bool saveOnDisk;

  Workspace(this.name, {this.saveOnDisk = true}) : currentCompiler = defaultCompiler, currentLanguage = defaultLanguage, uuid = const Uuid().v4() {
    files = List.of([WorkspaceFile('main${currentLanguage.extensions.first}', '')]);
  }
}
