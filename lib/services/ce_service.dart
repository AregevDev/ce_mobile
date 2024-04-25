import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';

import '../consts.dart';
import '../model/workspace.dart';
import 'package:http/http.dart' as http;

@jsonSerializable
class CompilerOptions {
  @JsonProperty(name: 'skipAsm')
  final bool skipASM = false;
  final bool executorRequest = false;
}

@jsonSerializable
class CompilerFilters {
  bool binary = false;
  bool binaryObject = false;
  bool commentOnly = true;
  bool demangle = true;
  bool directives = true;
  bool execute = false;
  bool intel = true;
  bool labels = true;
  bool libraryCode = false;
  bool trim = false;
  bool debugCalls = false;
}

@jsonSerializable
class CompilerTools {
  final String id;
  final String args;

  CompilerTools(this.id, this.args);
}

class CompilerLibraries {
  String id;
  String name;

  CompilerLibraries(this.id, this.name);
}

@jsonSerializable
class Options {
  String userArguments;
  CompilerOptions? compilerOptions;
  CompilerFilters? filters;
  List<CompilerTools>? tools;
  List<CompilerLibraries>? libraries;

  Options(
      {this.userArguments = '',
      this.compilerOptions,
      this.filters,
      this.tools,
      this.libraries});
}

@jsonSerializable
class CompileRequest {
  String source;
  Options options;
  String? lang;
  bool allowStoreCodeDebug;

  CompileRequest(
      {required this.source,
      required this.options,
      this.lang,
      this.allowStoreCodeDebug = true});
}

class CEService {
  static Future<String> compile(Compiler cc, CompileRequest request) async {
    final json = JsonMapper.serialize(request);

    final response = await http.post(
        Uri.parse('$defaultUrl$compileEndpoint/g132/compile'),
        body: json,
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: 'application/json',
        });

    if (response.statusCode == HttpStatus.ok) {
      return response.body;
    } else {
      throw Exception('Failed to compile: ${response.statusCode}: ${response.body}');
    }
  }
}
